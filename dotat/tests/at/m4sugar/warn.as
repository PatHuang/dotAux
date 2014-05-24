m4_include([dmeta/das.m4])

AS_INIT

DAS_COMPILE_M4([],[],
[[
m4_defun([cross_warning], [m4_warn([cross], [cross])])

m4_divert([0])dnl
m4_warn([obsolete], [obsolete])dnl
cross_warning[]dnl
m4_warn([syntax], [syntax])dnl
cross_warning[]dnl
m4_warn([syntax], [syntax])dnl
]])dnl DAS_COMPILE_M4

AS_EXIT

