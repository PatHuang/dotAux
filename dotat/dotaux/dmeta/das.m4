
# This file should be included by a shell script template
# (e.g. some-script.as), so the template could be processed
# by ma_m4sh or autom4te --language=m4sh to generate portable
# shell script (some-script, in this example)
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

# @file das.m4
#
# @author Pat Huang
#
# @version v0.1r04
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02, 2009dec03, Pat, finished this source file.
#    r04, 2014apr25, Pat, updating dotAux macros.
# @endverbatim
#-------------------------------------------------------------------

m4_pattern_forbid([^_?DAS_])

# DAS_DEBUG_TURNON()
# ------------------
# Turn on debugging.
m4_defun([DAS_DEBUG_TURNON],
[
	AS_VAR_SET([das_dbg], [1])
])
# DAS_DEBUG_TURNON

# DAS_DEBUG_TURNOFF()
# ------------------
# Turn off debugging.
m4_defun([DAS_DEBUG_TURNOFF],
[
	AS_VAR_SET([das_dbg], [0])
])
# DAS_DEBUG_TURNOFF

# DAS_IS_DEBUG()
# ------------------
# Test if debugging is on.
m4_defun([DAS_IS_DEBUG],
[
	test x"$das_dbg" = x"1"
])
# DAS_IS_DEBUG

# DAS_DLOG_OPEN(LOGFILE)
# ------------------
# Set debug log file
m4_defun([DAS_DLOG_OPEN],
[
	m4_define([AS_MESSAGE_LOG_FD], [5])
	exec AS_MESSAGE_LOG_FD>$1
])
# DAS_DLOG_OPEN

# DAS_DLOG_CLOSE()
# ------------------
# Unset debug log file
m4_defun([DAS_DLOG_CLOSE],
[
	exec AS_MESSAGE_LOG_FD>&-
])
# DAS_DLOG_CLOSE

# DAS_DEF_VAR(VAR, [VALUE])
# -------------------
# Define a local variable, because "local" is not portable.
# NOTE: Depth of call-stack shall not > 1.
# NOTE: Subshell should be sound too.
# E.g.:
# var=0 # global
# echo $var # got 0
# (
#   # enter subshell
#   var=1 # local
#   echo $var # got 1
# )
# echo $var # still got 0
# However, {var=1} doesn't a subshell.
# Moreover, behavior of return and break in subshell is not that
# what you might expect.
# Cost of subshell is notable too.
m4_defun([DAS_DEF_VAR],
[
	# hope nobody else uses das_def_*
	AS_VAR_PUSHDEF([$1], [das_def_$1])
	AS_VAR_SET([$1], ["$2"])
])
#DAS_DEF_VAR

# DAS_UNDEF_VAR(VAR)
# -------------------
# Undefine a local variable
m4_defun([DAS_UNDEF_VAR],
[
	AS_VAR_POPDEF([$1])
])
#DAS_UNDEF_VAR

# DAS_STATUS_SUCC(STATUS, ACTION)
# ---------------------------------------------
# If exit-status is 0, take an action.
m4_defun([DAS_STATUS_SUCC],
[
	AS_IF([test x"$1" = x"0"], [$2])
])
# DAS_STATUS_SUCC

# DAS_STATUS_FAIL(STATUS, ACTION)
# ---------------------------------------------
# If exit-status is not 0, take an action.
m4_defun([DAS_STATUS_FAIL],
[
	AS_IF([test x"$1" != x"0"], [$2])
])
# DAS_STATUS_FAIL

# DAS_VAR_IFNOT(VAR, VALUE, ACTION)
# ---------------------------------------------
# If var's value is not equal to VALUE, take an action.
m4_defun([DAS_VAR_IFNOT],
[
	AS_VAR_IF([$1], [$2], [], [$3])
])
# DAS_VAR_IFNOT

# DAS_HAS_STR(STR, ACTION)
# ---------------------------------------------
# If string is not empty (set and len > 0), take an action.
m4_defun([DAS_HAS_STR],
[
	AS_IF([test x"$1" != x], [$2])
])
# DAS_HAS_STR

