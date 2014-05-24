m4_include([dmeta/das.m4])

AS_INIT

## -------- ##
## AS_FOR.  ##
## -------- ##

AS_MESSAGE([--------------------------------------])

# Simple checks.
AS_FOR([m4var], [shvar], [a],
	[echo "m4var $shvar"])
AS_FOR([m4var], [shvar], [b c],
	[echo "m4var $shvar"])
list='d e'
AS_FOR([m4var], [shvar], [$list],
	[echo "m4var $shvar"])
AS_FOR([m4var], [shvar], ["$list"],
	[echo "m4var $shvar"])
AS_FOR([m4var], [shvar], ['$list'],
	[echo "m4var $shvar"])
AS_FOR([m4var], [shvar], [\'],
	[echo "m4var $shvar"])

# Syntax checks: cope with empty/blank arguments.
set f g
AS_FOR([], [shvar], [],
	[echo "m4_defn([]) $shvar"])
rm -f file
AS_FOR([], [shvar], [`touch file`])
test -f file || exit 1
rm -f file
AS_FOR([], [shvar], [], [ ])
m4_define([empty])AS_FOR([], [shvar], [], [empty])

# Check that break works.
while :
do
	AS_FOR([m4var], [shvar], [h i],
		[echo "m4var"; break 2])
	exit 1
done
while :
do
	AS_FOR([m4var], [shvar], [j],
		[echo "m4var"; break 2])
	exit 1
done

DAS_DATA([output.log],
[[
a a
b b
c c
d d
e e
d e d e
$list $list
' '
f f
g g
h
j
]])dnl DAS_DATA

rm -f output.log

AS_EXIT

