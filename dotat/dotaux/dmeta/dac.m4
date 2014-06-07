
# This file should be included by an Autoconf script template
# (e.g. some-test.ac), so the template could be processed
# by ma_ac or autom4te --language=autoconf to generate portable
# autotest script (some-test, in this example)
#

#---------------------------------------
#
# Copyright (c) 2010-2014 The dotAux project.
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

# @file dac.m4
#
# @author Pat Huang
#
# @version v0.1r04
# @par ChangeLog:
# @verbatim
#  ver 0.1-
#    r02, 2010may03, Pat, finished this Effo Core M4 source file.
#    r04, 2014apr24, Pat, Moved this M4 from Effo Core and later
#      Dolem project here as dotAux macros.
# @endverbatim
#-------------------------------------------------------------------

# You need to include das.m4 as the basic lib.

m4_pattern_forbid([^_?DAS_])
m4_pattern_forbid([^_?DAC_])

# DAC_MSG_NOTICE(MSG)
# ---------------------------
# Add leading "-Dolem:" to output message.
AC_DEFUN([DAC_MSG_NOTICE], [AC_MSG_NOTICE([-Dolem: $1])])

# DAC_MSG_WARN(MSG)
# ---------------------------
# Add leading "-Dolem:" to output message.
AC_DEFUN([DAC_MSG_WARN], [AC_MSG_WARN([-Dolem: $1])])

# DAC_MSG_ERROR(MSG)
# ---------------------------
# Add leading "-Dolem:" to output message.
AC_DEFUN([DAC_MSG_ERROR], [AC_MSG_ERROR([-Dolem: $1])])

# DAC_MSG_CHECKING(MSG)
# ---------------------------
# Add leading "-Dolem:" to output message.
AC_DEFUN([DAC_MSG_CHECKING], [AC_MSG_CHECKING([-Dolem: $1])])

# DAC_DLM_SET_SKIP(VAL)
# ---------------------------
# Set value to global var dac_dlm_skip.
# Set to 1 by default.
AC_DEFUN([DAC_DLM_SET_SKIP],
[
	AS_IF([test x"$1" = x], [
		AS_VAR_SET([dac_dlm_skip], [1])
	],
	[
		AS_VAR_SET([dac_dlm_skip], ["$1"])
	])
	# AS_IF
])
# DAC_DLM_SET_SKIP

# DAC_DLM_SKIP(ACTION)
# ---------------------------
# Test value of global var dac_dlm_skip, take action if skip.
AC_DEFUN([DAC_DLM_SKIP],
[
	AS_VAR_IF([dac_dlm_skip], [1], [$1])
])
# DAC_DLM_SKIP

# DAC_DLM_NOTSKIP(ACTION)
# ---------------------------
# Test value of global var dac_dlm_skip, take action if not skip.
AC_DEFUN([DAC_DLM_NOTSKIP],
[
	DAS_VAR_IFNOT([dac_dlm_skip], [1], [$1])
])
# DAC_DLM_NOTSKIP

# DAC_DLM_CHK_SKIP(VAR, ACTION)
# ---------------------------
# Test if VAR is 1 then SET_SKIP and take action.
AC_DEFUN([DAC_DLM_CHK_SKIP],
[
	AS_VAR_IF([$1], [1], [
		DAC_DLM_SET_SKIP
		$2
	])
])
# DAC_DLM_CHK_SKIP

# DAC_DLM_SET_ID(VAL)
# ---------------------------
# Set value to global var dac_dlm_id.
AC_DEFUN([DAC_DLM_SET_ID],
[
	AS_VAR_SET([dac_dlm_id], ["$1"])
])
# DAC_DLM_SET_ID

# DAC_DLM_TEST_EID(COND)
# ----------------------
# @private
# Shall only be used by dac_fn_test_eid_val()
AC_DEFUN([DAC_DLM_TEST_EID],
[
	AS_VAR_SET([code], [0])
	
	DAC_DLM_NOTSKIP([
		AC_COMPILE_IFELSE([
			AC_LANG_PROGRAM([], [
#if $1
#else
	return abc;
#endif
			])
		],
		[AS_VAR_SET([code], [1])]
		)
		# AC_COMPILE_IFELSE
	])
	# NOTSKIP
	AS_ECHO(["$code"])
])
# DAC_DLM_TEST_EID

