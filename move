#!/bin/bash

export LD_LIBRARY_PATH="$HOME/opt/lib:$HOME/opt/usr/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/opt/bin:$HOME/opt/usr/bin:$PATH"

if [[ $# -lt 1 ]]; then
  echo "$0 direction"
  echo " Direction can be (R || U || L || D)"
  exit
fi

# Since all distances are integer values, we scale it by $SCALE to decrease precision loss
SCALE=10000

#### TODO: Fix obvious deadlock ocurring here
# # Wait for other same processes to finish
# while ! killall -0 $(basename $0) 2>/dev/null
# do
#   sleep 0.25
# done

DIREC=$1

# TODO: Check if direction provided by user is in "RULD"

getCurrentWindow()
{
  printf "0x%08x\n" $(xdotool getwindowfocus)
}

min()
{
  (($1 < $2)) && echo $1 || echo $2
}
max()
{
  (($1 > $2)) && echo $1 || echo $2
}

# START_TIME_S=$SECONDS
# START_TIME_NS=$(date +%N)
# getSecondsPassed()
# {
#   CUR_S=$SECONDS
#   CUR_NS=$(date +%N)
#   echo "scale=3; ($CUR_S + $CUR_NS/10^9) - ($START_TIME_S + $START_TIME_NS/10^9)" | bc -l
# }

###
# $1 geometry_1
# $2 geometry_2
# $3 direction (right, up, left, down)
windowDistance()
{
  if [[ $3 == "L" ]]; then
    echo $(windowDistance "$2" "$1" "R")
    return
  fi
  if [[ $3 == "U" ]]; then
    echo $(windowDistance "$2" "$1" "D")
    return
  fi

  ################################################

  eval "$1"
  X1_LEFT=$X
  X1_RIGHT=$((X+WIDTH))
  Y1_TOP=$Y
  Y1_BOTTOM=$((Y+HEIGHT))

  X1_CENTER=$((X+WIDTH/2))
  Y1_CENTER=$((Y+HEIGHT/2))

  ################################################

  eval "$2"
  X2_LEFT=$X
  X2_RIGHT=$((X+WIDTH))
  Y2_TOP=$Y
  Y2_BOTTOM=$((Y+HEIGHT))

  X2_CENTER=$((X+WIDTH/2))
  Y2_CENTER=$((Y+HEIGHT/2))

  ################################################
  INTERSEC=0

  if [[ $3 == "R" ]]; then
    [[ $Y2_TOP -ge $Y1_BOTTOM ]] && echo -1 && return
    [[ $Y2_BOTTOM -le $Y1_TOP ]] && echo -1 && return
    [[ $X2_CENTER -le $X1_CENTER ]] && echo -1 && return
    INTERSEC=$(( $(min Y1_BOTTOM Y2_BOTTOM) - $(max Y1_TOP Y2_TOP) ))
    (( INTERSEC * 100 / HEIGHT < 10 )) && echo -1 && return
    # echo $(( (X2_CENTER - X1_CENTER) ))
    echo $(( (X2_LEFT - X1_RIGHT) ))
  fi
  if [[ $3 == "D" ]]; then
    [[ $X2_RIGHT -le $X1_LEFT ]] && echo -1 && return
    [[ $X2_LEFT -ge $X1_RIGHT ]] && echo -1 && return
    [[ $Y2_CENTER -le $Y1_CENTER ]] && echo -1 && return
    INTERSEC=$(( $(min X1_RIGHT X2_RIGHT) - $(max X1_LEFT X2_LEFT) ))
    echo $INTERSEC > /dev/stderr
    (( INTERSEC * 100 / WIDTH < 10 )) && echo -1 && return
    # echo $(( (Y2_CENTER - Y1_CENTER) ))
    echo $(( (Y2_TOP - Y1_BOTTOM) ))
  fi
}

# TODO: $2 == -1 is sticked, $2 == 0 is first desktop.
# How to get current desktop id?
getNonsystemWindows()
{
  cur_desktop=$(wmctrl -d | grep \* | awk '{print $1}')
  wmctrl -l | awk "{if (\$2 == $cur_desktop) {print \$1}}"
}

CUR_WIN=$(getCurrentWindow)

GEOM_1=$(xdotool getwindowgeometry --shell $CUR_WIN)

min_dist=-1
chosen_id=-1

wins=$(getNonsystemWindows)
for win_id in ${wins[@]}
do
  (($win_id == $CUR_WIN)) && continue
  xwininfo -id $win_id | grep -q "IsUnMapped" && continue

  GEOM_2=$(xdotool getwindowgeometry --shell $win_id)
  [[ ${#DEBUG} -gt 0 ]] && xdotool getwindowname $win_id
  dist=$(windowDistance "$GEOM_1" "$GEOM_2" "$DIREC")

  (( $dist < 0 )) && continue

  if (($chosen_id == -1 || $dist < $min_dist)); then
    min_dist=$dist
    chosen_id=$win_id
  fi
done

# echo "Chosen $chosen_id"
# xdotool getwindowname $chosen_id

(($chosen_id != -1)) && wmctrl -ia $chosen_id

