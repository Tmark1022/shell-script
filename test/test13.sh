#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Tue 09 Jun 2020 09:18:51 PM CST
#	> File Name	: test13.sh
#	> Description	: 脚本调用参数传递问题 和 函数调用参数问题
#*************************************************************************

foo() 
{	
	echo -e "\n-----------begin"
	echo "name $0"
	echo "argc $#"
	echo "args $@"
	echo "pid $$"
	echo -e "-----------end\n"
}


echo "name $0"
echo "argc $#"
echo "args $@"
echo "pid $$"

fd() {
	echo "hello world"
}

set -x 
foo a b c e f fd 19 77 $@		# 解析器在这里吧fd解析为一个字符串参数， 并不是一个函数
fd 19 77
set +x

