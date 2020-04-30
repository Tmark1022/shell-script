#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 11:28:54 AM CST
#	> File Name	: test4.sh
#	> Description	: 
#*************************************************************************

read -p "input filename : " filename

[ -z $filename ] && echo -e "must input filename" && exit 1

#exit
[ ! -e $filename ] && echo -e "file does not exits" && exit 2

# TYPE
[ -f $filename ] && echo -e "regular file"
[ -d $filename ] && echo -e "directory"

# privilege
permission=""
[ -r $filename ] && permission="$permission read" 
[ -w $filename ] && permission="$permission write" 
[ -x $filename ] && permission="$permission execute" 

echo -e "the permission is $permission"


