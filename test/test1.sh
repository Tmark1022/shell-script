#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Wed 29 Apr 2020 10:44:53 AM CST
#	> File Name	: test1.sh
#	> Description	: 创建文件名demo
#*************************************************************************

read -p "input filename prefix : " prefix
dtime=$(date +%Y-%m-%d_%H-%M-%S)
filename=${prefix}"_"${dtime}

touch $filename
