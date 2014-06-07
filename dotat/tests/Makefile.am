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


#DA_LIBDIR=$(abs_top_srcdir)/share
TEST_SRCDIR=$(abs_top_srcdir)/tests
# where to run the testing
TESTDIR=$(top_builddir)/tests
DAUXDIR=$(abs_top_srcdir)/@DAUX@

ACLOCAL_AMFLAGS = -I $(DAUXDIR)

# package.m4
$(TESTDIR)/package.m4: $(abs_top_srcdir)/configure
	$(AM_V_GEN)rm -f $@ $@.tmp
	$(AM_V_at){ \
	  echo '# Signature of the current package.'; \
	  echo 'm4_define([AT_PACKAGE_NAME],      [$(PACKAGE_NAME)])'; \
	  echo 'm4_define([AT_PACKAGE_TARNAME],   [$(PACKAGE_TARNAME)])'; \
	  echo 'm4_define([AT_PACKAGE_VERSION],   [$(PACKAGE_VERSION)])'; \
	  echo 'm4_define([AT_PACKAGE_STRING],    [$(PACKAGE_STRING)])'; \
	  echo 'm4_define([AT_PACKAGE_BUGREPORT], [$(PACKAGE_BUGREPORT)])'; \
	} >$@.tmp
	$(AM_V_at)mv $@.tmp $@


# Generate the test suite. 

# Run the tests with a proper shell detected at configure time.
LOG_COMPILER = $(SHELL)

TEST_EXTENSIONS = .sh .tap
SH_LOG_COMPILER = $(LOG_COMPILER)
TAP_LOG_COMPILER = $(LOG_COMPILER)

TAP_LOG_DRIVER = AM_TAP_AWK='$(AWK)' $(SHELL) $(DAUXDIR)/tap-driver.sh
AM_TAP_LOG_DRIVER_FLAGS = --merge

# We want warning messages and explanations for skipped tests to go to
# the console if possible, so set up 'stderr_fileno_' properly.
AM_TESTS_FD_REDIRECT = 9>&2
AM_TESTS_ENVIRONMENT = stderr_fileno_=9; export stderr_fileno_;

TESTSUITE_AT =            	\
	testsuite.at		\
	$(TESTDIR)/package.m4

EXTRA_SCRIPTS = 
BUILT_SOURCES =

EXTRA_DIST = local.at atlocal.in 

include ./extra.mk

EXTRA_DIST += $(TESTSUITE_AT)

TESTSUITE = $(TESTDIR)/testsuite

CLEANFILES = $(BUILT_SOURCES)

DISTCLEANFILES = $(TESTSUITE) $(TESTDIR)/package.m4

AUTOTEST = autom4te --language=autotest --force -Wall
AUTOTESTFLAGS = -I $(TEST_SRCDIR) -I $(TESTDIR) $(ACLOCAL_AMFLAGS)

$(TESTSUITE): $(TESTSUITE_AT)
	$(AM_V_GEN) $(AUTOTEST) $(AUTOTESTFLAGS) $(TEST_SRCDIR)/testsuite.at -o $@.tmp
	$(AM_V_at)mv $@.tmp $@

# Run the test suite.

# Move into tests/ so that testsuite.dir etc. be created there.
RUN_TESTSUITE = $(TESTSUITE) -C $(TESTDIR) $(TESTSUITEFLAGS)
check_SCRIPTS = $(TESTDIR)/atconfig $(TESTDIR)/atlocal

DISTCLEANFILES += $(check_SCRIPTS)

RUN_TESTSUITE_deps = all $(TESTSUITE) $(check_SCRIPTS)

clean-local: clean-local-tests
clean-local-tests:
	test ! -f $(TESTSUITE) || $(TESTSUITE) -C $(TESTDIR) --clean
	test -z "$(TESTSUITE)" || rm -f $(TESTSUITE)
	test -z "$(EXTRA_SCRIPTS)" || rm -f $(EXTRA_SCRIPTS)

check-local: $(RUN_TESTSUITE_deps) $(EXTRA_SCRIPTS)
	$(RUN_TESTSUITE)

# Run the test suite on the *installed* tree.
installcheck-local: $(RUN_TESTSUITE_deps)
	$(RUN_TESTSUITE) AUTOTEST_PATH='$(bindir)'

GENSCRIPT = autom4te --language=m4sh --force -Wall
GENSCRIPT_FLAGS = $(ACLOCAL_AMFLAGS)

$(EXTRA_SCRIPTS):
	$(AM_V_GEN) $(GENSCRIPT) $(GENSCRIPT_FLAGS) $(TEST_SRCDIR)/$@.as -o $@

