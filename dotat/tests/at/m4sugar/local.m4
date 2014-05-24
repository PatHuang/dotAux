

# AT_CHECK_M4SUGAR_TEXT(CODE, STDOUT, STDERR)
# -------------------------------------------
# Check that m4sugar CODE expands to STDOUT and emits STDERR.
m4_define([AT_CHECK_M4SUGAR_TEXT],
[
AT_DATA_M4SUGAR([script.4s],
[[m4_init
m4_divert_push([])[]dnl
]$1[[]dnl
m4_divert_pop([])
]])

AT_CHECK_M4SUGAR([-o-],, [$2], [$3])
])# AT_CHECK_M4SUGAR_TEXT

AT_BANNER([M4sugar.])

