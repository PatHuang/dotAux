
# AT_DATA_LINENO(FILE-NAME,
#                UNSET-LINENO = true | false, COUNTER, COUNTER-RE)
# ----------------------------------------------------------------
# Produce the FILE-NAME M4sh script which uses the COUNTER LINENO or
# _oline_, which we can recognized via COUNTER-RE.  Unset LINENO is
# UNSET-LINENO.
#
# Use COUNTER, COUNTER-RE = [__LINENO__], [LINENO]
#  or                     = [__OLINE__],  [_oline__]
#
# instead of the obvious $LINENO and __oline__, because they would
# be replaced in the test suite itself, even before creating these
# scripts.  For the same reason, grep for LINENO and _oline__ (sic).
#
# UNSET-LINENO is a shell condition to make sure the scripts have the
# same number of lines in the output, so that their outputs be identical.
m4_define([AT_DATA_LINENO],
[AT_DATA([$1.tas],
[[AS@&t@_INIT
m4@&t@_divert_text([], [
if $2; then
  AS@&t@_UNSET([LINENO])
fi
])
AS@&t@_LINENO_PREPARE
echo "Line: $3"
grep 'Line: .*$4' "$[0]" >/dev/null ||
  AS@&t@_ERROR([cannot find original script])
exit 0
]])
# If occurrences of $LINENO or __@&t@oline__ were wanted, create them.
sed 's/__LINENO__/$''LINENO/g;s/__OLINE__/__''oline__/g' $1.tas >$1.as
AT_CHECK([autom4te -l m4sh $1.as -o $1])
])# AT_DATA_LINENO

AT_BANNER([M4sh.])

