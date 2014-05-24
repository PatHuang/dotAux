m4_include([dmeta/das.m4])

AS_INIT

## ------------------- ##
## AS_WARN, AS_ERROR.  ##
## ------------------- ##

# try to set die as switch on/off
die=

# without logging
AS_WARN([*watch out*])dnl

if test x"$die" != x; then
  AS_ERROR([you're dead])dnl

  AS_ERROR([really])dnl

fi
echo got here

# with logging
m4_define([gone], [AS_ERROR([really])])
m4_define([AS_MESSAGE_LOG_FD], [5])
exec AS_MESSAGE_LOG_FD>log.txt
AS_WARN([*watch out*])dnl

if test x"$die" != x; then
  AS_ERROR([you're dead])dnl

  AS_ERROR([really])dnl

fi
echo got here
exec AS_MESSAGE_LOG_FD>&-

rm -f log.txt

AS_EXIT

