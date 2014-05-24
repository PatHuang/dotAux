
m4_include([dmeta/das.m4])

AS_INIT

# DAS_DATA_LINENO(FILE-NAME,
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
m4_define([DAS_DATA_LINENO],
[
DAS_DATA([$1.tas],
[[
m4_divert_text([], [
if $2; then
  AS_UNSET([LINENO])
fi
])
AS_LINENO_PREPARE
echo "Line: $3"
grep 'Line: .*$4' "$[0]" >/dev/null || AS_ERROR([cannot find original script])
]])dnl DAS_DATA
# If occurrences of $LINENO or __@&t@oline__ were wanted, create them.
sed 's/__LINENO__/$''LINENO/g;s/__OLINE__/__''oline__/g' $1.tas >$1.as
rm -f $1.tas
autom4te --language=m4sh --force -Wall $1.as -o $1
rm -f $1.as
])dnl DAS_DATA_LINENO

## ---------------- ##
## LINENO support.  ##
## ---------------- ##

# We cannot unset LINENO with Zsh, yet this test case relies on
# unsetting LINENO to compare its result when (i) LINENO is supported
# and when (ii) it is not.
# So just skip if the shell is ZSH.
test -n "${ZSH_VERSION+set}" && exit 77

mkdir test || exit 77

cd test

# `_oline_', once processed and ran, produces our reference.
# We check that we find ourselves by looking at a string which is
# available only in the original script: `_oline_'.
DAS_DATA_LINENO([reference], [false], [__OLINE__], [_oline__])
./reference >stdout.log

# The reference:
mv stdout.log expout.log

# Now using a maybe-functioning LINENO, with different call conventions.
# Be sure to be out of the PATH.

DAS_DATA_LINENO([test-1], [false], [__LINENO__], [LINENO])
./test-1 >stdout.log
# here to compare stdout with expout
PATH=`pwd`$PATH_SEPARATOR$PATH; export PATH; exec test-1 >stdout.log
# here to compare stdout with expout
sh ./test-1 >stdout.log
# here to compare stdout with expout

# Now using a disabled LINENO, with different call conventions.
DAS_DATA_LINENO([test-2], [true], [__LINENO__], [LINENO])
./test-2 >stdout.log
# here to compare stdout with expout
exec test-2 >stdout.log
# here to compare stdout with expout
sh ./test-2 >/stdout.log
# here to compare stdout with expout

rm -rf test

## ---------------------- ##
## LINENO stack support.  ##
## ---------------------- ##

DAS_COMPILE_M4SH([], [],
[[
AS_LINENO_PUSH([9999])
test $as_lineno = 9999 || AS_ERROR([bad as_lineno at depth 1])
AS_LINENO_PUSH([8888])
test $as_lineno = 9999 || AS_ERROR([bad as_lineno at depth 2])
AS_LINENO_POP
test $as_lineno = 9999 || AS_ERROR([bad as_lineno at depth 1])
AS_LINENO_POP
test x${as_lineno+set} = xset && AS_ERROR([as_lineno set at depth 0])
]])dnl DAS_COMPILE_M4SH

AS_EXIT

