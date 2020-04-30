#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 08:37:17 PM CST
#	> File Name	: test9.sh
#	> Description	: 
#*************************************************************************

function hello() {
	echo "hello $1" 
	return 0
	echo "lalalala $1" 

}

if hello $1; then
	echo "true"
else 
	echo "false"
fi

