m4_include([dmeta/das.m4])

AS_INIT

## --------------- ##
## m4_bpatsubsts.  ##
## --------------- ##

DAS_COMPILE_M4([m4test], [],[],
[[
m4_bpatsubsts([11], [^..$])
m4_bpatsubsts([11], [\(.\)1], [\12])
m4_bpatsubsts([11], [^..$], [], [1], [2])
m4_bpatsubsts([11], [\(.\)1], [\12], [1], [3])
m4_define([a], [oops])m4_define([c], [oops])dnl
m4_define([AB], [good])m4_define([bc], [good])dnl
m4_bpatsubsts([abc], [a], [A], [b], [B], [c])
m4_bpatsubsts([ab], [a])c
m4_bpatsubsts([ab], [c], [C], [a])c
m4_bpatsubsts([$1$*$@], [\$\*], [$#])

# Expected read:

11
21
22
23
good
good
good
$1$#$@
]],
[],[AS_ERROR([code=$das_compile_status])]
)

rm -f m4test m4test.m4

AS_EXIT

