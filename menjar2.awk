
BEGIN {
	FS = "\t"
	if (! menu)
		menu = "bemenu -i -p#"
}

{
	print $1 |& menu
	a[$1] = $2
}

END {
	close(menu, "to")
	menu |& getline comm
	if ( comm ) {
		sub(/ +%[[:alpha:]] *$/, "", a[comm])
		print a[comm]
	}
}

