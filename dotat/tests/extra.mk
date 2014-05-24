TESTSUITE_AT +=       		\
	at/testgnu.at		\
	at/m4sugar/warn.at	\
	at/m4sugar/subst.at	\
	at/m4sugar/dumpdef.at	\
	at/m4sugar/stack_foreach.at	\
	at/m4sugar/defn.at	\
	at/m4sugar/m4sugar.at	\
	at/m4sh/box.at		\
	at/m4sh/help_str.at	\
	at/m4sh/require.at	\
	at/m4sh/set_catfile.at	\
	at/m4sh/m4sh.at		\
	at/m4sh/me.at		\
	at/m4sh/dir_basename.at	\
	at/m4sh/config_shell.at	\
	at/m4sh/warn_error.at	\
	at/m4sh/ver_comp.at	\
	at/m4sh/for.at		\
	at/m4sh/var.at		\
	at/m4sh/echo.at		\
	at/m4sh/shell_fn.at	\
	at/m4sh/lineno.at

EXTRA_SCRIPTS += 			\
	at/m4sugar/stack_foreach 	\
	at/m4sugar/defn		\
	at/m4sugar/dumpdef		\
	at/m4sugar/warn		\
	at/m4sugar/subst		\
	at/m4sh/config_shell		\
	at/m4sh/warn_error		\
	at/m4sh/lineno			\
	at/m4sh/box			\
	at/m4sh/dir_basename		\
	at/m4sh/set_catfile		\
	at/m4sh/echo			\
	at/m4sh/ver_comp		\
	at/m4sh/me			\
	at/m4sh/shell_fn		\
	at/m4sh/require		\
	at/m4sh/help_str		\
	at/m4sh/for			\
	at/m4sh/var			\
	at/m4sh/path			\
	at/m4sh/logfd

EXTRA_DIST += 			\
	at/m4sugar/dumpdef.as	\
	at/m4sugar/subst.as	\
	at/m4sugar/stack_foreach.as	\
	at/m4sugar/defn.as	\
	at/m4sugar/warn.as	\
	at/m4sh/logfd.as	\
	at/m4sh/echo.as		\
	at/m4sh/path.as		\
	at/m4sh/config_shell.as	\
	at/m4sh/help_str.as	\
	at/m4sh/lineno.as	\
	at/m4sh/box.as		\
	at/m4sh/var.as		\
	at/m4sh/ver_comp.as	\
	at/m4sh/warn_error.as	\
	at/m4sh/set_catfile.as	\
	at/m4sh/me.as		\
	at/m4sh/dir_basename.as	\
	at/m4sh/for.as	\
	at/m4sh/shell_fn.as	\
	at/m4sh/require.as

BUILT_SOURCES += at/m4sh/placeholder

at/m4sh/placeholder: Makefile
	if ! test -d at; then \
		mkdir at; \
		mkdir at/m4sugar; \
		mkdir at/m4sh;\
	fi;
	if ! test -f $@; then \
		touch $@; \
	fi;

