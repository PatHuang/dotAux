
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

# @file dotaux
#
# Utility of dotAux for setup or cleanup, etc.
#
# @author Pat Huang
#
# @version v0.1r06
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02-04, 2009dec03, Pat, finished this source file.
#    r06, 2014apr27, Pat, updating due to new dotAux macros.
# @endverbatim
#-------------------------------------------------------------------

m4_include([dmeta/das.m4])

AS_INIT

# Prepare shell functions from dotAux lib.
DAS_SHELL_FN

DAS_DEF_VAR([myversion], [0.1.0.6])

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
AS_HELP_STRING([[-c|--clean]],
[function clean, clear all and clear autotools generated files such as aclocal, etc. If not specified, default function is setup, to setup initial dotAux folder.])
	])
	# AS_MESSAGE
}

DAS_DEF_VAR([opts], DAS_EXEC([getopt -o hVa:c -l help -l version -l aux: -l clean -- "$@"]))
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
# setup, setup dotAux
# clean, clear all and clear autotools generated files such as aclocal, etc.
DAS_DEF_VAR([fn], [setup])

while :
do
	AS_CASE([$1],
		[-h|--help], [usage; AS_EXIT],
		[-V|--version], [AS_ECHO(["$myversion"]); AS_EXIT],
		[-a|--aux], [AS_VAR_SET([da_folder], [$2]); shift 2],
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

# Test if package dotAux or otherwise
DAS_NO_FILE([configure.ac], [
	AS_ERROR([configure.ac not found. Looks it isn't a Source folder, abort...])
])
DAS_DEF_VAR([metadir], [$da_folder/dmeta])

# Test dotAux if exists. Our Magic
AS_IF([test -f "$metadir/da.conf"],
[
	AS_VAR_IF([fn], [setup], [
		AS_WARN([dotAux already exists. Will do a reset])
	])
],
[
	DAS_VAR_IFNOT([fn], [setup], [
		AS_ERROR([$metadir/da.conf not found])
	])
])
# AS_IF

DAS_DEF_VAR([myclient], DAS_EXEC([DAS_CLIENT]))
AS_CASE([$fn],
[setup], [
	AS_MESSAGE([Function is setup...])
	# Test and create da_folder
	das_fn_chkdir "$metadir"
	AS_MESSAGE([Copy myself...])
	cp -f "$das_myself" "$da_folder"/
	cp -f "$das_myloc/damk" "$da_folder"/
	AS_MESSAGE([Testing $da_folder/$das_me...])
	AS_VAR_SET([opts], DAS_EXEC([./"$da_folder"/$das_me --version]))
	AS_MESSAGE([Compare version "$opts" and "$myversion"...])
	AS_VERSION_COMPARE([$opts], [$myversion], [opts="<"], [opts="="], [opts=">"])
	DAS_VAR_IFNOT([opts], [=], [
		AS_ERROR([Test "$da_folder/$das_me" FAIL])
	])
	AS_MESSAGE([Copy metadata...])
	cp -f "$das_myloc/../share/dotaux/ext/tap-driver.sh" "$da_folder"/
	cp -f "$das_myloc/../share/dotaux/ext/ax_prefix_config_h.m4" "$da_folder"/
	cp -f "$das_myloc/../share/dotaux/dmeta/das.m4" "$metadir"/
	cp -f "$das_myloc/../share/dotaux/dmeta/dat.m4" "$metadir"/
	AS_MESSAGE([Prepared dotAux folder with meta subfolder: $metadir])

	AS_MESSAGE([Testing local include path $das_pwd/$da_folder...])
	DAS_NO_DIR([$das_pwd/$da_folder], [
		AS_WARN([local include path $das_pwd/$da_folder not exist?])
	])
	#AS_ECHO(["FLAGS = -I $das_pwd/$da_folder"]) >$metadir/da.conf
	AS_ECHO(["VPATH = 1"]) >$metadir/da.conf
	AS_MESSAGE([Environment like local include path of dotAux lib such as m4, etc, and options, are stored in $metadir/da.conf])
],
[clean], [
	AS_MESSAGE([Function is clean...])
	DAS_HAS_FILE([Makefile], [make clean; make distclean])
	# clear da_folder
	cp -rf $da_folder $da_folder.tmp
	rm -rf $da_folder/*
	mv -f $da_folder.tmp/dmeta $da_folder/
	mv -f $da_folder.tmp/tap-driver.sh $da_folder/
	mv -f $da_folder.tmp/ax_prefix_config_h.m4 $da_folder/
	mv -f $da_folder.tmp/$das_me $da_folder/
	
	rm -rf $da_folder.tmp

	# clear generated stuff by autotools
	rm -f aclocal.m4 configure >/dev/null 2>&1
	rm -rf autom4te.cache >/dev/null 2>&1
	rm -f autoscan.log configure.scan config.h.in~ configure.ac~
	find . -name "Makefile.in" -exec rm -f {} \;
	# clear dist package
	rm -rf $myclient-*
	# clear dist and build dir
	rm -rf inst build
	# Log file
	AS_VAR_SET([opts], [$das_pwd/../dotaux.log])
],
[
	AS_ERROR([Unknown function $fn])
])
DAS_UNDEF_VAR([opts])

DAS_UNDEF_VAR([fn])
DAS_UNDEF_VAR([da_folder])
DAS_UNDEF_VAR([metadir])
DAS_UNDEF_VAR([myclient])
DAS_UNDEF_VAR([myversion])

AS_MESSAGE([Done!])

AS_EXIT([0])

