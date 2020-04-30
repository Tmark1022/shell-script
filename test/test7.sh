#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 12:10:48 PM CST
#	> File Name	: test7.sh
#	> Description	: 
#*************************************************************************

read -p "input date (yyyymmdd): " datestr

nowstr=$(date +%Y%m%d)
declare -i now=$(date --date "$nowstr" +%s)
declare -i input=$(date --date "$datestr" +%s)
declare -i diff=$(($input-$now))

declare -i passDays=$(($diff/60/60/24))
echo "passDays : $passDays"

