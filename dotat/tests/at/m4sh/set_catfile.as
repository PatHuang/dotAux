m4_include([dmeta/das.m4])

AS_INIT

## ---------------- ##
## AS_SET_CATFILE.  ##
## ---------------- ##

# CATFILE_TEST(DIR, FILE, EXPECTED)
m4_define([CATFILE_TEST],
[
	# AS_SET_CATFILE works and can be used in a compound list.
	if AS_SET_CATFILE([var], [$1], [$2]) \
		  && test "$var" = $3; then :; else
		echo "catfile($1, $2) = $var != $3" >&2
	fi
	# AS_SET_CATFILE can use non-literals in its arguments.
	varname=var2
	dirpart=$1
	filepart=$2
	if AS_SET_CATFILE([$varname], [$dirpart], [$filepart]) \
		  && test "$var2" = $3; then :; else
		echo "catfile($dirpart, $filepart) = $var2 != $3" >&2
	fi
])

CATFILE_TEST([dir], [file], [dir/file])
CATFILE_TEST([.], [file], [file])
CATFILE_TEST([dir], [.], [dir])
CATFILE_TEST([dir], [/abs/file], [/abs/file])
CATFILE_TEST([dir], [C:/abs/file], [C:/abs/file])
CATFILE_TEST(["dir  name"], ['file  name'], ['dir  name/file  name'])

AS_EXIT

