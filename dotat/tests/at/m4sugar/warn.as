m4_include([dmeta/das.m4])

AS_INIT

DAS_COMPILE_M4([m4test], [],[],
[[
m4_defun([cross_warning], [m4_warn([cross], [cross])])

m4_divert([0])dnl
m4_warn([obsolete], [obsolete])dnl
cross_warning[]dnl
m4_warn([syntax], [syntax])dnl
cross_warning[]dnl
m4_warn([syntax], [syntax])dnl
]],
[],[AS_ERROR([code=$das_compile_status])]
)

rm -f m4test m4test.m4

AS_EXIT

