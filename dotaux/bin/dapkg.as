
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

# @file dapkg
#
# Utility of Package dotAux for package setup or packing, etc.
#
# @author Pat Huang
#
# @version v0.1r08
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02-06, 2009dec04, Pat, finished this source file.
#    r08, 2014apr27, Pat, updating due to new dotAux macros.
# @endverbatim
#-------------------------------------------------------------------

m4_include([dmeta/das.m4])

AS_INIT

# Prepare shell functions from dotAux lib.
DAS_SHELL_FN

DAS_DEF_VAR([myversion], [0.1.0.8])

AS_FUNCTION_DESCRIBE([usage], [], [Help info of myself.])
usage()
{
	AS_MESSAGE([Usage and optinos:])
	AS_MESSAGE([dnl
AS_HELP_STRING([[-h|--help]],
[Display help info])
AS_HELP_STRING([[-V|--version]],
[Display version info])
AS_HELP_STRING([[-a[pa_folder]|--aux=pa_folder]],
[pa_folder: Your local Package dotAux folder to store stuff from dotAux distro])
AS_HELP_STRING([[-p|--pack]],
[function pack, build a package tarball. If not specified, default function is setup, to setup initial Package dotAux folder.])
	])
	# AS_MESSAGE
}

DAS_DEF_VAR([opts], DAS_EXEC([getopt -o hVa:p -l help -l version -l aux: -l pack -- "$@"]))
DAS_DEF_VAR([code], [$?])
DAS_STATUS_FAIL([$code], [
	usage
	AS_ERROR([Incorrect argument list])
])
DAS_UNDEF_VAR([code])

eval set -- "$opts"

# Default pkg-aux folder
DAS_DEF_VAR([pa_folder], [paux])
# Default function - setup
# Available functions:
# setup, setup Package dotAux
# pack, build the package tar ball
DAS_DEF_VAR([fn], [setup])

while :
do
	AS_CASE([$1],
		[-h|--help], [usage; AS_EXIT],
		[-V|--version], [AS_ECHO(["$myversion"]); AS_EXIT],
		[-a|--aux], [AS_VAR_SET([pa_folder], [$2]); shift 2],
		[-p|--pack], [AS_VAR_SET([fn], [pack]); shift],
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
DAS_HAS_FILE([configure.ac], [
	AS_ERROR([configure.ac found. Looks it isn't a Package, abort...])
])
# Test package dotAux if exists. Our Magic
AS_IF([test -f $pa_folder/pa.conf], [ 
	AS_VAR_IF([fn], [setup], [
		AS_WARN([Package dotAux already exists. Will do a reset])
	])
],
[
	DAS_VAR_IFNOT([fn], [setup], [
		AS_ERROR([$pa_folder/pa.conf not found])
	])
])
# AS_IF

DAS_DEF_VAR([myclient], DAS_EXEC([DAS_CLIENT]))
AS_VAR_IF([fn], [setup], [
	# Test and create pa_folder
	das_fn_chkdir "$pa_folder/tmp"
	AS_MESSAGE([Copy myself...])
	cp -f "$das_myself" "$pa_folder"/
	AS_MESSAGE([Testing $pa_folder/$das_me...])
	AS_VAR_SET([opts], DAS_EXEC([./"$pa_folder"/$das_me --version]))
	AS_MESSAGE([Compare version "$opts" and "$myversion"...])
	AS_VERSION_COMPARE([$opts], [$myversion], [opts="<"], [opts="="], [opts=">"])
	DAS_VAR_IFNOT([opts], [=], [
		AS_ERROR([Test "$pa_folder/$das_me" FAIL])
	])
	AS_MESSAGE([Prepared package dotAux folder: $pa_folder])

	AS_ECHO(['NAME_PATTERN = date +%Y%b%d.%H%M']) >$pa_folder/pa.conf
	AS_MESSAGE([Assume your package name is: $myclient.])
	AS_MESSAGE([Tarball name pattern is stored in $pa_folder/pa.conf])
	AS_MESSAGE([Testing pa.conf ...])
])
# AS_VAR_IF
AS_VAR_SET([myversion], DAS_EXEC([das_fn_file_parse_value "$pa_folder/pa.conf" "NAME_PATTERN" "="]))
AS_VAR_SET([myversion], DAS_EXEC([$myversion]))
AS_VAR_SET([myversion], ["$myclient"."$myversion".tar.bz2])
AS_MESSAGE([Package name will be in a form of $myversion])

DAS_DEF_VAR([linklist], [$pa_folder/links])
DAS_DEF_VAR([alllist], [$pa_folder/list])

AS_VAR_IF([fn], [setup], [
	AS_MESSAGE([Init link and file list ...])
	find . -type l | sort >$linklist
	find . | sort >$alllist
],
[
	AS_MESSAGE([Check link and file list ...])
	# Log file
	AS_VAR_SET([opts], [$das_pwd/../dapkg.log])
	date >$opts
	AS_ECHO(["==============Link and File List============"]) >>$opts
	cp -f $linklist $pa_folder/tmp/links
	find . -type l | sort >$linklist
	diff $linklist $pa_folder/tmp/links >>$opts 2>&1
	cp -f $alllist $pa_folder/tmp/list
	find . | sort >$alllist
	diff $alllist $pa_folder/tmp/list >>$opts 2>&1
	# keep one history log on tmp
	#rm -f $pa_folder/tmp/*
	AS_MESSAGE([Build package tarball ...])
	AS_ECHO(["==============Tarball Log============"]) >>$opts
	cd ../
	# backup
	mv -f $myversion $myversion.bak >/dev/null 2>&1
	tar jcvf "$myversion" "$myclient" >>$opts 2>&1
	cd "$das_pwd"
	AS_MESSAGE([Package tarball ../$myversion created."])
	AS_MESSAGE([See $opts for some log])
])
# AS_VAR_IF
DAS_UNDEF_VAR([opts])

DAS_UNDEF_VAR([linklist])
DAS_UNDEF_VAR([alllist])
DAS_UNDEF_VAR([fn])
DAS_UNDEF_VAR([pa_folder])
DAS_UNDEF_VAR([myclient])
DAS_UNDEF_VAR([myversion])

AS_MESSAGE([Done!])

AS_EXIT([0])

