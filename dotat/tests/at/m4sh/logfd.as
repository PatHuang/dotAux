AS_INIT

dnl Second run, with logging from parent and child, tests fd handling

child=${1-child}
m4_define([AS_MESSAGE_LOG_FD], [5])
exec AS_MESSAGE_LOG_FD>log
AS_INIT_GENERATED([$child], [echo hello1 from $child]) || AS_EXIT([1])

cat >>$child <<\EOF
m4_pushdef([AS_MESSAGE_LOG_FD])
AS_MESSAGE([hello2 from ${child}child])
m4_popdef([AS_MESSAGE_LOG_FD])
exec AS_MESSAGE_LOG_FD>>log
AS_MESSAGE([hello3 from child])
EOF

AS_MESSAGE([hello from parent])
dnl close log in parent before spawning child, for mingw
exec AS_MESSAGE_LOG_FD>&-
./$child

rm -f log
rm -f $child

m4_define([AS_ORIGINAL_STDIN_FD], [5])
m4_define([AS_MESSAGE_LOG_FD], [6])
m4_define([AS_MESSAGE_FD], [7])
exec AS_ORIGINAL_STDIN_FD<&0 </dev/null AS_MESSAGE_LOG_FD>log
if test $[#] -gt 0; then
  exec AS_MESSAGE_FD>/dev/null
else
  exec AS_MESSAGE_FD>&1
fi
AS_LINENO_PUSH([100])
cat # tests that stdin is neutralized
AS_MESSAGE([hello world])
cat <&AS_ORIGINAL_STDIN_FD

rm -f log

AS_EXIT

