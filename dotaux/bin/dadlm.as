
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

# @file dadlm
#
# Utility of Dolem and gnulib import or cleanup, etc.
#
# @author Pat Huang
#
# @version v0.1r04
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02, 2009dec03, Pat, finished this source file.
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
	AS_MESSAGE([dnl
AS_HELP_STRING([[-h|--help]],
[Display help info])
AS_HELP_STRING([[-V|--version]],
[Display version info])
AS_HELP_STRING([[-a[da_folder]|--aux=da_folder]],
[da_folder: Your local dotAux folder to store stuff from dotAux distro])
AS_HELP_STRING([[-d[dlm_folder]|--dolem=dlm_folder]],
[dlm_folder: Your local Dolem folder to store stuff from Dolem and gnulib])
AS_HELP_STRING([[-c|--clean]],
[function clean, call dotAux's clean, and clear Dolem and gnulib, etc. If not specified, default function is setup, call dotAux's setup and import Dolem and gnulib.])
AS_HELP_STRING([[-k[namelist]|--keep=namelist]],
[namelist: Dont' clear files or folders in namelist which looks like "name1,name2,name3..."])
	])
	# AS_MESSAGE
}

DAS_DEF_VAR([opts], DAS_EXEC([getopt -o hVa:d:k:c -l help -l version -l aux: -l dolem: -l keep: -l clean -- "$@"]))
DAS_DEF_VAR([code], [$?])
DAS_STATUS_FAIL([$code], [
	usage
	AS_ERROR([Incorrect argument list])
])

eval set -- "$opts"

# Default dotAux folder
DAS_DEF_VAR([da_folder], [dotaux])
# Default Dolem folder
DAS_DEF_VAR([dlm_folder], [dolem])
DAS_DEF_VAR([kp_namelist])
# Default function - setup
# Available functions:
# setup, call dotAux's setup and import Dolem and gnulib.
# clean, call dotAux's clean, and clear Dolem and gnulib, etc.
DAS_DEF_VAR([fn], [setup])

while :
do
	AS_CASE([$1],
		[-h|--help], [usage; AS_EXIT],
		[-V|--version], [AS_ECHO(["$myversion"]); AS_EXIT],
		[-a|--aux], [AS_VAR_SET([da_folder], [$2]); shift 2],
		[-a|--dolem], [AS_VAR_SET([dlm_folder], [$2]); shift 2],
		[-k|--keep], [AS_VAR_SET([kp_namelist], [$2]); shift 2],
		[-c|--clean], [AS_VAR_SET([fn], [clean]); shift],
		[--], [shift; break],
		[
			usage
			AS_ERROR([Unknown options: $@])
		]
	)
	# AS_CASE
done

DAS_INTRO_SELF([$myversion])

# My Magic
DAS_NO_FILE([$dlm_folder/gl.conf], [
	AS_ERROR([$dlm_folder/gl.conf not found, you need to specify gnulib source path in it. abort...])
])
DAS_DEF_VAR([metadir], [$da_folder/dmeta])
DAS_DEF_VAR([myclient], DAS_EXEC([DAS_CLIENT]))

AS_FUNCTION_DESCRIBE([do_copy], [], [Copy stuff.])
do_copy()
{
	AS_MESSAGE([Copy and import...])
(#subshell local vars
	AS_VAR_SET([sbase], [$dlm_folder/lib])
	AS_VAR_SET([mbase], [$dlm_folder/m4])
	AS_VAR_SET([dbase], [$dlm_folder/doc])
	AS_VAR_SET([tbase], [$dlm_folder/tests])

	DAS_NO_DIR([$mbase], [
		AS_MKDIR_P([$sbase])
		AS_MKDIR_P([$mbase])
	])

	AS_VAR_SET([glimport], DAS_EXEC([das_fn_file_parse_value $dlm_folder/gl.conf "SRC" "="]))
	AS_VAR_APPEND([glimport], [/gnulib-tool])
	AS_IF([! AS_EXECUTABLE_P([$glimport])], [
		AS_ERROR([Seems $glimport is not executable or doens't exist, abort...])
	])
	AS_VAR_SET([opts], DAS_EXEC([das_fn_file_parse_value $dlm_folder/gl.conf "LICENSE" "="]))
	DAS_HAS_STR([$opts], [
		AS_VAR_APPEND([glimport], [" --$opts"])
	])
	AS_VAR_SET([opts], DAS_EXEC([das_fn_file_parse_value $dlm_folder/gl.conf "LIBNAME" "="]))
	AS_IF([test x"$opts" != x], [
		AS_VAR_APPEND([glimport], [" --lib=lib$opts"])
	],
	[
		AS_VAR_APPEND([glimport], [" --lib=libdolem"])
	])
	AS_VAR_APPEND([glimport], [" --no-vc-files --libtool --import --source-base=$sbase --m4-base=$mbase --doc-base=$dbase --tests-base=$tbase"])
	AS_VAR_SET([opts], DAS_EXEC([das_fn_file_parse_value $dlm_folder/gl.conf "MOD_LIST" "="]))
	DAS_NO_FILE([$opts], [
		AS_IF([test -f $dlm_folder/$opts], [
			AS_VAR_SET([opts], [$dlm_folder/$opts])
		],
		[
			AS_ERROR([Seems gnulib module list '$opts' or $dlm_folder/$opts doens't exist, abort...])
		])
	])
	$glimport "`cat $opts`"

	# ----GPL Modules----
	# assert

)
	AS_MESSAGE([gnulib imported])

	AS_MESSAGE([Now if you need to install gnulib headers and library, update gnulib generated makefile as the following:])
	AS_MESSAGE([  1. Change line "noinst_LTLIBRARIES += libgnu.la" to "lib_LTLIBRARIES = libgnu.la".])
	AS_MESSAGE([  2. Add two lines after _la_SOURCES:])
	AS_MESSAGE([      pkgincludedir = $(includedir)/dolem/gl])
	AS_MESSAGE([      EXTRA_HEADERS = ])
	AS_MESSAGE([  NOTE: Above are just the examples, use your own lib name and header include dir.])
	AS_MESSAGE([  3. Add a line after the last "BUILT_SOURCES += XXXX":])
	AS_MESSAGE([      nobase_pkginclude_HEADERS = $(BUILT_SOURCES)])
}
# do_copy

AS_FUNCTION_DESCRIBE([clear_dlm], [], [Clear dlm_folder.])
clear_dlm()
{
(#subshell local vars
	AS_VAR_SET([found], DAS_EXEC([DAS_STR_MATCH([$kp_namelist], [$dlm_folder])]))
	AS_IF([test x"$found" != x], [
		AS_MESSAGE([Keep $dlm_folder])
	],
	[
		AS_MESSAGE([Don't keep $dlm_folder])
		AS_VAR_SET([sbase], [$dlm_folder/lib])
		AS_VAR_SET([mbase], [$dlm_folder/m4])
		AS_VAR_SET([dbase], [$dlm_folder/doc])
		AS_VAR_SET([tbase], [$dlm_folder/tests])
		rm -rf $sbase $mbase $dbase $tbase
	])
	# AS_IF
)
}
# clear_dlm

AS_CASE([$fn],
[setup], [
	AS_MESSAGE([Function is setup...])
	# call dotAux
	AS_IF([AS_EXECUTABLE_P([$das_myloc/dotaux])], [
$das_myloc/dotaux
	])
	AS_VAR_SET([code], [$?])
	DAS_STATUS_FAIL([$code], [
		AS_ERROR([Seems dotAux failed with code $code, abort...])
	])

	do_copy
],
[clean], [
	AS_MESSAGE([Function is clean...])
	clear_dlm

	# call dotAux
	AS_IF([test x"$kp_namelist" = x], [
$das_myloc/dotaux -c
	],
	[
$das_myloc/dotaux -c -k"$kp_namelist"
	])
	AS_VAR_SET([code], [$?])
	DAS_STATUS_FAIL([$code], [
		AS_ERROR([Seems dotAux failed with code $code, abort...])
	])
	# Log file
	AS_VAR_SET([opts], [$das_pwd/../dotaux.log])
],
[
	AS_ERROR([Unknown function $fn])
])
DAS_UNDEF_VAR([code])
DAS_UNDEF_VAR([opts])

DAS_UNDEF_VAR([fn])
DAS_UNDEF_VAR([da_folder])
DAS_UNDEF_VAR([dlm_folder])
DAS_UNDEF_VAR([metadir])
DAS_UNDEF_VAR([myclient])
DAS_UNDEF_VAR([myversion])

AS_MESSAGE([Done!])

AS_EXIT([0])