# DAS_NO_STR(STR, ACTION)
# ---------------------------------------------
# If string is empty (zero len or not set), take an action.
m4_defun([DAS_NO_STR],
[
	AS_IF([test x"$1" = x], [$2])
])
# DAS_NO_STR

# DAS_HAS_FILE(FILE, ACTION)
# ---------------------------------------------
# If file exists, take an action.
m4_defun([DAS_HAS_FILE],
[
	AS_IF([test -f "$1"], [$2])
])
# DAS_HAS_FILE

# DAS_NO_FILE(FILE, ACTION)
# ---------------------------------------------
# If file doesn't exist, take an action.
m4_defun([DAS_NO_FILE],
[
	AS_IF([! test -f "$1"], [$2])
])
# DAS_NO_FILE

# DAS_HAS_DIR(DIR, ACTION)
# ---------------------------------------------
# If dir exists, take an action.
m4_defun([DAS_HAS_DIR],
[
	AS_IF([test -d "$1"], [$2])
])
# DAS_HAS_DIR

# DAS_NO_DIR(DIR, ACTION)
# ---------------------------------------------
# If dir doesn't exist, take an action.
m4_defun([DAS_NO_DIR],
[
	AS_IF([! test -d "$1"], [$2])
])
# DAS_NO_DIR

# _DAS_STR_DO_PARSE(Str, Key, Delim)
# -----------------
m4_defun([_DAS_STR_DO_PARSE],
[dnl
	dnl val=`echo "$str" | sed -n "s/^$key[ ]\{0,1\}[:]\{0,1\}""$delim""[:]\{0,1\}[ ]\{0,1\}\(.*\)/\1/p"`
	AS_ECHO(["$[]1"]) | sed -n ["s/^"]"$[]2"["[ ]\{0,1\}[:]\{0,1\}"]"$[]3"["[:]\{0,1\}[ ]\{0,1\}\(.*\)/\1/p"] dnl
])
# _DAS_STR_DO_PARSE

# _DAS_FILE_DO_PARSE(File, Key, Delim)
# -----------------
m4_defun([_DAS_FILE_DO_PARSE],
[dnl
	dnl awk '/MemFree/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo
	dnl val=`sed -n "/^$key[ ]\{0,1\}[:]\{0,1\}""$delim""[:]\{0,1\}[ ]\{0,1\}/ {p;q;}" "$file"`
	sed -n ["/^"]"$[]2"["[ ]\{0,1\}[:]\{0,1\}"]"$[]3"["[:]\{0,1\}[ ]\{0,1\}/ {p;q;}" ]"$[]1" dnl
])
# _DAS_FILE_DO_PARSE

