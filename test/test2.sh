#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Wed 29 Apr 2020 10:56:47 AM CST
#	> File Name	: test2.sh
#	> Description	: 数值运算 
#*************************************************************************

echo -e "first method"
read -p "first number : " num1
read -p "second number : " num2
total=$(($num1*$num2))			# 注意里边的括号不能省略
echo -e "total is $total\n"

echo -e "second method"
read -p "first number : " num1
read -p "second number : " num2
declare -i total=$num1*$num2
echo -e "total is $total\n"