# DAC_SHELL_FN()
# ------------------
# Defined shell functions
m4_defun([DAC_SHELL_FN],
[
# ------------------
# Import DAS shell functions
DAS_SHELL_FN

# Init global var dac_dlm_skip. Don't access me directly,
# but use DAC_DLM_SET_SKIP, DAC_DLM_SKIP, and DAC_DLM_NOTSKIP.
AS_VAR_SET([dac_dlm_skip], [0])

# To be removed
AS_VAR_SET([dac_dlm_id])

# ------------------
AS_FUNCTION_DESCRIBE([dac_fn_effo_code], [], [
Effo Code Generator
@public])
dac_fn_effo_code()
{
	DAC_MSG_NOTICE([---------------Effo Code Generator---------------------])
	DAC_MSG_NOTICE([Run Effo Code Generator...])

	# Cannot use $ac_top_srcdir, etc, since they won't be set after AC_OUTPUT.
	# So use $srcdir directly.
(#subshell local vars
	AS_VAR_SET([sdir], ["$srcdir"])
	AS_VAR_SET([cmd])
	AS_VAR_SET([code])

	DAS_NO_STR([$sdir], [DAC_MSG_ERROR([No srcdir '$srcdir'])])
	DAC_MSG_NOTICE([Generating code for SCSI ASC/ASCQ...])
	AS_VAR_SET([generator], ["$sdir/bin/effocode.sh"])
	AS_VAR_SET([config], ["$sdir/bin/effo-config"])
	DAC_MSG_CHECKING([Whether effo-config '$config' exists])
	AS_IF([test -f "$config"], [
		AC_MSG_RESULT(yes)
		chmod +x "$config"
		DAC_MSG_CHECKING([Whether Effo Code Generator '$generator' exists])
		AS_IF([test -f "$generator"], [
			AC_MSG_RESULT(yes)
			chmod +x "$generator"
			AS_VAR_SET([cmd], ["$generator $sdir $config -p scsi"])
			DAC_MSG_NOTICE([Executing '$cmd'...])
			$generator "$sdir" "$config" -p scsi
			AS_VAR_SET([code], [$?])
			DAC_MSG_NOTICE([Status of $generator: $code])
		],
		[
			AC_MSG_RESULT(no)
			DAC_MSG_WARN([Error: Effo Code Generator '$generator' doesn't exist?])
		])
		# AS_IF -f generator
	],
	[
		AC_MSG_RESULT(no)
		DAC_MSG_WARN([Error: effo-config '$config' doesn't exist?])
	])
	# AS_IF -f config
)
	DAC_MSG_NOTICE([---------------End of Effo Code Generator---------------------])
}
# dac_fn_effo_code

#-----------------------Dolem--------------------------

# ------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_val], [COND], [
Confirm compiler or architecture ID against name.
EID for Compiling/Architecture Environment ID.
COND: Expected conditions, "defined(__GNUC__)" or "VER > 1", etc.
Return check result, 1 for match or found.
@private
NOTE:
No parallel execution allowed because of global variable used in
this function.])
dac_fn_test_eid_val()
{
(#subshell local var
	AS_VAR_SET([cond], [$[]1])
	DAC_DLM_TEST_EID([$cond])
)
}
#dac_fn_test_eid_val

# ------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid], [EID, ENAME, COND], [
Test EID and check if need output a message.
EID for Compiling/Architecture Environment ID.
ENAME: Compiler/architecture name, e.g. "GNU C/++", "x64".
COND: Expected conditions, "defined(__GNUC__)" or "VER > 1", etc.
@private
])
dac_fn_test_eid()
{
	AS_VAR_SET([$[]1], DAS_EXEC([dac_fn_test_eid_val "$[]3"]))
	
	# Supressed "no" message. We only report "yes" status.
	AS_VAR_IF([$[]1], [1], [
		DAC_MSG_CHECKING([Whether compiler or architecture $[]2 meets $[]3])
		AC_MSG_RESULT(yes)
	])
}
# dac_fn_test_eid

# ------------------
AS_FUNCTION_DESCRIBE([dac_fn_get_eid], [IDLIST], [
Check which EID matches.
@private
])
dac_fn_get_eid()
{
(#subshell local var
	AS_VAR_SET([idlist], ["$[]1"])
	AS_VAR_SET([count], DAS_EXEC([das_fn_str_field_count "$idlist"]))
	AS_VAR_SET([match], [0])
	AS_VAR_SET([f])
	while :
	do
		AS_VAR_SET([f], DAS_EXEC([das_fn_str_get_field "$idlist" "$count"]))
		AC_COMPILE_IFELSE([
			AC_LANG_PROGRAM([], [
#if defined($f)
#else
	return abc;
#endif
			])
		],
		[AS_VAR_SET([match], [1])]
		)
		# AC_COMPILE_IFELSE

		AS_VAR_IF([match], [1], [
			AS_ECHO(["$f"])
			break
		],
		[
			AS_VAR_ARITH([count], [$count - 1])
		])
		AS_VAR_IF([count], [0], [break])
	done
	# while
)
}
# dac_fn_get_eid

# ------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_msvc], [], [Test MS VC/++])
dac_fn_test_eid_msvc()
{
	AS_VAR_SET([DLM_API])
	dac_fn_test_eid "DLM_COMP_MSVC" "MS VC/++" "defined(_MSC_VER)"
	DAC_DLM_CHK_SKIP([DLM_COMP_MSVC], [
		AS_VAR_SET([DLM_COMP_MSVC], [_MSC_VER])
		AS_VAR_SET([DLM_API], [__stdcall])
		dac_fn_test_eid "DLM_PRAGMA_ONCE" "MS VC/++" "_MSC_VER > 1000"
		AS_VAR_IF([DLM_PRAGMA_ONCE], [1], [
			AS_VAR_SET([DLM_PRAGMA_ONCE], ["#pragma once"])
		],
		[
			AS_VAR_SET([DLM_PRAGMA_ONCE], ["/* Not MSVC gt 1K */"])
		])
		# AS_VAR_SET
	])
	# CHK_SKIP
	AC_SUBST([DLM_PRAGMA_ONCE])
	AC_SUBST([DLM_API])
	AC_SUBST([DLM_COMP_MSVC])
}
# dac_fn_test_eid_msvc

# ------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_win], [], [Test Win32/64])
dac_fn_test_win()
{
	dac_fn_test_eid "DLM_COMP_WIN32" "Win32/64" "defined(WIN32) || defined(_WIN32) || defined(__WIN32)" 
	AS_VAR_IF([DLM_COMP_WIN32], [1], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "WIN32 _WIN32 __WIN32"])])
	],
	[
		dac_fn_test_eid "DLM_COMP_WIN64" "Win32/64" "defined(WIN64) || defined(_WIN64) || defined(__WIN64)"
		AS_VAR_IF([DLM_COMP_WIN64], [1], [
			AS_VAR_SET([DLM_COMP_WIN32], [1])
		])
		# AS_VAR_IF
	])
	# AS_VAR_IF
	AC_SUBST([DLM_COMP_WIN32])
	AC_SUBST([DLM_COMP_WIN64])
}
# dac_fn_test_win

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_gnu], [], [Test GNU C/++])
dac_fn_test_eid_gnu()
{
	dac_fn_test_eid "DLM_COMP_GNU" "GNU C/++" "defined(__GNUC__)"
	DAC_DLM_CHK_SKIP([DLM_COMP_GNU], [
		dac_fn_test_eid "DLM_COMP_GNU_MINOR" "GNU C/++" "defined(__GNUC_MINOR__)"
		AS_VAR_IF([DLM_COMP_GNU_MINOR], [1], [
			AS_VAR_SET([DLM_COMP_GNU_MINOR], [__GNUC_MINOR__])
			AS_VAR_SET([DLM_COMP_GNU], ["((__GNUC__ << 16) + __GNUC_MINOR__)"])
		],
		[
			AS_VAR_SET([DLM_COMP_GNU_MINOR], [])
			AS_VAR_SET([DLM_COMP_GNU], [1L])
		])
		# AS_VAR_IF
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_GNU])
	AC_SUBST([DLM_COMP_GNU_MINOR])
}
# dac_fn_test_eid_gnu

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_intel], [], [Test Intel C/++])
dac_fn_test_eid_intel()
{
	dac_fn_test_eid "DLM_COMP_INTEL" "Intel C/++" "defined(__INTEL_COMPILER) || defined(__ICC) || defined(__KCC)"
	DAC_DLM_CHK_SKIP([DLM_COMP_INTEL], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__INTEL_COMPILER __ICC __KCC"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_INTEL])
}
# dac_fn_test_eid_intel

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_dec], [], [Test Compaq/DEC/VAX C/++])
dac_fn_test_eid_dec()
{
	dac_fn_test_eid "DLM_COMP_DEC" "Compaq/DEC/VAX C/++" "defined(__DECC) || defined(VAXC) || defined(__VAXC)"
	DAC_DLM_CHK_SKIP([DLM_COMP_DEC], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__DECC VAXC __VAXC"])]) 
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_DEC])
}
# dac_fn_test_eid_dec

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_dm], [], [Test Digital Mars C/++])
dac_fn_test_eid_dm()
{
	dac_fn_test_eid "DLM_COMP_DM" "Digital Mars C/++" "defined(__DMC__) || defined(__SC__) || defined(__ZTC__)"
	DAC_DLM_CHK_SKIP([DLM_COMP_DM], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__DMC__ __SC__ __ZTC__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_DM])
}
# dac_fn_test_eid_dm

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_hp], [], [Test HP ANSI C/aC++])
dac_fn_test_eid_hp()
{
	dac_fn_test_eid "DLM_COMP_HP" "HP ANSI C/aC++" "defined(__HP_cc) || defined(__HP_aCC)"
	DAC_DLM_CHK_SKIP([DLM_COMP_HP], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__HP_cc __HP_aCC"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_HP])
}
# dac_fn_test_eid_hp

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_ibm], [], [Test IBM XL C/++])
dac_fn_test_eid_ibm()
{
	dac_fn_test_eid "DLM_COMP_IBM" "IBM XL C/++" "defined(__xlC__) || defined(__IBMC__) || defined(__IBMCPP__)"
	DAC_DLM_CHK_SKIP([DLM_COMP_IBM], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__xlC__ __IBMC__ __IBMCPP__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_IBM])
}
# dac_fn_test_eid_ibm

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_sgi], [], [SGI/MIPSpro])
dac_fn_test_eid_sgi()
{
	dac_fn_test_eid "DLM_COMP_SGI" "SGI/MIPSpro" "defined(sgi) || defined(__sgi)"
	DAC_DLM_CHK_SKIP([DLM_COMP_SGI], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "sgi __sgi"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_SGI])
}
# dac_fn_test_eid_sgi

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_mpw], [], [MPW C/++])
dac_fn_test_eid_mpw()
{
	dac_fn_test_eid "DLM_COMP_MPW" "MPW C/++" "defined(__MRC__) || defined(MPW_C) || defined(MPW_CPLUS)"
	DAC_DLM_CHK_SKIP([DLM_COMP_MPW], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__MRC__ MPW_C MPW_CPLUS"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_MPW])
}
# dac_fn_test_eid_mpw

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_sas], [], [SAS/C])
dac_fn_test_eid_sas()
{
	dac_fn_test_eid "DLM_COMP_SAS" "SAS/C" "defined(SASC) || defined(__SASC) || defined(__SASC__)"
	DAC_DLM_CHK_SKIP([DLM_COMP_SAS], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "SASC __SASC __SASC__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_SAS])
}
# dac_fn_test_eid_sas

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_sun], [], [Sun Workshop C/++])
dac_fn_test_eid_sun()
{
	dac_fn_test_eid "DLM_COMP_SUN" "Sun Workshop C/++" "defined(__SUNPRO_C) || defined(__SUNPRO_CC)"
	DAC_DLM_CHK_SKIP([DLM_COMP_SUN], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__SUNPRO_C __SUNPRO_CC"])])
	])
	# CHK_SKIP
        AC_SUBST([DLM_COMP_SUN])
}
# dac_fn_test_eid_sun

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_eid_borland], [], [Borland/Turbo C/++])
dac_fn_test_eid_borland()
{
	dac_fn_test_eid "DLM_COMP_BORLAND" "Borland/Turbo C/++" "defined(__TURBOC__) || defined(__BORLANDC__)"
	DAC_DLM_CHK_SKIP([DLM_COMP_BORLAND], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__TURBOC__ __BORLANDC__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_COMP_BORLAND])
}
# dac_fn_test_eid_borland

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_dlm_test_CE], [], [Test Dolem Compile-Environment])
dac_fn_dlm_test_CE()
{
	DAC_MSG_NOTICE([-------------Effo Compiler Detecting-----------------])
	DAC_MSG_NOTICE([Make sure AutoTools have set compiler probably already prior to my detecting])

	DAC_DLM_SET_SKIP([0])
	dac_fn_test_eid "DLM_IS_STDC" "C/++" "defined(__STDC__) && __STDC__"
	AC_SUBST([DLM_IS_STDC])

	# Don't use AC_PROG_CC_C99
	#AC_PROG_CC_C99
	dac_fn_test_eid "DLM_IS_C99" "C/++" "defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L"
	AC_SUBST([DLM_IS_C99])
	
	dac_fn_test_win

	dac_fn_test_eid_msvc

	dac_fn_test_eid_gnu
	dac_fn_test_eid_intel

	dac_fn_test_eid "DLM_COMP_MINGW" "MinGW C/++" "defined(__MINGW32__)"
	AC_SUBST([DLM_COMP_MINGW])
	DAC_DLM_CHK_SKIP([DLM_COMP_MINGW])

	dac_fn_test_eid "DLM_COMP_COMO" "Comeau C/++" "defined(__COMO__)"
	AC_SUBST([DLM_COMP_COMO])
	DAC_DLM_CHK_SKIP([DLM_COMP_COMO])

	dac_fn_test_eid_dec

	dac_fn_test_eid "DLM_COMP_CRAY" "Cray C/++" "defined(_CRAYC)"
	AC_SUBST([DLM_COMP_CRAY])
	DAC_DLM_CHK_SKIP([DLM_COMP_CRAY])

	dac_fn_test_eid "DLM_COMP_CYGWIN" "Cygwin C/++" "defined(__CYGWIN__)"
	AC_SUBST([DLM_COMP_CYGWIN])
	DAC_DLM_CHK_SKIP([DLM_COMP_CYGWIN])

	dac_fn_test_eid "DLM_COMP_DIAB" "DIAB C/++" "defined(__DCC__)"
	AC_SUBST([DLM_COMP_DIAB])
	DAC_DLM_CHK_SKIP([DLM_COMP_DIAB])

	dac_fn_test_eid_dm

	dac_fn_test_eid "DLM_COMP_EDG" "EDG C/++ Front-End" "defined(__EDG__)"
	AC_SUBST([DLM_COMP_EDG])
	DAC_DLM_CHK_SKIP([DLM_COMP_EDG])

	dac_fn_test_eid_hp
	dac_fn_test_eid_ibm

	dac_fn_test_eid "DLM_COMP_LCC" "compiler LCC" "defined(LCC)"
	AC_SUBST([DLM_COMP_LCC])
	DAC_DLM_CHK_SKIP([DLM_COMP_LCC])

	dac_fn_test_eid "DLM_COMP_HIGH" "MetaWare Hight C/++" "defined(__HIGHC__)"
	AC_SUBST([DLM_COMP_HIGH])
	DAC_DLM_CHK_SKIP([DLM_COMP_HIGH])

	dac_fn_test_eid_sgi
	dac_fn_test_eid_mpw

	dac_fn_test_eid "DLM_COMP_NORCROFT" "Norcroft C" "defined(__CC_NORCROFT)"
	AC_SUBST([DLM_COMP_NORCROFT])
	DAC_DLM_CHK_SKIP([DLM_COMP_NORCROFT])

	dac_fn_test_eid "DLM_COMP_POCC" "Pelles C" "defined(__POCC__)"
	AC_SUBST([DLM_COMP_POCC])
	DAC_DLM_CHK_SKIP([DLM_COMP_POCC])

	dac_fn_test_eid_sas

	dac_fn_test_eid "DLM_COMP_SCO" "Compiler SCO" "defined(_SCO_DS)"
	AC_SUBST([DLM_COMP_SCO])
	DAC_DLM_CHK_SKIP([DLM_COMP_SCO])

	dac_fn_test_eid_sun

	dac_fn_test_eid "DLM_COMP_TENDRA" "TenDRA C/++" "defined(__TenDRA__)"
	AC_SUBST([DLM_COMP_TENDRA])
	DAC_DLM_CHK_SKIP([DLM_COMP_TENDRA])

	dac_fn_test_eid "DLM_COMP_TINY" "Tiny C" "defined(__TINYC__)"
	AC_SUBST([DLM_COMP_TINY])
	DAC_DLM_CHK_SKIP([DLM_COMP_TINY])

	dac_fn_test_eid "DLM_COMP_USL" "USL C" "defined(__USLC__)"
	AC_SUBST([DLM_COMP_USL])
	DAC_DLM_CHK_SKIP([DLM_COMP_USL])

	dac_fn_test_eid "DLM_COMP_WATCOM" "Watcom C++" "defined(__WATCOMC__)"
	AC_SUBST([DLM_COMP_WATCOM])
	DAC_DLM_CHK_SKIP([DLM_COMP_WATCOM])

	dac_fn_test_eid "DLM_COMP_MWERKS" "MetroWerks CodeWarrior" "defined(__MWERKS__)"
	AC_SUBST([DLM_COMP_MWERKS])
	DAC_DLM_CHK_SKIP([DLM_COMP_MWERKS])

	dac_fn_test_eid_borland

	DAC_MSG_NOTICE([-------------End of Effo Compiler Detecting-----------------])
}
# dac_fn_dlm_test_CE

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_x32], [], [Test x86/x32])
dac_fn_test_arch_x32()
{
	dac_fn_test_eid "DLM_ARCH_X32" "x86/x32" "defined(__i386__) || defined(i386) || defined(__i386) || defined(__I86__) || defined(__X86__) || defined(_M_IX86) || defined(__THW_INTEL__)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_X32], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__i386__ i386 __i386 __I86__ __X86__ _M_IX86 __THW_INTEL__"])])
		AS_VAR_SET([DLM_ARCH_X86], [1])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_X32])
}
# dac_fn_test_arch_x32

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_x64], [], [Test x86/x64])
dac_fn_test_arch_x64()
{
	dac_fn_test_eid "DLM_ARCH_X64" "x86/x64" "defined(__x86_64__) || defined(__amd64__) || defined(__x86_64) || defined(__amd64) || defined(_M_X64)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_X64], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__x86_64__ __amd64__ __x86_64 __amd64 _M_X64"])])
		AS_VAR_SET([DLM_ARCH_X86], [1])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_X64])
}
# dac_fn_test_arch_x64

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_alpha], [], [Test alpha])
dac_fn_test_arch_alpha()
{
	dac_fn_test_eid "DLM_ARCH_ALPHA" "alpha" "defined(__alpha__) || defined(__alpha) || defined(_M_ALPHA)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_ALPHA], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__alpha__ __alpha _M_ALPHA"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_ALPHA])
}
# dac_fn_test_arch_alpha

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_arm], [], [Test ARM])
dac_fn_test_arch_arm()
{
	dac_fn_test_eid "DLM_ARCH_ARM" "arm/thumb" "defined(__arm__) || defined(__thumb__)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_ARM], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__arm__ __thumb__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_ARM])
}
# dac_fn_test_arch_arm

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_hppa], [], [Test HP/PA RISC])
dac_fn_test_arch_hppa()
{
	dac_fn_test_eid "DLM_ARCH_HPPA" "HP/PA RISC" "defined(__hppa__) || defined(__hppa)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_HPPA], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__hppa__ __hppa"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_HPPA])
}
# dac_fn_test_arch_hppa

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_ia64], [], [Test IA64])
dac_fn_test_arch_ia64()
{
	dac_fn_test_eid "DLM_ARCH_IA64" "IA64" "defined(__ia64__) || defined(_IA64) || defined(__IA64__) || defined(__ia64) || defined(_M_IA64)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_IA64], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__ia64__ _IA64 __IA64__ __ia64 _M_IA64"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_IA64])
}
# dac_fn_test_arch_ia64

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_m64k], [], [Test M68000])
dac_fn_test_arch_m68k()
{
	dac_fn_test_eid "DLM_ARCH_M68K" "M68000" "defined(__m68k__) || defined(M68000)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_M68K], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__m68k__ M68000"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_M68K])
}
# dac_fn_test_arch_m68k

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_mips], [], [Test MIPS])
dac_fn_test_arch_mips()
{
	dac_fn_test_eid "DLM_ARCH_MIPS" "MIPS" "defined(__mips__) || defined(mips) || defined(__mips) || defined(__MIPS__)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_MIPS], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__mips__ mips __mips __MIPS__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_MIPS])
}
# dac_fn_test_arch_mips

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_ppc], [], [Test PowerPC/PPC])
dac_fn_test_arch_ppc()
{
	dac_fn_test_eid "DLM_ARCH_PPC" "PowerPC/PPC" "defined(__ppc__) || defined(__powerpc) || defined(__powerpc__) || defined(__POWERPC__) || defeined(_M_PPC) || defined(_ARCH_PPC)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_PPC], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__ppc__ __powerpc __powerpc__ __POWERPC__ _M_PPC _ARCH_PPC"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_PPC])
}
# dac_fn_test_arch_ppc

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_rs6k], [], [Test RS/6000])
dac_fn_test_arch_rs6k()
{
	dac_fn_test_eid "DLM_ARCH_RS6K" "RS/6000" "defined(__THW_RS6000) || defined(_IBMR2) || defined(_POWER) || defined(_ARCH_PWR) || defined(_ARCH_PWR2)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_RS6K], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__THW_RS6000 _IBMR2 _POWER _ARCH_PWR _ARCH_PWR2"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_RS6K])
}
# dac_fn_test_arch_rs6k

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_sparc], [], [Test SPARC])
dac_fn_test_arch_sparc()
{
	dac_fn_test_eid "DLM_ARCH_SPARC" "SPARC" "defined(__sparc__) || defined(__sparc)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_SPARC], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__sparc__ __sparc"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_SPARC])
}
# dac_fn_test_arch_sparc

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_s370], [], [Test System/370])
dac_fn_test_arch_s370()
{
	dac_fn_test_eid "DLM_ARCH_S370" "System/370" "defined(__370__) || defined(__THW_370__)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_S370], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__370__ __THW_370__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_S370])
}
# dac_fn_test_arch_s370

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_test_arch_s390], [], [Test System/390])
dac_fn_test_arch_s390()
{
	dac_fn_test_eid "DLM_ARCH_S390" "System/390" "defined(__s390__) || defined(__s390x__)"
	DAC_DLM_CHK_SKIP([DLM_ARCH_S390], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__s390__ __s390x__"])])
	])
	# CHK_SKIP
	AC_SUBST([DLM_ARCH_S390])
}
# dac_fn_test_arch_s390

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_dlm_test_arch], [], [Test CPU/Architecture Environment])
dac_fn_dlm_test_arch()
{
	DAC_MSG_NOTICE([----------Effo CPU Architecture Detecting---------------])
	DAC_DLM_SET_SKIP([0])
	AS_VAR_SET([DLM_ARCH_X86], [0])
	dac_fn_test_arch_x32
	dac_fn_test_arch_x64
	AC_SUBST([DLM_ARCH_X86])
	dac_fn_test_arch_alpha
	dac_fn_test_arch_arm
	dac_fn_test_arch_hppa
	dac_fn_test_arch_ia64
	dac_fn_test_arch_m68k
	dac_fn_test_arch_mips
	dac_fn_test_arch_ppc
	dac_fn_test_arch_rs6k
	dac_fn_test_arch_sparc

	dac_fn_test_eid "DLM_ARCH_SH" "SuperH" "defined(__sh__)"
	AC_SUBST([DLM_ARCH_SH])
	DAC_DLM_CHK_SKIP([DLM_ARCH_SH])

	dac_fn_test_arch_s370
	dac_fn_test_arch_s390

	DAC_MSG_NOTICE([----------End of Effo CPU Architecture Detecting---------------])
}
# dac_fn_dlm_test_arch

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_dlm_lp], [], [Test I/LP32/64])
dac_fn_dlm_lp()
{
	DAC_DLM_SET_SKIP([0])

	dac_fn_test_eid "DLM_ILP32" "Model ILP32, LP64 or LLP64" "defined(__ILP32__) || defined(_ILP32) || defined(ILP32) || defined(__ilp32__)"
	AS_VAR_IF([DLM_ILP32], [1], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__ILP32__ _ILP32 ILP32 __ilp32__"])])
	])
	dac_fn_test_eid "DLM_LP32" "Model ILP32, LP64 or LLP64" "defined(__LP32__) || defined(_LP32) || defined(LP32) || defined(__lp32__)"
	AS_VAR_IF([DLM_LP32], [1], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__LP32__ _LP32 LP32 __lp32__"])])
	])
	dac_fn_test_eid "DLM_LP64" "Model ILP32, LP64 or LLP64" "defined(__LP64__) || defined(_LP64) || defined(LP64) || defined(__lp64__)"
	AS_VAR_IF([DLM_LP64], [1], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__LP64__ _LP64 LP64 __lp64__"])])
	])
	dac_fn_test_eid "DLM_LLP64" "Model ILP32, LP64 or LLP64" "defined(__LLP64__) || defined(_LLP64) || defined(LLP64) || defined(__llp64__)"
	AS_VAR_IF([DLM_LLP64], [1], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__LLP64__ _LLP64 LLP64 __llp64__"])])
	])
	dac_fn_test_eid "DLM_ILP64" "Model ILP32, LP64 or LLP64" "defined(__ILP64__) || defined(_ILP64) || defined(ILP64) || defined(__ilp64__)"
	AS_VAR_IF([DLM_ILP64], [1], [
		DAC_DLM_SET_ID([DAS_EXEC([dac_fn_get_eid "__ILP64__ _ILP64 ILP64 __ilp64__"])])
	])
	AC_SUBST([DLM_ILP32])
	AC_SUBST([DLM_LP32])
	AC_SUBST([DLM_LP64])
	AC_SUBST([DLM_LLP64])
	AC_SUBST([DLM_ILP64])
}
# dac_fn_dlm_lp

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_dlm_bits], [], [Test Dolem BITS])
dac_fn_dlm_bits()
{
	DAC_DLM_SET_SKIP([0])
	
	dac_fn_test_eid "DLM_BITS" "Size of System Machine WORD" "(defined(__SIZEOF_POINTER__) && 8 == __SIZEOF_POINTER__) || defined(__LP64__) || defined(_LP64) || defined(CONFIG_X86_64)"
	AS_IF([test x"$DLM_BITS" = x"1"], [
		AS_VAR_SET([DLM_BITS], [64])
	],
	[test x"$DLM_ARCH_X64" = x"1" -o x"$DLM_ARCH_ALPHA" = x"1" -o x"$DLM_ARCH_IA64" = x"1" -o x"$DLM_COMP_WIN64" = x"1"], [
		AS_VAR_SET([DLM_BITS], [64])
	],
	[
		dac_fn_test_eid "DLM_BITS" "Size of System Machine WORD" "(defined(__SIZEOF_POINTER__) && 4 == __SIZEOF_POINTER__)"
		AS_IF([test x"$DLM_BITS" = x"1"], [
			AS_VAR_SET([DLM_BITS], [32])
		],
		[test x"$DLM_ARCH_X32" = x"1" -o x"$DLM_COMP_WIN32" = x"1"], [
			AS_VAR_SET([DLM_BITS], [32])
		],
		[
			# FIXME: Anyway, anything else, set bits to 32
			AS_VAR_SET([DLM_BITS], [32])
		])
		# AS_IF
	])
	# AS_IF
	AC_SUBST([DLM_BITS])
}
# dac_fn_dlm_bits

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_dlm_bool], [], [Test Dolem bool type])
dac_fn_dlm_bool()
{
	AS_VAR_SET([DLM_BOOL_TYPE], ["/* CPK bool/true/false, Checked stdbool.h is available. */"])
	AS_VAR_SET([DLM_BOOL_TRUE_FALSE], ["#include <stdbool.h>"])
	# Make sure you have AC_HEADER_STDBOOL in configure.ac
	AS_VAR_IF([ac_cv_header_stdbool_h], [no], [
		AS_VAR_IF([ac_cv_type__Bool], [yes], [
			AS_VAR_SET([DLM_BOOL_TYPE], ["typedef _Bool		bool;"])
		],
		[
			AS_VAR_SET([DLM_BOOL_TYPE], ["typedef signed char	bool;"])
		])
		# AS_VAR_IF
		AS_VAR_SET([DLM_BOOL_TRUE_FALSE], ["enum ind_bool { false = 0, true = 1 };"])
	])
	# AS_VAR_IF
	AC_SUBST([DLM_BOOL_TYPE])
	AC_SUBST([DLM_BOOL_TRUE_FALSE])
}
# dac_fn_dlm_bool

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_dlm_intptr_t], [], [Test Dolem u/intptr_t type])
dac_fn_dlm_intptr_t()
{
	# only be useful there's no stdint.h
	# Make sure you have AC_CHECK_HEADERS for stdint.h in configure.ac
	AC_COMPILE_IFELSE([
		AC_LANG_PROGRAM([
$ac_includes_default
		],
		[
intptr_t i; i = -1; i = i;
		])
	],
	[AS_VAR_SET([DLM_NO_INTPTR_T], [0])],
	[AS_VAR_SET([DLM_NO_INTPTR_T], [1])]
	)
	AC_COMPILE_IFELSE([
		AC_LANG_PROGRAM([
$ac_includes_default
		],
		[
uintptr_t i; i = -1; i = i;
		])
	],
	[AS_VAR_SET([DLM_NO_UINTPTR_T], [0])],
	[AS_VAR_SET([DLM_NO_UINTPTR_T], [1])]
	)
	AC_SUBST([DLM_NO_INTPTR_T])
	AC_SUBST([DLM_NO_UINTPTR_T])
}
# dac_fn_dlm_intptr_t 

