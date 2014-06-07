
m4_include([dmeta/das.m4])

AS_INIT

DAS_COMPILE_M4([m4test], [],[],
[[
m4_divert_push([])

m4_pushdef([abc], [def])dnl
m4_pushdef([abc], [ghi])dnl
m4_pushdef([abc], [jkl])dnl
m4_stack_foreach([abc], [m4_n])
abc
m4_stack_foreach_lifo([abc], [m4_n])
m4_stack_foreach([abc], [m4_n])
m4_copy([abc], [foo])dnl
m4_stack_foreach([foo], [m4_n])
m4_stack_foreach_lifo([foo], [m4_n])
m4_stack_foreach_sep([abc], 
[
	dnl m4_index takes 2 arguments
	dnl m4_index([abcdefghijkl],],[)
	m4_index([abcdefghijkl],)
])
m4_define([colon], [:])m4_define([lt], [<])m4_define([gt], [>])dnl
m4_stack_foreach_sep_lifo([abc], [lt], [gt], [colon])
m4_pushdef([xyz], [123])dnl
m4_pushdef([xyz], [456])dnl
m4_define([doit], [
	[$1](m4_stack_foreach_sep([xyz],
		[m4_dquote(], [)],
		[,])dnl m4_stack_foreach_seq
	)
])dnl define doit

m4_stack_foreach([abc], [doit])

m4_divert_pop([])

dnl Expected read:
def
ghi
jkl

jkl
jkl
ghi
def

def
ghi
jkl

def
ghi
jkl

jkl
ghi
def

 3 6 9
<jkl>:<ghi>:<def>
def([123],[456])
ghi([123],[456])
jkl([123],[456])

]],
[],[AS_ERROR([code=$das_compile_status])]
)

rm -f m4test m4test.m4

AS_EXIT

