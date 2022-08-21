#!/usr/bin/env bash
#===============================================================================
#
#          FILE: difference.sh
#
#         USAGE: ./difference.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Echo Barros (), shhwip@gmail.com
#  ORGANIZATION: Weber State University
#       CREATED: 08/21/2022 12:22:04 PM
#      REVISION:  ---
#===============================================================================

# set -o nounset                              # Treat unset variables as an error
# shopt -s extglob                                # Extended pattern matching

printLine() {
    numLine=64
    while [ $numLine -gt 1 ]
    do
        printf "*"
        (( numLine-- ))
    done
    printf '\n'
}

help(){
    printLine
    # each of the following strings cannot be longer than 60 char
    strings=("Usage: difference file1 file2"
    "This script determines which lines from file1 are unique"
)
    printf "* %-60s *\n" "${strings[@]}"
    printLine
    exit 0
}

if [[ $1 == "--help" ]]
then
    help
fi

while read -r line;
do
    while read -r line2;
    do
        if [[ "$line" == "$line2" ]]
        then
            continue 2
        fi
    done < $2
echo -e "$line"
done < $1


exit 0

