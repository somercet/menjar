# menjar

`menjar` is a script to pull entries from `*.desktop` files for bemenu
or other dynamic dmenu-like apps. User directories can be specified on
the command line. `menjar` searches for and displays internationalized
entries in the .desktop files, a la `Name[pt_BR]=`.

`menjar` checks the time stamp of the cache file against the directories
each time it runs, updating only as required. Options `-d` and `-t` are
only *used* when rebuilding the cache file, but since it rebuilds that
file automatically, you should specify your preferred options on each
invocation.

Applications with `Terminal=true` entries are prefixed with `$term -e `
in the cache file. Although `menjar` has an internal list of about eight
common terminal emulators, you probably want to specify your preferred
TE in the command.

## Speed

Typical runtimes (with everything in disk cache)
are:

	$ time menjar -m cat
	xfce4-about
	
	real	0m0.021s
	user	0m0.019s
	sys	0m0.005s
	
	$ time menjar -t xfce4-terminal -m cat -f
	xfce4-about
	
	real	0m0.044s
	user	0m0.048s
	sys	0m0.013s

