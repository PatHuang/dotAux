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

DAUXDIR=$(abs_top_srcdir)/@DAUX@

ACLOCAL_AMFLAGS = -I $(DAUXDIR)

bin_SCRIPTS = da_as
EXTRA_DIST = da_as.as
bin_SCRIPTS += da_ac
EXTRA_DIST += da_ac.as
bin_SCRIPTS += da_at
EXTRA_DIST += da_at.as
bin_SCRIPTS += dotaux
EXTRA_DIST += dotaux.as
bin_SCRIPTS += dapkg
EXTRA_DIST += dapkg.as
bin_SCRIPTS += damk
EXTRA_DIST += damk.as
bin_SCRIPTS += daln
EXTRA_DIST += daln.as
bin_SCRIPTS += dadlm
EXTRA_DIST += dadlm.as


CLEANFILES = $(bin_SCRIPTS)

GENSCRIPT = autom4te --language=m4sh --force -Wall
GENSCRIPT_FLAGS = -I $(abs_top_srcdir)/bin $(ACLOCAL_AMFLAGS)

$(bin_SCRIPTS): $(EXTRA_DIST)
	$(AM_V_GEN) $(GENSCRIPT) $(GENSCRIPT_FLAGS) $@.as -o $@

