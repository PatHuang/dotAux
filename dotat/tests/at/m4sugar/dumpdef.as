
m4_include([dmeta/das.m4])

AS_INIT

# Ensure that m4sugar dies when dereferencing undefined macros.
DAS_COMPILE_M4([],[],
[[
	m4_define([good], [yep])
	m4_dumpdef([good], [oops])
]])

# Check that pushdef stacks can be dumped.
DAS_COMPILE_M4([],[],
[[
m4_divert_push([KILL])
m4_pushdef([a], [1])
m4_pushdef([a], [2])
m4_dumpdef([a])
m4_dumpdefs([oops], [a])
m4_divert_pop([KILL])dnl

# Expected read:
a:	[2]
a:	[2]
a:	[1]
]])dnl DAS_COMPILE_M4

# Check behavior when dumping builtins.  Unfortunately, when using M4 1.4.x
# (or more precisely, when __m4_version__ is undefined), builtins get
# flattened to an empty string.  It takes M4 1.6 to work around this.
DAS_COMPILE_M4([],
[[
	m4_ifdef([__m4_version__], [_m4_undefine([__m4_version__])])
]], [[
	m4_dumpdef([m4_define])
]])dnl DAS_COMPILE_M4

DAS_COMPILE_M4([],[],
[[
	m4_ifdef([__m4_version__],
		[m4_dumpdef([m4_define])],
		[m4_errprintn([m4_define:	<define>])]
	)
]])

AS_EXIT