# DAS_SHELL_FN()
# ------------------
# Defined shell functions
m4_defun([DAS_SHELL_FN],
[
# ------------------
# Defined function for dirname and basename
AS_FUNCTION_DESCRIBE([das_fn_dirname], [PATH], [Our version of dirname.])
das_fn_dirname()
{
	AS_DIRNAME([$[]1])
}
# das_fn_dirname
AS_FUNCTION_DESCRIBE([das_fn_basename], [PATH], [Our version of basename.])
das_fn_basename()
{
	AS_BASENAME([$[]1])
}
# das_fn_basename

# ------------------
AS_FUNCTION_DESCRIBE([das_fn_loc_in_path], [NAME], [dnl
Locate an executable in PATH.])
das_fn_loc_in_path()
{
(#subshell local vars
	# as_dir as built-in var
	_AS_PATH_WALK([$PATH],
	[
		AS_VAR_SET([f], "$as_dir/$[]1")
		DAS_HAS_FILE([$f], [
			AS_ECHO(["$as_dir/$[]1"])
			break 2
		])
	])
)
}
#das_fn_loc_in_path

# ------------------
AS_FUNCTION_DESCRIBE([das_fn_mydir], [], [Find out my dir.
case 1: ./foo or ~/foo
case 2: /foo
case 3: foo
case 4: sh foo])
das_fn_mydir()
{
	AS_ME_PREPARE
(#subshell local vars
	AS_VAR_SET([mydir], DAS_EXEC([das_fn_dirname "$as_myself"]))
	# check if case 3 or 4
	AS_VAR_IF([mydir], [], [
		# check if case 3
		AS_VAR_SET([try], DAS_EXEC([das_fn_loc_in_path "$as_me"]))
		AS_VAR_IF([try], [], [
			# case 4
			AS_VAR_SET([mydir], DAS_EXEC([pwd]))
		], [
			# case 3
			AS_VAR_SET([mydir], DAS_EXEC([das_fn_dirname "$try"]))
		])
		# AS_VAR_IF try
	])
	# AS_VAR_IF mydir

	AS_ECHO(["$mydir"])
)
}
#das_fn_mydir

# ------------------
AS_FUNCTION_DESCRIBE([das_fn_myself], [], [Private. Internal use only])
das_fn_myself()
{
(#subshell local vars
	AS_VAR_SET([bname], "$as_me")
	AS_VAR_SET([dname], DAS_EXEC([das_fn_mydir]))
	
	# cd cannot use DAS_EXEC or $() or ` `
	cd $dname
	AS_VAR_SET([tmp], DAS_EXEC([pwd])/$bname)
	# Need check if is a link
	while :
	do
		AS_IF([test -L $tmp], [AS_VAR_SET([tmp], DAS_EXEC([readlink "$tmp"]))],
		[
			# I'm now the final original
			AS_VAR_SET([bname], DAS_EXEC([das_fn_basename "$tmp"]))
			AS_VAR_SET([dname], DAS_EXEC([das_fn_dirname "$tmp"]))
			# cannot test -d $dname
			DAS_VAR_IFNOT([dname], [],
			[
				cd $dname
				AS_VAR_SET([dname], DAS_EXEC([pwd]))
			])
			break
		])
		# AS_IF
	done
	AS_ECHO(["$dname/$bname"])
)
}
# das_fn_myself

# ------------------
AS_FUNCTION_DESCRIBE([das_fn_locself], [], [dnl
Locate a script, provide path name.
Per a script /bin/test in which DAS_LOCSELF got expanded,
it emits /bin/test.

Another case is if you have a script /usr/sbin/foo, and had
performed symbol link (and renamed) to /bin/bar, and /bin/bar
was invoked, this macro emits /usr/sbin/foo, say the original.
NOTE: Maybe can't use BASH_SOURCE in m4sh if its BINSH is not
/bin/bash but /bin/sh.])
das_fn_locself()
{
	AS_ME_PREPARE
	AS_VAR_SET([das_pwd], DAS_EXEC([pwd]))
	AS_VAR_SET([das_myself], DAS_EXEC([das_fn_myself]))
	# restore pwd
	cd $das_pwd
	AS_VAR_SET([das_me], DAS_EXEC([das_fn_basename "$das_myself"]))
	AS_VAR_SET([das_myloc], DAS_EXEC([das_fn_dirname "$das_myself"]))
	AS_ECHO(["$das_myself"])
}
#das_fn_locself

# -------------------
#AS_FUNCTION_DESCRIBE([das_fn_exec], [cmd], [Exec cmd])
#das_fn_exec()
#{
#	$1
#}

# -------------------
AS_FUNCTION_DESCRIBE([das_fn_chkdir], [path], [Test and create a dir if not exist yet.])
das_fn_chkdir()
{
(#subshell local vars
	AS_VAR_SET([dname], [$[]1])
	DAS_HAS_FILE([$dname], [
		AS_ERROR(["$dname" exists as a file! Exit ...])
	])
	# HAS_FILE
	DAS_NO_DIR([$dname], [
		AS_MKDIR_P([$dname])
	])
	# NO_DIR
	DAS_NO_DIR([$dname], [
		AS_ERROR(["$dname" required but seems failed to create it. Exit...])
	])
	# NO_DIR
)
}
# das_fn_chkdir

# -------------------------------------
AS_FUNCTION_DESCRIBE([das_fn_str_trim], [String],
[Trim heading and tailing space, tab, etc])
das_fn_str_trim()
{
(#subshell local vars
	AS_VAR_SET([str], ["$[]1"])
	AS_ECHO(["$str"]) | [sed "s/^[ \t]*//g;s/[ \t\r\n]*$//g"]
)
}

# -------------------------------------
AS_FUNCTION_DESCRIBE([das_fn_str_parse_value],
[String, Key, Delim],
[Parse value against to a key from a string in cases 
Key=Value, Key:=Value, Key = Value, Key := Value, ...
now also support delim e.g. Key: Value, and as default
scenario.])
#Return the Value
das_fn_str_parse_value()
{
(#subshell local vars
	AS_VAR_SET([str], ["$[]1"])
	AS_VAR_SET([key], ["$[]2"])
	AS_VAR_SET([delim], ["$[]3"])
	AS_VAR_IF([delim], [], [
		# fall back to default delim ':'
		AS_VAR_SET([delim], [:])
	])
	AS_VAR_SET([str], DAS_EXEC([_DAS_STR_DO_PARSE([$str], [$key], [$delim])]))
	das_fn_str_trim "$str"
)
}
# das_fn_str_parse_value

# -------------------------------------
AS_FUNCTION_DESCRIBE([das_fn_file_parse_value],
[File, Key, Delim],
[Parse value against to a key from a string.])
#Return the Value
das_fn_file_parse_value()
{
(#subshell local vars
	AS_VAR_SET([file], ["$[]1"])
	AS_VAR_SET([key], ["$[]2"])
	AS_VAR_SET([delim], ["$[]3"])
	AS_VAR_SET([val])

	AS_VAR_IF([delim], [], [
		# fall back to default delim ':'
		AS_VAR_SET([delim], [:])
	])
	AS_VAR_SET([val], DAS_EXEC([_DAS_FILE_DO_PARSE([$file], [$key], [$delim])]))
	das_fn_str_parse_value "$val" "$key" "$delim"
)
}
# das_fn_file_parse_value

AS_FUNCTION_DESCRIBE([das_fn_dir_file_list],
[Path, Pattern, Need-Sort],
[Get file list of a folder.

Usage:
    list=$(das_fn_dir_file_list "." "*.txt") 	# no sort
    list=$(das_fn_dir_file_list "." "*.txt" "1") 	# list sorted
now you can use them like
    for f in $list; do
        echo "==$f"
    done
])
das_fn_dir_file_list()
{
(#subshell local vars
	AS_VAR_SET([path], [$[]1])
	AS_VAR_SET([pat], ["$[]2"])
	AS_VAR_SET([sorted], [$[]3])
	AS_VAR_SET([list])
	
	# cannot use list=(`find "$path" -name "$pat"`)
	list=`find "$path" -name "$pat"`
	# cannot use list=`ls $path/"$pat"`
	AS_VAR_IF([sorted], [], [
		AS_VAR_SET([list], DAS_EXEC([AS_ECHO(["$list"]) | sort]))
	])
	# AS_VAR_IF
	AS_ECHO(["$list"])
)
}
# das_fn_dir_file_list

# --------------------------
AS_FUNCTION_DESCRIBE([das_fn_str_field_count], [STR, [Delim]], [
Get cound of fields in the string STR.
Per "4:3:2:1", the delimiter is ":", count is 4.
Defalt delim is space ' '.])
das_fn_str_field_count()
{
(#subshell local vars
	AS_VAR_SET([str], ["$[]1"])
	AS_VAR_SET([delim], ["$[]2"])
	AS_VAR_IF([delim], [], [
		# fall back to default delim ' '
		AS_VAR_SET([delim], [ ])
	])

	AS_ECHO(["$str"]) | awk -F '"$delim"' '{print NF}'
)
}
# das_fn_str_field_count

# --------------------------
AS_FUNCTION_DESCRIBE([das_fn_str_get_field], [STR, INDEX, [Delim]], [
Get a specific field in the string STR.
Per "4:3:2:1", index starts from 1; get_field(2) returns "3".
Defalt delim is space ' '.])
das_fn_str_get_field()
{
(#subshell local vars
	AS_VAR_SET([str], ["$[]1"])
	AS_VAR_SET([index], ["$[]2"])
	AS_VAR_SET([delim], ["$[]3"])
	AS_VAR_IF([delim], [], [
		# fall back to default delim ' '
		AS_VAR_SET([delim], [ ])
	])

	AS_ECHO(["$str"]) | awk -F '"$delim"' '{print $'"$index"'}'
)
}
# das_fn_str_get_field

# -------------------
AS_FUNCTION_DESCRIBE([das_fn_chkctx], [], [Check execution context])
das_fn_chkctx()
{
	AS_VAR_SET([das_ctx], [0])
	m4_ifdef([AS_INIT], [AS_VAR_SET([das_ctx], [1])])
	m4_ifdef([AC_INIT], [AS_VAR_SET([das_ctx], [2])])
	m4_ifdef([AT_INIT], [AS_VAR_SET([das_ctx], [3])])
	# FIXME if not gcc/g++, see AC_PROG_CC code for reference
	AS_VAR_IF([das_ctx], [3], [
		DAS_NO_STR([$CC], [AS_VAR_SET([CC], [gcc])])
		DAS_NO_STR([$CXX], [AS_VAR_SET([CXX], [g++])])
	])
}
# das_fn_chkctx

# -------------------
das_fn_chkctx

])
#DAS_SHELL_FN

