#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 09:34:32 PM CST
#	> File Name	: test11.sh
#	> Description	: 
#*************************************************************************

users=$(cat /etc/passwd | awk 'BEGIN{FS=":"}{print $1}')

for user in $users
do
	id $user
done


# ping 
head=192.168.12.
for end in $(seq 1 255)
do
	ping -c 1 -w 1 $head$end 1>/dev/null 2>&1 && res=1 || res=0
	if [ "$res" == "1" ]; then 
		echo "$head$end, done"
	else
		echo "$head$end, timeout"
	fi
done
