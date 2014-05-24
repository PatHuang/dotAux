
# This template could be processed by da_as or
#   autom4te --language=m4sh
# to generate portable shell script.
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

# @file daln
#
# Utility of dotAux for making links, etc.
#
# @author Pat Huang
#
# @version v0.1r04
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02, 2009dec04, Pat, finished this source file.
#    r04, 2014apr27, Pat, updating due to new dotAux macros.
# @endverbatim
#-------------------------------------------------------------------

m4_include([dmeta/das.m4])

AS_INIT

# Prepare shell functions from dotAux lib.
DAS_SHELL_FN

DAS_DEF_VAR([myversion], [0.1.0.4])

AS_FUNCTION_DESCRIBE([usage], [], [Help info of myself.])
usage()
{
	AS_MESSAGE([Usage and optinos:])
	AS_MESSAGE([ <link> <pattern>
	echo "This utility links a source (file or folder) to current location as <link>"
AS_HELP_STRING([[link]],
[Source and Dest (the link) name.])
AS_HELP_STRING([[pattern]],
[Source path pattern.])
AS_HELP_STRING([[-h|--help]],
[Display help info])
AS_HELP_STRING([[-V|--version]],
[Display version info])
	])
	# AS_MESSAGE
}

DAS_DEF_VAR([opts], DAS_EXEC([getopt -o hV -l help -l version "$@"]))
DAS_DEF_VAR([code], [$?])
DAS_STATUS_FAIL([$code], [
	usage
	AS_ERROR([Incorrect argument list])
])
DAS_UNDEF_VAR([code])

eval set -- "$opts"

(#subshell local vars
AS_VAR_SET([src], [$1])
AS_VAR_SET([pat], ["$2"])
AS_VAR_SET([spath], [..])
AS_VAR_SET([list])
AS_VAR_SET([found])
AS_VAR_SET([timeout], [20])

AS_MESSAGE([Searching for "$src", matching "$pat"...])
AS_VAR_SET([pat], DAS_EXEC([DAS_STR_REPLACE([$pat], [\/], [_])])) #AS_ECHO(["$pat"]) | sed "s/\//_/g"]))
while :
do
	AS_IF([timeout], [0], [
		AS_WARN([Timeout])
		break
	])
	AS_MESSAGE([Search on path "$spath"])
	AS_VAR_SET([list], DAS_EXEC([das_fn_dir_file_list "$spath" "$src"]))
(#subshell local vars
	AS_FOR([], [t], [$list], [
		AS_VAR_IF([pat], [], [
			AS_MESSAGE([Found $t, link it])
			AS_LN_S([$t], DAS_EXEC([das_fn_basename "$t"]))
			return
		],
		[
			AS_VAR_SET([found], DAS_EXEC([DAS_STR_REPLACE([$t], [\/], [_])])) #AS_ECHO(["$t"]) | sed "s/\//_/g")
			AS_VAR_SET([found], DAS_EXEC([DAS_STR_MATCH([$found], [$pat])]))
			DAS_HAS_STR(["$found"], [
				AS_MESSAGE([Found $t, link it])
				AS_LN_S([$t], DAS_EXEC([das_fn_basename "$t"]))
				return
			])
			# DAS_HAS_STR
		])
		# AS_VAR_IF
	])
	# AS_FOR
)
	AS_VAR_SET([spath], [$spath/..])
	AS_VAR_ARITH([timeout], [$timeout - 1])
done
# while do
)

