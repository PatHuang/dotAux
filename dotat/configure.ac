# Process this file with autoconf to produce a configure script.
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

AC_PREREQ([2.60])
AC_INIT([dotAT],[0.1.0.06],[staff.effo@gmail.com])
AC_SUBST([PACKAGE_COPYRIGHT_YEAR], [2009-2014])

AC_CONFIG_SRCDIR([tests/Makefile.am])
# AC_CONFIG_AUX_DIR must be called before AM_INIT_AUTOMAKE, all shell help scripts go to aux dir.
AC_CONFIG_AUX_DIR([dotaux])
# autoreconf won't invoke automake if no AM_INIT_AUTOMAKE specified
# autoreconf --install --force -Wall -v
# autoreconf -ifv -Wall
AM_INIT_AUTOMAKE([silent-rules dist-bzip2 -Wall -Werror])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_CONFIG_MACRO_DIR([dotaux])

# dotAux - a replacement for build-aux
m4_define([DAUX], [dotaux])
#AC_REQUIRE_AUX_FILE([tap-driver.sh])

# Checks for programs.
#skip detection of Fortran
AC_PROG_AWK
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_MAKE_SET
# not yet in my autotools AC_PROG_MAKE_CASE_SENSITIVE
# not yet in my autotools AC_PROG_GNU_M4
## ------------ ##
## Grep & sed.  ##
## ------------ ##
AC_PROG_GREP
AC_PROG_SED

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AS_VAR_SET([dac_myaux], m4_defn([DAUX]))
m4_undefine([DAUX])
AC_SUBST([DAUX], [$dac_myaux])

AC_CONFIG_FILES([Makefile])

# Initialize the test suite.
AC_CONFIG_TESTDIR(tests)
AC_CONFIG_FILES([tests/atlocal tests/Makefile])

AC_OUTPUT

