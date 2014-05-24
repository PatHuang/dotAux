m4_include([dmeta/das.m4])

#m4_define([INIT], [oops])dnl

AS_INIT

## --------------------------- ##
## Nested AS_REQUIRE_SHELL_FN. ##
## --------------------------- ##

# Hypothesis: M4sh expands nested AS_REQUIRE_SHELL_FN
# separately.

m4_defun([TEST_FUNC2_BODY], [
	:
])

m4_defun([TEST_FUNC1_BODY], [
	AS_REQUIRE_SHELL_FN([test_func2], [], [TEST_FUNC2_BODY])
	:
])

AS_REQUIRE_SHELL_FN([test_func1], [], [TEST_FUNC1_BODY])
test_func2

AS_EXIT

