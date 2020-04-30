#!/bin/bash -x 
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Thu 30 Apr 2020 10:13:43 PM CST
#	> File Name	: test12.sh
#	> Description	: 
#*************************************************************************

sum=0
num=10
for((i=0;i<=$num;i++))
do
	sum=$(($sum+$i))
done

echo -e "sum is $sum"