# DAS_WHILE(EXPR)
# ------------------
# Make a while() loops
# Usage example:
# DAS_WHILE([i <= 10], [m4_define([i], eval([i + 1]))])
# about m4_incr():
# m4_define([DAS_WHILE], m4_if([$#], [0], [[$0]], m4_incr($1), [1], [$2[]$0($@)])])
# report error, m4_incr doesn't work: das.m4:63: non-numeric argument to builtin `m4_incr'
# so use m4_eval()
# m4_define([DAS_WHILE], m4_if([$#], [0], [[$0]], m4_eval([$1 + 1]), [1], [$2[]$0($@)])])
# Got error too: das.m4:67: bad expression in eval: $1 + 1

# DAS_EXEC(CMD)
# ------------------
# Invoke a shell command to get output.
# is equals to m4_defun([DAS_EXEC], `$1`)
# NOTE: $(command) is not portable, but `command` should be ok
m4_defun([DAS_EXEC], `$1`)

# DAS_INTRO_SELF(VER)
# -------------------
# Introduce myself
m4_defun([DAS_INTRO_SELF],
[
	das_fn_locself >/dev/null
	AS_ECHO(["I'm $das_me (v$1) on $das_myloc, working on $das_pwd!"])
])
# DAS_INTRO_SELF

