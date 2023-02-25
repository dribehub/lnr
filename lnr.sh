#!/bin/sh

PATTERN=$(date +"%m,%d")
FILE=~/Code/lnr/lnr.csv

a_3=$(grep $PATTERN $FILE | awk '{split($0,times,","); print times[3]}')
a_4=$(grep $PATTERN $FILE | awk '{split($0,times,","); print times[4]}')
a_5=$(grep $PATTERN $FILE | awk '{split($0,times,","); print times[5]}')
a_6=$(grep $PATTERN $FILE | awk '{split($0,times,","); print times[6]}')
a_7=$(grep $PATTERN $FILE | awk '{split($0,times,","); print times[7]}')
a_8=$(grep $PATTERN $FILE | awk '{split($0,times,","); print times[8]}')

print_times() {
    echo "Imsaku: $a_3"
    echo "Sabahu: $a_4"
    echo "Yleja: $a_5"
    echo "Ikindia: $a_6"
    echo "Akshami: $a_7"
    echo "Jacia: $a_8"
}

if [ $# -eq 0 ]; then
    print_times
else
    case $1 in
        imsak|0)    echo "Imsaku: $a_3";;
        sabah|1)    echo "Sabahu: $a_4";;
        yle|2)      echo "Yleja: $a_5";;
        ikindi|3)   echo "Ikindia: $a_6";;
        aksham|4)   echo "Akshami: $a_7";;
        jaci|5)     echo "Jacia: $a_8";;
        *)          print_times;;
    esac
fi