# -------------------End of Dolem----------------------

# -------------------
AS_FUNCTION_DESCRIBE([dac_fn_import_effo_core], [], [Import Effo Core])
dac_fn_import_effo_core()
{
	DAC_MSG_NOTICE([------------------Import Effo Core-----------------------])
	DAC_MSG_NOTICE([Use effo-config to detect Effo Core flags...])
	AS_VAR_SET([EFFOCONFIG], [effo-config])
	AS_VAR_SET([EFFOCORE_CFLAGS], DAS_EXEC([$EFFOCONFIG -p core --cflags]))
	AS_VAR_SET([EFFOCORE_LDFLAGS], DAS_EXEC([$EFFOCONFIG -p core --ldflags]))
	AS_VAR_APPEND([AM_CPPFLAGS], [" $EFFOCORE_CFLAGS"])
	AS_VAR_APPEND([AM_LDFLAGS], [" $EFFOCORE_LDFLAGS"])
	DAC_MSG_NOTICE([--------------End of Import Effo Core---------------------])
}
# dac_fn_import_effo_core

# ------------------
])
# DAC_SHELL_FN

# DOLEM()
# ------------
# Configure Dolem.
AC_DEFUN([DOLEM],
[
	dac_fn_dlm_test_CE
	dac_fn_dlm_test_arch
	dac_fn_dlm_lp
	dac_fn_dlm_bits
	dac_fn_dlm_bool
	dac_fn_dlm_intptr_t
])
# DOLEM

