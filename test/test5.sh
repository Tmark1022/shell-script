#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 11:39:10 AM CST
#	> File Name	: test5.sh
#	> Description	: 
#*************************************************************************

echo "100 argument is : ${100}"

if [ "${#}" -lt 2 ]; then
	echo "please input more arguments"
	exit 127
fi

shift	# change parameters position , default 1
echo "file name : $0"
echo "argument cnt : $#"
echo "first argument is : $1"

echo "all arguments 1 is : $@"
echo "all arguments 2 is : $*"

shift 3 
echo "file name : $0"
echo "argument cnt : $#"
echo "first argument is : $1"

echo "all arguments 1 is : $@"
echo "all arguments 2 is : $*"

# set | less
