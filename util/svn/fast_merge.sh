#!/bin/bash
dtime=$(date +%Y-%m-%d_%H-%M-%S)
tmpname="tmp_"${dtime}
svntmp="tmp_svn_"${dtime}

usage() {
	echo "usage : sh $0 argv1:argv2 username from_url"
	echo "eg."
	echo "	sh  $0 '{2020-05-15 00:00:00 +0800}':HEAD mml1003 https://192.168.0.3/qtz/coc/program/server/logic/trunk"
	echo -e "\nparams"
	echo "	@argv1:argv2	: Implies the range of searching log"
	echo "			A revision argument can be one of:"             
	echo "			NUMBER	revision number"                
	echo "			{DATE}	revision at start of the date,"  
	echo "			HEAD	latest in repository"           
	echo "			BASE	base rev of item's working copy"
	echo "			COMMITTED  last commit at or before BASE"  
	echo "			PREV	revision just before COMMITTED"
	echo "	@username	: username, 'all' means every commits from argv1 to argv2"
	echo "	@from_url	: svn url"
}

if [ $# -ne 3 ]; then
	usage
	exit 1
fi

if [ ! -d module ]; then 
	echo "failed --> 请在程序主目录中使用"
	exit 1
fi

range=$1
username=$2
fromUrl=$3
svn --username=$username log -r "$range" $fromUrl > $svntmp

if [ $? -ne 0 ]; then 
	echo "call svn log failed"
	test -f "$tmpname" && rm "$tmpname"
	test -f "$svntmp" && rm "$svntmp"
	exit 1
fi

#set -x
awkProg=$(echo $0 | sed 's/\.sh/.awk/')
cat $svntmp | sed '/^$/d' | awk -f $awkProg -v target=$username  > $tmpname
#set +x

cat $tmpname
while :;do
	read -p "continue(c) | modify(m) | exit(e) >> " choice
	if [ -z $choice ]; then 
		:
	elif [ $choice == "c" -o $choice = "C" ]; then 
		break
	elif [ $choice = "m" -o $choice = "M" ]; then
		vim "$tmpname"
		cat $tmpname
	elif [ $choice = "e" -o $choice = "E" ]; then
		test -f "$tmpname" && rm "$tmpname"
		test -f "$svntmp" && rm "$svntmp"
		exit 0
	fi
done

#第一个 xargs 多行转一行
revision_list=$(sed -r 's/^r([0-9]+).*/\1/' $tmpname | xargs | sed -r 's/ /,/g')
echo "svn merge -c $revision_list $fromUrl"

read -p "do you really want to call it [y/n]?" choice
if [ -z $choice ]; then 
	echo "choose exit."
elif [ $choice = "y" -o $choice = "Y" ]; then
	svn merge -c $revision_list $fromUrl
else 
	echo "choose exit."
fi

if [ $? -ne 0 ]; then 
	echo "svn merge failed"
fi

test -f "$tmpname" && rm "$tmpname"
test -f "$svntmp" && rm "$svntmp"
echo "done"
