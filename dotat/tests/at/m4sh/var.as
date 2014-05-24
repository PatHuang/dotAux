m4_include([dmeta/das.m4])

AS_INIT

# reset all for subsequent tests
m4_defun([RESET_TEST],
[
	AS_VAR_SET([foo])
	AS_UNSET([foo])
	AS_VAR_SET([bar])
	AS_UNSET([bar])
	AS_VAR_SET([tmp])
	AS_UNSET([tmp])
	AS_VAR_SET([foo1])
	AS_UNSET([foo1])
	AS_VAR_SET([foo2])
	AS_UNSET([foo2])
	AS_VAR_SET([foo3])
	AS_UNSET([foo3])
	AS_VAR_SET([foo4])
	AS_UNSET([foo4])

])dnl RESET_TEST

foo=1
tmp=2

echo tmp "$tmp"
AS_VAR_PUSHDEF([tmp], [foo])dnl
echo tmp "$tmp" pushed
tmp=3
echo tmp "$tmp" set
AS_VAR_PUSHDEF([tmp], [foo])dnl
echo tmp "$tmp" pushed
tmp=4
echo tmp "$tmp" set
AS_VAR_POPDEF([tmp])dnl
echo tmp "$tmp" popped
AS_VAR_POPDEF([tmp])dnl
echo tmp "$tmp" popped

AS_MESSAGE([-----------------------------------])

RESET_TEST

## ---------- ##
## AS_VAR_*.  ##
## ---------- ##

m4_define([with], [WITH])
# Literals.
dnl AS_VAR_SET_IF also covers AS_VAR_TEST_SET
AS_VAR_SET_IF([foo], [echo oops]) && echo ok
AS_VAR_IF([foo], [], [echo ok], [echo oops])
foo=
AS_VAR_SET_IF([foo], [echo ok])
AS_VAR_SET([foo], ['\a  "weird" `value` with; $fun '\''characters
']) # 'font-lock
AS_VAR_COPY([bar], [foo])
AS_ECHO(["$bar-"])
AS_ECHO(["AS_VAR_GET([foo])-"])
AS_VAR_SET_IF([foo], [echo ok], [echo oops])
AS_VAR_IF([foo], [string], [echo oops]) && echo ok
AS_VAR_PUSHDEF([tmp], [foo])
AS_VAR_IF([tmp], ['\a  "weird" `value` with; $fun '\''characters
'], [echo ok], [echo oops]) # 'font-lock
AS_VAR_POPDEF([tmp])
m4_ifdef([tmp], [echo oops])

# Indirects via shell vars.
echo '===='
num=1
AS_VAR_SET_IF([foo$num], [echo oops]) && echo ok
AS_VAR_IF([foo$num], [], [echo ok], [echo oops])
foo1=
AS_VAR_SET_IF([foo$num], [echo ok])
AS_VAR_SET([foo$num], ['\a  "weird" `value` with; $fun '\''characters
']) # 'font-lock
AS_VAR_COPY([bar], [foo$num])
num=2
AS_VAR_COPY([foo$num], [bar])
AS_ECHO(["$foo2-"])
AS_ECHO(["AS_VAR_GET([foo$num])-"])
AS_VAR_SET_IF([foo$num], [echo ok], [echo oops])
AS_VAR_IF([foo$num], [string], [echo oops]) && echo ok
AS_VAR_PUSHDEF([tmp], [foo$num])
AS_VAR_IF([tmp], ['\a  "weird" `value` with; $fun '\''characters
'], [echo ok], [echo oops]) # 'font-lock
AS_VAR_POPDEF([tmp])
m4_ifdef([tmp], [echo oops])

# Indirects via command substitution.
echo '===='
AS_VAR_SET_IF([`echo foo3`], [echo oops]) && echo ok
AS_VAR_IF([`echo foo3`], [], [echo ok], [echo oops])
foo3=
AS_VAR_SET_IF([`echo foo3`], [echo ok])
AS_VAR_SET([`echo foo3`], ['\a  "weird" `value` with; $fun '\''characters
']) # 'font-lock
AS_VAR_COPY([bar], [`echo foo3`])
num=2
AS_VAR_COPY([`echo foo4`], [bar])
AS_ECHO(["$foo4-"])
AS_ECHO(["AS_VAR_GET([`echo foo4`])-"])
AS_VAR_SET_IF([`echo foo4`], [echo ok], [echo oops])
AS_VAR_IF([`echo foo4`], [string], [echo oops]) && echo ok
AS_VAR_PUSHDEF([tmp], [`echo foo4`])
AS_VAR_IF([tmp], ['\a  "weird" `value` with; $fun '\''characters
'], [echo ok], [echo oops]) # 'font-lock
AS_VAR_POPDEF([tmp])
m4_ifdef([tmp], [echo oops])
:

RESET_TEST

DAS_DATA([output.log],
[[
ok
ok
ok
\a  "weird" `value` WITH; $fun 'characters
-
\a  "weird" `value` WITH; $fun 'characters
-
ok
ok
ok
====
ok
ok
ok
\a  "weird" `value` WITH; $fun 'characters
-
\a  "weird" `value` WITH; $fun 'characters-
ok
ok
ok
====
ok
ok
ok
\a  "weird" `value` WITH; $fun 'characters
-
\a  "weird" `value` WITH; $fun 'characters-
ok
ok
ok
]])dnl DAS_DATA

rm -f output.log

## --------------- ##
## AS_VAR_APPEND.  ##
## --------------- ##

# Literals.
AS_VAR_APPEND([foo], ["hello,  "])
AS_VAR_APPEND([foo], [world])
echo "$foo"
# Indirects via shell vars.
num=1
AS_VAR_APPEND([foo$num], ['hello,  '])
AS_VAR_APPEND([foo$num], [`echo "world"`])
echo "$foo1"
# Indirects via command substitution.
h=hello w=',  world'
AS_VAR_APPEND([`echo foo2`], [${h}])
AS_VAR_APPEND([`echo foo2`], ["$w"])
echo "$foo2"

RESET_TEST

DAS_DATA([output.log],
[[
hello,  world
hello,  world
hello,  world
]])dnl DAS_DATA

rm -f output.log

## -------------- ##
## AS_VAR_ARITH.  ##
## -------------- ##

# Literals.
AS_VAR_ARITH([foo], [1 + 1])
echo "$foo"
# Indirects via shell vars.
num=1
AS_VAR_ARITH([foo$num], [\( 2 + 3 \) \* 4])
echo "$foo1"
# Indirects via command substitution.
AS_VAR_ARITH([`echo foo2`], [0 + -2 + $foo1 / 2])
echo "$foo2"

DAS_DATA([output.log],
[[
2
20
8
]])dnl DAS_DATA

rm -f output.log

AS_EXIT

