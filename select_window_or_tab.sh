#!/bin/bash

# Based on the ideas from:
# https://adrianpopagh.blogspot.com/2020/12/quick-launcher-with-firefox-tabs-rofi.html

# Requirements:
#   *   brotab
#   *   brotab browser extension (for firefox or chromium)
#   *   wmctrl
#   *   xprop

# To be used with rofi:
#  rofi -show-icons -show tabs -modes "tabs:./select_window_or_tab.sh"

################################################

main()
{
  if ((ROFI_RETV == 0)); then
    win_list=$(get_win_list_except_firefox)
    win_list_base64=$(echo -en "$win_list" | base64 -w 0)
    tab_list=$(bt list | awk '{
      printf "%s ", $1;                            // Tab ID
      printf "firefox ";
      for (i = 2; i <= NF; i++) {printf "%s ", $i} // Tab title
      printf "\n";
    }')
    tab_list_base64=$(echo "$tab_list" | base64 -w 0)
    echo -en "\0data\x1f$win_list_base64 $tab_list_base64\n"
  else
    data=($ROFI_DATA)

    win_list=$(echo "${data[0]}" | base64 -d)
    tab_list=$(echo "${data[1]}" | base64 -d)
  fi
  
  # Entry selection
  if [[ "$@" != "" ]]; then
    if [[ "$ROFI_INFO" == 0x* ]]; then
      wmctrl -ia "$ROFI_INFO"
    else
      bt activate --focused "$ROFI_INFO"
    fi
    exit 0
  fi

  # Sort by title
  list=$(echo -e "$win_list\n$tab_list" | sort -k 3)
  
  # Output list of entries
  echo -en "$list" | awk '{
    printf "     ";
    printf("%-10s ", substr($2, 0, 10));         // Entry class
    printf "     ";
    for (i = 3; i <= NF; i++) {printf "%s ", $i} // Entry title
    printf "\0icon\x1f"$2;                       // Entry icon
    printf "\x1finfo\x1f"$1;                     // Entry ID
    printf "\n"
  }'
}

get_win_list_except_firefox()
{
  ### Find all windows
  for win_id in $(xprop -root | grep '_NET_CLIENT_LIST(WINDOW)' | grep -o '0x[0-9a-zA-Z]\+'); do
    #                      Select only values inside double quotes ("...")
    #                                                  vvvvvvvvvvvvvvvv
    win_name=$( xprop -id $win_id WM_NAME  | grep -Po '(?<=")[^"]*(?=")' | tail -1)
    win_class=$(xprop -id $win_id WM_CLASS | grep -Po '(?<=")[^"]*(?=")' | tail -1)

    # Skip firefox windows
    [[ $win_class == "firefox" ]] && continue

    win_class=$(echo "$win_class" | tr 'A-Z' 'a-z')
    echo -e "$win_id \t $win_class \t $win_name"
  done
}

main "$@"


