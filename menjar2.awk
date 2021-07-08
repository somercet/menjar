
BEGIN {
	FS = "\t"
	names = "bemenu -i -p#"
}

{
	print $1 |& names
	a[$1] = $2
}

END {
	close(names, "to")
	names |& getline comm
	if ( comm ) {
		sub(/ +%[[:alpha:]] *$/, "", a[comm])
		print a[comm]
	}
}

