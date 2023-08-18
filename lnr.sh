#!/bin/sh

PATTERN=$(date +"%m,%d,")
FILE=~/Code/lnr/lnr.csv
TODAY=$(grep $PATTERN $FILE)
COLORED_OUTPUT=1

highlight_if_next() {
    CURRENT_TIME=$(date +"%H:%M")
    # CURRENT_TIME="21:00"
    if [[ "$CURRENT_TIME" > "$1" ]] ; then
        echo "$PRAYER_TIME"
    else
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        NO_COL='\033[0m'
        PRAYER_TIME_S=$(date -j -f "%H:%M" $PRAYER_TIME "+%s")
        CURRENT_TIME_S=$(date -j -f "%H:%M" $CURRENT_TIME "+%s")
        DIFF=$((($PRAYER_TIME_S - $CURRENT_TIME_S)))
        DIFF=$(date -j -f "%s" $DIFF "+%H:%M")
        echo "${GREEN}${PRAYER_TIME}${RED} (-${DIFF})${NO_COL}"
    fi
}

echo_prayer_time() {
    PRAYER_TIME=$(echo $TODAY | awk '{split($0,times,","); print times['$(($1+3))']}')
    [ $COLORED_OUTPUT -eq 1 ] && # if output is colored
    highlight_if_next $PRAYER_TIME || # highlight next prayer time
    echo $PRAYER_TIME # else print output as is
}

print_times() {
    case $1 in
        0) echo "Imsaku: $(echo_prayer_time 0)";;
        1) echo "Sabahu: $(echo_prayer_time 1)";;
        2) echo "Yleja: $(echo_prayer_time 2)";;
        3) echo "Ikindia: $(echo_prayer_time 3)";;
        4) echo "Akshami: $(echo_prayer_time 4)";;
        5) echo "Jacia: $(echo_prayer_time 5)";;
        *) for i in {0..5}; do print_times $i; done;;
    esac
}

if [ $# -eq 0 ]; then # if no argument is used
    print_times all # print all praying times
else
    if [ $1 == "--no-color" ]; then
        COLORED_OUTPUT=0
        shift
    fi
    print_times $1 # else print the indexed praying time
fi
