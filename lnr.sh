#!/bin/sh

PATTERN=$(date +"%m,%d")
FILE=~/Code/lnr/lnr.csv

TODAY=$(grep $PATTERN $FILE)

echo_prayer_time() {
    echo $(echo $TODAY | awk '{split($0,times,","); print times['$(($1+3))']}')
}

prayer_times=(
    $(echo_prayer_time 0)
    $(echo_prayer_time 1)
    $(echo_prayer_time 2)
    $(echo_prayer_time 3)
    $(echo_prayer_time 4)
    $(echo_prayer_time 5)
)

print_times() {
    case $1 in
        imsak|0)    echo "Imsaku: ${prayer_times[0]}";;
        sabah|1)    echo "Sabahu: ${prayer_times[1]}";;
        yle|2)      echo "Yleja: ${prayer_times[2]}";;
        ikindi|3)   echo "Ikindia: ${prayer_times[3]}";;
        aksham|4)   echo "Akshami: ${prayer_times[4]}";;
        jaci|5)     echo "Jacia: ${prayer_times[5]}";;
        *)          print_times 0; print_times 1; print_times 2; print_times 3; print_times 4; print_times 5;;
    esac
}

[ $# -eq 0 ] && print_times all || print_times $1
