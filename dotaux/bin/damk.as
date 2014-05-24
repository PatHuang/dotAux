
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

# @file damk
#
# Utility of dotAux for auto-config, make/build, etc.
#
# @author Pat Huang
#
# @version v0.1r04
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02, 2009dec02, Pat, finished this source file.
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
[da_folder: Your local dotAux folder])
AS_HELP_STRING([[-c]],
[config, is equal to ./configure --prefix=/abc.])
AS_HELP_STRING([[--clean]],
[clean, is equal to make clean])
AS_HELP_STRING([[--dclean]],
[dclean, is equal to make distclean])
AS_HELP_STRING([[--aclean]],
[aclean, is equal to make clean && make distclean])
AS_HELP_STRING([[-m]],
[make, is equal to make.])
AS_HELP_STRING([[--cmake]],
[cmake, is equal to make check.])
AS_HELP_STRING([[--dmake]],
[dmake, is equal to make dist.])
AS_HELP_STRING([[--amake]],
[amake, is equal to make && make check.])
AS_HELP_STRING([[-i]],
[inst, is equal to make install.])
AS_HELP_STRING([[--tinst]],
[tinst, is equal to make DESTDIR=pwd-inst install.])
	])
	# AS_MESSAGE
}

DAS_DEF_VAR([opts], DAS_EXEC([getopt -o hVa:cmi -l help -l version -l aux: -l clean -l dclean -l aclean -l cmake -l dmake -l amake -l tinst -- "$@"]))
DAS_DEF_VAR([code], [$?])
DAS_STATUS_FAIL([$code], [
	usage
	AS_ERROR([Incorrect argument list])
])
DAS_UNDEF_VAR([code])

eval set -- "$opts"

# Default dotAux folder
DAS_DEF_VAR([da_folder], [dotaux])

# Default function - setup
# Available functions:
# setup, is equal to autoreconf -ivf -Wall, etc.
# config, is equal to ./configure --prefix=/abc.
# clean, is equal to make clean.
# dclean, is equal to make distclean.
# aclean, is equal to make clean && make distclean.
# make, is equal to make.
# cmake, is equal to make check.
# dmake, is equal to make dist.
# amake, is equal to make && make check.
# inst, is equal to make install.
# tinst, is equal to make DESTDIR=pwd-inst install.
DAS_DEF_VAR([fn], [setup])

while :
do
	AS_CASE([$1],
		[-h|--help], [usage; AS_EXIT],
		[-V|--version], [AS_ECHO(["$myversion"]); AS_EXIT],
		[-a|--aux], [AS_VAR_SET([da_folder], [$2]); shift 2],
		[-c], [AS_VAR_SET([fn], [config]); shift],
		[--clean], [AS_VAR_SET([fn], [clean]); shift],
		[--dclean], [AS_VAR_SET([fn], [dclean]); shift],
		[--aclean], [AS_VAR_SET([fn], [aclean]); shift],
		[-m], [AS_VAR_SET([fn], [make]); shift],
		[--cmake], [AS_VAR_SET([fn], [cmake]); shift],
		[--dmake], [AS_VAR_SET([fn], [dmake]); shift],
		[--amake], [AS_VAR_SET([fn], [amake]); shift],
		[-i], [AS_VAR_SET([fn], [inst]); shift],
		[--tinst], [AS_VAR_SET([fn], [tinst]); shift],
		[--], [shift; break],
		[
			usage
			AS_ERROR([Unknown options: $@])
		]
	)
	# AS_CASE
done

DAS_INTRO_SELF([$myversion])

# Test if package dotAux or otherwise
DAS_NO_FILE([configure.ac], [
	AS_ERROR([configure.ac not found. Looks it isn't a Source folder, abort...])
])
DAS_DEF_VAR([metadir], [$da_folder/dmeta])

# Test dotAux if exists. Our Magic
DAS_NO_FILE([$metadir/da.conf], [
	AS_ERROR([$metadir/da.conf not found])
])
# NO_FILE

# opts == vpath
AS_VAR_SET([opts], DAS_EXEC([das_fn_file_parse_value "$metadir/da.conf" "VPATH" "="]))
AS_IF([test x"$opts" = x1 -o x"$opts" = x], [
	AS_VAR_SET([opts], [$das_pwd/build])
],
[! test -d $opts], [
	AS_VAR_SET([opts], [$das_pwd])
])
# AS_IF

DAS_DEF_VAR([myclient], DAS_EXEC([DAS_CLIENT]))

DAS_NO_FILE([configure], [
	AS_VAR_IF([fn], [config], [
		AS_ERROR([configure not created yet. Might need to try without any option first (means do setup).])
	])
	# AS_VAR_IF
])
# NO_FILE
DAS_NO_DIR([$opts], [
	AS_VAR_IF([fn], [config], [das_fn_chkdir "$opts"])
])
# NO_DIR
DAS_NO_DIR([$opts], [
	DAS_VAR_IFNOT([fn], [setup], [
		AS_ERROR([$opts not created yet. Might need to try with "-c" option first.])
	])
	# DAS_VAR_IFNOT
])
# NO_DIR

AS_CASE([$fn],
	[setup], [autoreconf -ivf -Wall],
	[config], [cd $opts; $das_pwd/configure --prefix=/usr/local/$myclient; cd $das_pwd],
	[clean], [cd $opts; make clean; cd $das_pwd],
	[dclean], [cd $opts; make distclean; cd $das_pwd],
	[aclean], [cd $opts; make clean && make distclean; cd $das_pwd],
	[make], [cd $opts; make all; cd $das_pwd],
	[cmake], [cd $opts; make check; cd $das_pwd],
	[dmake], [cd $opts; make dist; cd $das_pwd],
	[amake], [cd $opts; make all && make check; cd $das_pwd],
	[inst], [cd $opts; sudo make install; cd $das_pwd],
	[tinst], [cd $opts; make DESTDIR=$opts/inst install; cd $das_pwd],
	[
		AS_ERROR([Unknown function: $fn])
	]
)

DAS_UNDEF_VAR([opts])

DAS_UNDEF_VAR([fn])
DAS_UNDEF_VAR([da_folder])
DAS_UNDEF_VAR([metadir])
DAS_UNDEF_VAR([myclient])
DAS_UNDEF_VAR([myversion])

AS_MESSAGE([Done!])

AS_EXIT([0])

