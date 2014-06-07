
m4_include([dmeta/das.m4])

AS_INIT

# Ensure that m4sugar dies when dereferencing undefined macros, whether
# this is provided by m4 natively or faked by wrappers in m4sugar.

DAS_COMPILE_M4([m4test], [],[],
[[
	m4_define([good])
	m4_defn([good], [oops])
]],
[],[AS_ERROR([code=$das_compile_status])]
)

DAS_COMPILE_M4([m4test], [],[],
[[
	m4_define([good])
	m4_popdef([good], [oops])
]],
[],[AS_ERROR([code=$das_compile_status])]
)

DAS_COMPILE_M4([m4test], [],[],
[[
	m4_define([good])
	m4_undefine([good], [oops])
]],
[],[AS_ERROR([code=$das_compile_status])]
)

# Cannot rename an undefined macro.
DAS_COMPILE_M4([m4test], [],[],
[[
	m4_rename([oops], [good])
]],
[],[AS_ERROR([code=$das_compile_status])]
)

# Check that pushdef stacks can be renamed.
DAS_COMPILE_M4([m4test], [],[],
[[
m4_pushdef([a], [1])dnl
m4_pushdef([a], [2])dnl
m4_pushdef([a], m4_defn([m4_divnum]))dnl
a b c
m4_rename([a], [b])dnl
a b c
m4_copy([b], [c])dnl
a b c
m4_popdef([b], [c])dnl
a b c
m4_popdef([b], [c])dnl
a b c
m4_popdef([b], [c])dnl
a b c
dnl m4_copy is intentionally a no-op on undefined source
m4_copy([oops], [dummy])m4_ifdef([dummy], [[oops]])dnl
dnl allow forceful overwrites
m4_define([d], [4])m4_define([e], [5])m4_define([f], [6])dnl
m4_copy_force([d], [e])dnl
m4_rename_force([d], [f])dnl
d e f
m4_popdef([e], [f])dnl
d e f

# Expected read:
0 b c
a 0 c
a 0 0
a 2 2
a 1 1
a b c
d 4 4
d e f
]],
[],[AS_ERROR([code=$das_compile_status])]
)

rm -f m4test m4test.m4

AS_EXIT

