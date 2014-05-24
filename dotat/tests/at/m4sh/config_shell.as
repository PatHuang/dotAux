
m4_include([dmeta/das.m4])

AS_INIT

## --------------------------- ##
## Re-exec with CONFIG_SHELL.  ##
## --------------------------- ##

# No extra re-exec with CONFIG_SHELL
DAS_COMPILE_M4SH([],
[[
	dnl We have to muck with internal details to goad the script into
	dnl thinking that the default shell is always good enough.
	m4_define([_AS_DETECT_REQUIRED_BODY], [])dnl
	m4_define([_AS_DETECT_SUGGESTED_BODY], [])dnl
]],
[[
	echo foo > ok
	test -f ok
	rm -f ok
]])dnl DAS_COMPILE_M4SH

# Forced re-exec with CONFIG_SHELL
DAS_COMPILE_M4SH([],
[[
	m4_define([_AS_FORCE_REEXEC_WITH_CONFIG_SHELL], [yes])
]],
[[
	echo foo > sentinel
	test -f sentinel
	rm -f sentinel
]])dnl DAS_COMPILE_M4SH

# Calling the script simply 'script' could cause problems with
# Solaris /usr/xpg4/bin/sh in the invocation 'sh script' below.
#mv -f script script2
DAS_DATA([fake-shell],
[[
#!/bin/sh
echo 'Fake shell executed.'
shift # fake shell
echo "nargs = @S|@#"
for i
do
  printf ' :%s:\n' "$i"
done
]])dnl DAS_DATA
chmod a+x fake-shell

./fake-shell ./fake-shell 1 2 4 8
`pwd`/fake-shell sh ./fake-shell a 'b  c' '  d	   e '
PATH=`pwd`:$PATH; export PATH;
fake-shell fake-shell '' '&' '!;*' '<($[]@%:@)>,' 'x
y  z
1 2 3'

rm -f fake-shell

AS_EXIT

