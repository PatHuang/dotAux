m4_include([dmeta/das.m4])

AS_INIT

m4_define([BASENAME_TEST],
[
	base=`AS_BASENAME([$1])`
	test "$base" = "$2" ||
		echo "basename($1) = $base instead of $2" >&2

	base=`_AS_BASENAME_SED([$1])`
	test "$base" = "$2" ||
		echo "basename_sed($1) = $base instead of $2" >&2
])dnl BASENAME_TEST

# The EXPR variant is allowed to fail if `expr' was considered as too
# weak for us, in which case `as_expr=false'.
m4_define([DIRNAME_TEST],
[
	dir=`AS_DIRNAME([$1])`
	test "$dir" = "$2" || (test -n "$3" && test "$dir" = "$3") ||
		echo "dirname($1) = $dir instead of $2" >&2

	if test "$as_expr" != false; then
		dir=`_AS_DIRNAME_EXPR([$1])`
		test "$dir" = "$2" || (test -n "$3" && test "$dir" = "$3") ||
			echo "dirname_expr($1) = $dir instead of $2" >&2
	fi

	dir=`_AS_DIRNAME_SED([$1])`
	test "$dir" = "$2" || (test -n "$3" && test "$dir" = "$3") ||
		echo "dirname_sed($1) = $dir instead of $2" >&2
])dnl DIRNAME_TEST

## ------------- ##
## AS_BASENAME.  ##
## ------------- ##

# Strip path from file.

BASENAME_TEST([//1],             [1])
BASENAME_TEST([/1],              [1])
BASENAME_TEST([./1],             [1])
BASENAME_TEST([../../2],         [2])
BASENAME_TEST([//1/],            [1])
BASENAME_TEST([/1/],             [1])
BASENAME_TEST([./1/],            [1])
BASENAME_TEST([../../2],         [2])
BASENAME_TEST([//1/3],           [3])
BASENAME_TEST([/1/3],            [3])
BASENAME_TEST([./1/3],           [3])
BASENAME_TEST([../../2/3],       [3])
BASENAME_TEST([//1/3///],        [3])
BASENAME_TEST([/1/3///],         [3])
BASENAME_TEST([./1/3///],        [3])
BASENAME_TEST([../../2/3///],    [3])
BASENAME_TEST([//1//3/],         [3])
BASENAME_TEST([/1//3/],          [3])
BASENAME_TEST([./1//3/],         [3])
BASENAME_TEST([a.c],             [a.c])
BASENAME_TEST([a.c/],            [a.c])
BASENAME_TEST([/a.c/],           [a.c])
BASENAME_TEST([/1/a.c],          [a.c])
BASENAME_TEST([/1/a.c/],         [a.c])
BASENAME_TEST([/1/../a.c],       [a.c])
BASENAME_TEST([/1/../a.c/],      [a.c])
BASENAME_TEST([./1/a.c],         [a.c])
BASENAME_TEST([./1/a.c/],        [a.c])

## ------------ ##
## AS_DIRNAME.  ##
## ------------ ##

# Strip filename component.

DIRNAME_TEST([/],		[/])
DIRNAME_TEST([//],		[//],	[/])
DIRNAME_TEST([///],		[/])
DIRNAME_TEST([//1],		[//],	[/])
DIRNAME_TEST([/1],		[/])
DIRNAME_TEST([./1],		[.])
DIRNAME_TEST([../../2],		[../..])
DIRNAME_TEST([//1/],		[//],	[/])
DIRNAME_TEST([/1/],		[/])
DIRNAME_TEST([./1/],		[.])
DIRNAME_TEST([../../2],		[../..])
DIRNAME_TEST([//1/3],		[//1])
DIRNAME_TEST([/1/3],		[/1])
DIRNAME_TEST([./1/3],		[./1])
DIRNAME_TEST([../../2/3],	[../../2])
DIRNAME_TEST([//1/3///],	[//1])
DIRNAME_TEST([/1/3///],		[/1])
DIRNAME_TEST([./1/3///],	[./1])
DIRNAME_TEST([../../2/3///],	[../../2])
DIRNAME_TEST([//1//3/],		[//1])
DIRNAME_TEST([/1//3/],		[/1])
DIRNAME_TEST([./1//3/],		[./1])
DIRNAME_TEST([../../2//3/],	[../../2])

AS_EXIT

