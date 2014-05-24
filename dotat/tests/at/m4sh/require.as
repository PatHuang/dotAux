m4_include([dmeta/das.m4])

AS_INIT

## ------------------- ##
## Nested AS_REQUIRE.  ##
## ------------------- ##

# Hypothesis: M4sh expands the requirements of AS_REQUIRE in the
# requested diversion, even if other AS_REQUIREs are interleaved.

m4_defun([in_fn_diversion], still_in_m4sh_init_fn=yes)
m4_defun([not_in_fn_diversion], still_in_m4sh_init_fn=no)

m4_defun([NESTED], [nested_require_in_fn_diversion=$still_in_m4sh_init_fn])

m4_defun([OUTER], [AS_REQUIRE([NESTED])dnl
outer_require_in_fn_diversion=$still_in_m4sh_init_fn])

m4_defun([test_init], [
	AS_REQUIRE([in_fn_diversion], , [M4SH-INIT-FN])
	AS_REQUIRE([OUTER], , [M4SH-INIT-FN])
	AS_REQUIRE([not_in_fn_diversion], , [M4SH-INIT-FN])
])

test_init
if test $outer_require_in_fn_diversion != yes; then AS_EXIT([1]); fi
if test $nested_require_in_fn_diversion != no; then AS_EXIT([1]); fi

AS_EXIT

