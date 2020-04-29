#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Wed 29 Apr 2020 12:04:35 PM CST
#	> File Name	: test3.sh
#	> Description	: 
#*************************************************************************

read -p "input filename : " filename

test -z $filename && echo -e "must input filename" && exit 1

#exit
test ! -e $filename && echo -e "file does not exits" && exit 2

# TYPE
test -f $filename && echo -e "regular file"
test -d $filename && echo -e "directory"

# privilege
permission=""
test -r $filename && permission="$permission read" 
test -w $filename && permission="$permission write" 
test -x $filename && permission="$permission execute" 

echo -e "the permission is $permission"


