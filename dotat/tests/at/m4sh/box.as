m4_include([dmeta/das.m4])

AS_INIT

## -------- ##
## AS_BOX.  ##
## -------- ##

# Output a framed one-line message.

echo
AS_BOX([Send a simple message, to foobar@example.com])
AS_BOX([Send a simple message, to foobar@example.com], [$])
m4_define([msg], [$complex])
complex='Not quite as simple |$[1]'
AS_BOX([msg])
AS_BOX([msg], [,])

# output
## -------------------------------------------- ##
## Send a simple message, to foobar@example.com ##
## -------------------------------------------- ##
## $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ##
## Send a simple message, to foobar@example.com ##
## $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ##
## ----------------------- ##
## Not quite as simple |$1 ##
## ----------------------- ##
## ,,,,,,,,,,,,,,,,,,,,,,, ##
## Not quite as simple |$1 ##
## ,,,,,,,,,,,,,,,,,,,,,,, ##

AS_EXIT

