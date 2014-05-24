m4_include([dmeta/das.m4])

AS_INIT

## ------- ##
## as_me.  ##
## ------- ##

AS_ME_PREPARE
echo "PATH_SEPARATOR: '$PATH_SEPARATOR'"
echo "as_dir: '$as_dir'"
echo "as_me: '$as_me'"
echo "as_myself: '$as_myself'"
test "$as_me" = me || AS_ECHO([["incorrect value of \$as_me: $as_me"]])

AS_EXIT

