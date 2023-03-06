#!/bin/sh

PATTERN=$(date +"%m,%d,")
FILE=~/Code/lnr/lnr.csv
TODAY=$(grep $PATTERN $FILE)

echo_prayer_time() {
    echo $(echo $TODAY | awk '{split($0,times,","); print times['$(($1+3))']}')
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

[ $# -eq 0 ] && # if no argument is used
    print_times all || # print all praying times
    print_times $1 # else print the indexed praying time

# TODO:
    # add default time based on current time
