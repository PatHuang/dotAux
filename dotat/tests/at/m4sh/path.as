
AS_INIT

AS_MESSAGE([------------Walk PATH--------------])
# as_dir as built-in var
_AS_PATH_WALK([$PATH], [AS_ECHO(["PATH: $as_dir"])])

AS_MESSAGE([------------Walk /bin:/usr/bin--------------])
_AS_PATH_WALK([/bin$PATH_SEPARATOR/usr/bin$PATH_SEPARATOR$PATH],
[case $as_dir in @%:@(
 /*)
     my_shell=$as_dir/sh
	AS_IF([test -f $my_shell], [echo "$my_shell"], [echo "$my_shell doesn't exist"])
	;;
esac]
)

as_myself=
case $[0] in @%:@((
  *[[\\/]]* ) as_myself=$[0] ;;
  *) _AS_PATH_WALK([],
		   [test -r "$as_dir/$[0]" && as_myself=$as_dir/$[0] && break])
     ;;
esac
# We did not find ourselves, most probably we were run as `sh COMMAND'
# in which case we are not to be found in the path.
if test "x$as_myself" = x; then
  as_myself=$[0]
fi
if test ! -f "$as_myself"; then
  AS_ECHO(["$as_myself: error: cannot find myself; rerun with an absolute file name"]) >&2
fi

echo as_myself $as_myself

AS_EXIT

