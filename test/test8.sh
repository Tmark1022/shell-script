#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 08:28:39 PM CST
#	> File Name	: test8.sh
#	> Description	: 
#*************************************************************************

case $1 in 
	"1"|"10"|"11")
		echo "hello python"
		;;
	2)
		echo "hello cpp"
		;;
	"3")
		echo "hello c"
		;;
	*)
		echo "usage $0 {1|2|3}"
		;;
esac
