#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 11:52:25 AM CST
#	> File Name	: test6.sh
#	> Description	: 
#*************************************************************************

input=$1

if [ "$input" == "" ]; then 
	read -p "please input a name : " input
fi

if [ "$input" == "" ]; then
	echo "hello sb"
elif [ "$input" == "xx" ] || [ "$input" == "oo" ]; then
	echo "hello admin"
elif [ "$input" == "hello" ]; then 
	echo "hello *"
else 
	echo "hello $input"
fi