# DAS_CLIENT()
# -------------------
# My client whom I work for
m4_defun([DAS_CLIENT],
[
	das_fn_basename "$(pwd)"
])
# DAS_CLIENT

# DAS_STR_MATCH(STR, PAT)
# ------------------------
# Test if STR has substr PAT
m4_defun([DAS_STR_MATCH],
[dnl
	AS_ECHO(["$1"]) | sed -n "/$2/ p" dnl
])
# DAS_STR_MATCH

# DAS_STR_REPLACE(STR, KEY, NSTR)
# ------------------------
# Replace a pattern (key) in string variable to a new pattern (nstr).
# New pattern, allow be empty.
m4_defun([DAS_STR_REPLACE],
[dnl
	AS_ECHO(["$1"]) | sed -e "s/$2/$3/g" dnl
])
# DAS_STR_REPLACE

# DAS_STR_START_WITH_PATTERN(STR, PAT)
# ------------------------
# Test string starts with a pattern (excluding space ' ').
m4_defun([DAS_STR_START_WITH_PATTERN],
[dnl
	AS_ECHO(["$1"]) | sed -n "/^$2/ p" dnl
])
# DAS_STR_START_WITH_PATTERN

# DAS_STR_END_WITH_PATTERN(STR, PAT)
# ------------------------
# Test string ends with a pattern (excluding space ' ').
m4_defun([DAS_STR_END_WITH_PATTERN],
[dnl
	AS_ECHO(["$1"]) | sed -n "/$2""$/ p" dnl
])
# DAS_STR_END_WITH_PATTERN

# DAS_STR_LEFT_MATCH_EXACTLY(STR, PAT)
# ------------------------
# Test string has substr exactly left-match a pattern (excluding space ' ').
m4_defun([DAS_STR_LEFT_MATCH_EXACTLY],
[dnl
	AS_ECHO(["$1"]) | sed -n "/\<$2/ p" dnl
])
# DAS_STR_LEFT_MATCH_EXACTLY

