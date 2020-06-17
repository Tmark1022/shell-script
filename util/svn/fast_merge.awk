BEGIN {
	RS="------------------------------------------------------------------------\n"
	FS="|"
}

! /^$/ {
	cnt = split($4, arr, "\n")
	comment = ""
	if (cnt >= 2) {
		comment = arr[2]
	}

	revision = $1	
	user = $2
	ctime = $3
	gsub(/[ \t]*/, "", revision)
	gsub(/[ \t]*/, "", user)

	if (target == user)
		print revision  "\t\t" ctime "\t\t" comment
	else if (target == "all")
		print revision  "\t\t" user "\t\t" ctime "\t\t" comment
}
