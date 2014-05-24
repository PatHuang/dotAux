
# This file should be included by an Autotest script template
# (e.g. some-test.at), so the template could be processed
# by ma_at or autom4te --language=autotest to generate portable
# autotest script (some-test, in this example)
#

#---------------------------------------
#
# Copyright (c) 2009-2014 The dotAux project.
#
# This file is a part of the dotAux project, and is 
# copyrighted by Pat Huang and/or others who actually
# wrote it.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# See also
# <http://www.opensource.org/licenses/mit-license.php>
#
# Contact the project <staff.effo@gmail.com> or 
# contact Pat Huang <pat.sh.cn@gmail.com>
#
#---------------------------------------

# @file dat.m4
#
# @author Pat Huang
#
# @version v0.1r04
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02, 2009dec03, Pat, finished this source file.
#    r04, 2014apr24, Pat, updating dotAux macros.
# @endverbatim
#-------------------------------------------------------------------

# You need to include das.m4 as the basic lib.

m4_pattern_forbid([^_?DAS_])
m4_pattern_forbid([^_?DAT_])

# AT_CHECK's
# ----------------------------
# AT_CHECK(COMMANDS, [STATUS = 0], STDOUT, STDERR,
#          [RUN-IF-FAIL], [RUN-IF-PASS])
# -----------------------------
# AT_XFAIL_IF(SHELL-EXPRESSION)
# Set up the test to be expected to fail if SHELL-EXPRESSION evaluates to
# true (exitcode = 0).
# -----------------------------
# AT_SKIP_IF(SHELL-EXPRESSION)
# Skip the rest of the group if SHELL-EXPRESSION evaluates to true
# (exitcode = 0).
# ----------------------------
# AT_FAIL_IF(SHELL-EXPRESSION)
# Make the test die with hard failure if SHELL-EXPRESSION evaluates to
# true (exitcode = 0).
# ----------------------------

# m4_ifval(COND, [IF-TRUE], [IF-FALSE])
# -------------------------------------
# If COND is not the empty string, expand IF-TRUE, otherwise IF-FALSE.
# Comparable to m4_ifdef.
#m4_define([m4_ifval],
#[m4_if([$1], [], [$3], [$2])])

# DAT_SHELL_FN()
# ------------------
# Defined shell functions
m4_defun([DAT_SHELL_FN],
[
# ------------------
DAS_SHELL_FN

# ------------------
AS_FUNCTION_DESCRIBE([dat_fn_env], [ARG1, ARG2, ...],
[Display some current environment info.])
dat_fn_env()
{
	AS_MESSAGE([-------------Dump Env--------------]) 
	AS_MESSAGE([Maybe caller-ARG1=$1]) 
	AS_MESSAGE([PWD=DAS_EXEC([pwd])]) 
	AS_MESSAGE([abs_top_srcdir=$abs_top_srcdir]) 
	AS_MESSAGE([abs_top_builddir=$abs_top_builddir]) 
	AS_MESSAGE([at_top_srcdir=$at_top_srcdir]) 
	AS_MESSAGE([at_top_builddir=$at_top_builddir]) 
	AS_MESSAGE([at_testdir=$at_testdir]) 
	AS_MESSAGE([Caller arglist: $2 $3 $4]) 
	AS_MESSAGE([----------End of Dump Env-----------]) 
}
#DAT_ENV

])
#DAT_SHELL_FN

# DAT_CHK(COMMAND, [EXIT-STATUS = 0 if empty], [STDOUT, ignore if empty], [STDERR, ignore if empty])
# -------------------------------------------------------
# Out version of AT_CHECK. Don't use this if number of arguments > 2.
# You should use AT_CHECK directly.
m4_defun([DAT_CHK],
[
	dnl pass: AT_CHECK($@)
	dnl fail AT_CHECK([$1], [$2], [$3])
	dnl pass AT_CHECK($1, $2, $3)
	dnl fail AT_CHECK($1, m4_ifval($2, $2, 0), m4_ifval($3, $3, [ignore]), $4)
	AT_CHECK($1, m4_ifval($2, [$2], 0), m4_ifval($3, [$3], ignore), [$4])
])
#DAT_CHK

# DAT_CHK_M4(COMMAND, [EXIT-STATUS = 0], STDOUT, STDERR)
# -------------------------------------------------------
# Check M4
m4_defun([DAT_CHK_M4],
[
	AT_CHECK([$1], [$2], [$3], [$4])
])
#DAT_CHK_M4

# DAT_CHK_AUTOM4TE(FLAGS, [EXIT-STATUS = 0], STDOUT, STDERR)
# -----------------------------------------------------------
m4_defun([DAT_CHK_AUTOM4TE],
[
	DAT_CHK_M4([autom4te $1], [$2], [$3], [$4])
])
#DAT_CHK_AUTOM4TE

# DAT_DATA_M4SH(FILE-NAME, CONTENTS)
# ---------------------------------
# Escape the invalid tokens with @&t@.
m4_defun([DAT_DATA_M4SH],
[
AT_DATA([$1],
[
DAS_DATA_M4SH([$2])
])
#AT_DATA
])
#DAT_DATA_M4SH

# DAT_CHK_M4SH(FLAGS, [EXIT-STATUS = 0], STDOUT, STDERR)
# -------------------------------------------------------
m4_defun([DAT_CHK_M4SH],
[
	DAT_CHK_AUTOM4TE([--language=m4sh --force -Wall $1 script.as -o script],
		m4_ifval($2, $2, 0), m4_ifval($3, $3, ignore), $4
	)
	#DAT_CHK_AUTOM4TE
])
#DAT_CHK_M4SH

