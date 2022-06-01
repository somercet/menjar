
BEGIN {
	L = ENVIRON["LANG"]
	if ( length(L) > 0 ) {
		sub(/\..*/, "", L)
		M[L] = 5
		if ( L ~ "@" ) {
			temp = L
			sub(/@.*/, "", temp)
			M[temp] = 4
		}
		if ( L ~ "_" ) {
			temp = L
			sub(/@.*/, "", temp)
			M[temp] = 3
		}
	} else
		M[0] = 1
}

/^\[Desktop Entry/ {
	add = 1
	process = 1
	score = 0
	T = ""
	next
}

/^\[/ {
	add = 0
	next
}

/^NoDisplay=true/ {
	if ( add )
		process = 0
}

/^Terminal=true/ {
	if ( add )
		T = term " -x "
}

/^Name=/ {
	if ( ! add )
		next
	if ( score )
		next
	
	sub(/[^=]+=/, "")
	name = $0
}

/^Name\[/ {
	if ( ! add || M[0] == 1 )
		next

	S = $0
	sub(/^Name\[/, "", S)
	sub(/\].*/, "", S)
	if ( S in M && M[S] > score ) {
		score = M[S]
		sub(/[^=]+=/, "")
		name = $0
	}
}

/^Exec=/ {
	if ( ! add )
		next
	sub(/[^=]+=/, "")
	exec = $0
}

ENDFILE {
	if ( process ) {
		gsub(/[ \t\n]+/, " ", name)
		gsub(/[ \t\n]+/, " ", exec)
		print name "\t" T exec
	}
}

