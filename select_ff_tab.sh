#!/bin/bash

# Based on https://man.archlinux.org/man/community/rofi/rofi-script.5.en
# Use by calling this: rofi -show tabs -modes "tabs:select_ff_tab.sh" 

if ((ROFI_RETV == 0)); then
  tab_list=$(bt list | tr '\t' ' ')
  tab_list_base64=$(echo "$tab_list" | base64 -w 0)
  echo -en "\0data\x1f$tab_list_base64\n"
else
  tab_list=$(echo "$ROFI_DATA" | base64 -d)
fi

if [[ "$@" != "" ]]; then
  sel_tab=$(echo "$@" | sed 's/ $//g')
  tab_id=$(echo "$tab_list" | grep -m1 "$sel_tab" | awk '{print $1}')
  bt activate --focused "$tab_id"
  
  # if ! [ -z "$sel_tab" ]; then
  #   tab_id=$(echo "$tab_list" | grep -m1 "$sel_tab" | awk '{print $1}')
  #   bt activate --focused "$tab_id"
  # fi

  exit 0
fi

tab_list_clean=$(echo "$tab_list" | awk '{for (i = 2; i <= NF; i++) {printf "%s ", $i}; printf "\n"}')
# Output list to rofi
echo "$tab_list_clean"

# awk '{$1=""; print $0}')

# sel_tab=$(echo "$tab_list_clean" | rofi -dmenu -p "Select firefox tab")
# if ! [ -z "$sel_tab" ]; then
#   tab_id=$(echo "$tab_list" | grep -m1 "$sel_tab" | awk '{print $1}')
#   bt activate --focused "$tab_id"
# fi


