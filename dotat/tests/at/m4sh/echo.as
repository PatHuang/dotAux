m4_include([dmeta/das.m4])

AS_INIT

## --------- ##
## AS_ECHO.  ##
## --------- ##

AS_ECHO([a b c d])
AS_ECHO(['a b c d'])
AS_ECHO(["a b c d"])

# Print literal strings, with/without newline.

m4_defun([DO_DEBUG],
[
	AS_MESSAGE([----------------------------])
	echo "echo.$1: '$2' '$3'"
	AS_IF([test x"$2" = x"$3"], [echo PASS], [echo FAIL])

])dnl DO_DEBUG

m4_define([ECHO_TEST],
[
	echo=`AS_ECHO(['$1'])`
	DO_DEBUG([], [$1], [$echo])
	test "X$echo" = 'X$1' ||
		echo "AS@&t@_ECHO('"'$1'"') outputs '$echo'" >&2

	echo=`AS_ECHO_N(['$1'])`
	DO_DEBUG([N], [$1], [$echo])
	test "X$echo" = 'X$1' ||
		echo "AS@&t@_ECHO_N('"'$1'"') outputs '$echo'" >&2
])dnl ECHO_TEST

ECHO_TEST([-])
ECHO_TEST([--])
ECHO_TEST([---...---])
ECHO_TEST([	 ])
ECHO_TEST([-e])
ECHO_TEST([-E])
ECHO_TEST([-n])
ECHO_TEST([-n -n])
ECHO_TEST([-e -n])
ECHO_TEST([ab\ncd])
ECHO_TEST([abcd\c])
#this fails because of tailing '\' ECHO_TEST([\a\b\c\f\n\r\t\v\"\])
ECHO_TEST([\a\b\c\f\n\r\t\v\"\\])
ECHO_TEST([ab
cd
e])
ECHO_TEST([
])
ECHO_TEST([
\c])

AS_EXIT