# DAS_STR_MATCH_EXACTLY(STR, PAT)
# ------------------------
# Test string has substr exactly match a pattern (excluding space ' ').
m4_defun([DAS_STR_MATCH_EXACTLY],
[dnl
	AS_ECHO(["$1"]) | sed -n "/\<$2\>/ p" dnl
])
# DAS_STR_MATCH_EXACTLY
 
# DAS_DATA_ALLOW(CONTENTS)
# ---------------------------------
# Escape the invalid tokens with @&t@.
m4_defun([DAS_DATA_ALLOW],
[
	m4_bpatsubst([$1], [\(@.\)\(.@\)\|\(m4\|AS\)\(_\)\|\(d\)\(nl\)], [\1\3\5@&t@\2\4\6])
])
# DAS_DATA_ALLOW


# DAS_DATA(FILENAME, CONTENT)
# ---------------------------------
# Create a file
m4_defun([DAS_DATA],
[
DAS_HAS_STR(["$1"], [
cat >$1<<'_ATEOF'
DAS_DATA_ALLOW([$2])
_ATEOF
])
# HAS_STR
])
#DAS_DATA

# DAS_COMPILE_M4(FILEBASE, [FLAGS], [INCLUDE], BODY, [IF-SUCC], [IF-FAIL])
# ------------------------------------------
# Create m4 code spinet file FILEBASE.m4 and compile it.
m4_defun([DAS_COMPILE_M4],
[
	DAS_DATA([$1.m4],
	[
$3
m4_init
$4
	])
	#DAS_DATA

	autom4te --language=m4sugar $2 --force -Wall $1.m4 -o $1
	das_compile_status=$?
	AS_IF([test $das_compile_status -eq 0], [$5], [$6])
])
# DAS_COMPILE_M4

# DAS_COMPILE_M4SH(FILEBASE, [FLAGS], [INCLUDE], BODY, [IF-SUCC], [IF-FAIL])
# ------------------------------------------
# Create m4sh code spinet file FILEBASE.as and compile it.
m4_defun([DAS_COMPILE_M4SH],
[
	DAS_DATA([$1.as],
	[
$3
AS_INIT
# Exit-status, default to 0: succ. You may re-set it to
# your own status value during in BODY, so AS_EXIT could
# emit your value.
AS_VAR_SET([m4shcode], [0])
$4
AS_EXIT([$m4shcode])
	])
	#DAS_DATA

	autom4te --language=m4sh $2 --force -Wall $1.as -o $1
	das_compile_status=$?
	AS_IF([test $das_compile_status -eq 0], [$5], [$6])
])
# DAS_COMPILE_M4SH

# DAS_COMPILE(FILEBASE, [FLAGS], [INCLUDE], BODY, [IF-SUCC], [IF-FAIL])
# --------------------------------------------
# Create C code spinet file FILEBASE.c and compile it.
m4_defun([DAS_COMPILE],
[
	DAS_DATA([$1.c],
	[
$3
int main(void)
{
$4
	return 0;
}
	])
	#DAS_DATA

	$CC $CPPFLAGS $CFLAGS $LDFLAGS -Wall -O3 $2 -o $1 $1.c
	das_compile_status=$?
	AS_IF([test $das_compile_status -eq 0], [$5], [$6])
])
# DAS_COMPILE

# DAS_COMPILE_CXX(FILEBASE, [FLAGS], [INCLUDE], BODY, [IF-SUCC], [IF-FAIL])
# --------------------------------------------
# Create C++ code spinet file FILEBASE.c and compile it.
m4_defun([DAS_COMPILE_CXX],
[
	DAS_DATA([$1.cpp],
	[
$3
int main(void)
{
$4
	return 0;
}
	])
	#DAS_DATA

	$CXX $CPPFLAGS $CXXFLAGS $LDFLAGS -Wall -O3 $2 -o $1 $1.cpp
	das_compile_status=$?
	AS_IF([test $das_compile_status -eq 0], [$5], [$6])
])
# DAS_COMPILE_CXX

