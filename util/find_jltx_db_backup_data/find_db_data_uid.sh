#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Wed 01 Jul 2020 09:41:04 AM CST
#	> File Name	: find_db_data_uid.sh
#	> Description	: 找uid对应的文件 
#*************************************************************************

usage() {
	echo "usage : sh $0 uid search_dir"
}

if [ $# -ne 2 ]; then
	usage
	exit 1
fi

uid=$1
search_dir=$2
ls -alF "$search_dir"| awk 'BEGIN {FS=" "} {print $9}' | sed -n '/^back/p' | sed -E 's/(^.*\[([0-9]+)_([0-9]+)\].*gz$)/\2 \3 \1/' | awk -v uid="$uid" 'BEGIN {FS=" "} {if (uid >= $1 && uid <= $2) print $3}'

