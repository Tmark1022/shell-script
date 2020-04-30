#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 09:03:21 PM CST
#	> File Name	: test10.sh
#	> Description	: 
#*************************************************************************

hello() {
	if [ "$1" != "y" ] && [ "$1" != "Y" ]; then
		return 0	
	else
		return 1
	fi
}

while hello $yn
do	
	read -p "choice : " yn
done

yn2="Y"
until hello $yn2
do	
	read -p "choice 2 : " yn2
done


declare -i idx=0
declare -i sum=0

while [ $idx -le 100 ]
do
	sum=$sum+$idx
	idx=$idx+1
done

echo "sum is $sum"
