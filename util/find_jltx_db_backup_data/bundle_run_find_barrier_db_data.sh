#!/bin/bash
#*************************************************************************
#	> Author	: tmark
#	> Created Time	: Wed 01 Jul 2020 10:28:29 AM CST
#	> File Name	: bundle_run_find_db_data.sh
#	> Description	: 批量处理查找玩家barrier数据脚本
#*************************************************************************
usage() {
	echo "usage : sh $0 search_dir uid1 uid2...."
}

if [ $# -le 1 ]; then
	usage
	exit 1
fi

search_dir=$1
handler_cmd="do_barrier"

shift 1
for uid in $@
do
	db_file=$(sh find_db_data_uid.sh "$uid" "$search_dir")
	if [ -z "$db_file" ]; then
		echo "can't find uid $uid"	
		exit 1
	fi

	if [ ! -f "${search_dir}/${db_file}" ]; then
		echo "${search_dir}/${db_file} not exist"
		exit 1
	fi

	depress_db_file=$(echo "$db_file" | sed -E 's/(.*)\.tar\.gz/\1/')
	if [ -z "$depress_db_file" ]; then
		echo "the depress_db_file of ${search_dir}/${db_file} is invalid"
		exit 1
	fi

	if [ ! -f "${search_dir}/${depress_db_file}" ]; then
		echo "try to extract ${search_dir}/${db_file}"
		tar -zvxf "${search_dir}/${db_file}" -C "${search_dir}"

		if [ ! -f "${search_dir}/${depress_db_file}" ]; then
			echo "file ${search_dir}/${depress_db_file} not exist"
			exit 1
		fi
	fi
	
	# shell 脚本内不要使用相对路径
	output_file="/tmp/${uid}.json"	
	python find_db_data.py "${handler_cmd}" "${search_dir}/${depress_db_file}" ${uid} "$output_file"                                                                  	
done

echo "done"

