m4_include([dmeta/das.m4])

AS_INIT

## -------------- ##
## AS_HELP_STRING ##
## -------------- ##

echo "AS_HELP_STRING([--an-option],[some text])"
echo "AS_HELP_STRING([--another-much-longer-option],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--fooT=barT], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@123456789], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@1234567890], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@12345678901], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@123456789012], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@1234567890123], [foo bar])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@123456789],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@1234567890],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@12345678901],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@123456789012],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@1234567890123],
[some other text which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@],
[some other @<][:@ex@:][>@ which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@123456789],
[some other @<][:@ex@:][>@ which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@1234567890],
[some other @<][:@ex@:][>@ which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@12345678901],
[some other @<][:@ex@:][>@ which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@123456789012],
[some other @<][:@ex@:][>@ which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([--foo@<][:@=bar@:][>@1234567890123],
[some other @<][:@ex@:][>@ which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([[--foo[=bar]]],
[some other t[]t which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([[--foo[=bar]123456789]],
[some other t[]t which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([[--foo[=bar]1234567890]],
[some other t[]t which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([[--foo[=bar]12345678901]],
[some other t[]t which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([[--foo[=bar]123456789012]],
[some other t[]t which should wrap at our default of 80 characters.])"
echo "AS_HELP_STRING([[--foo[=bar]1234567890123]],
[some other t[]t which should wrap at our default of 80 characters.])"
m4_define([mac], [MACRO])dnl
echo "AS_HELP_STRING([--mac], [mac])"
echo "AS_HELP_STRING([--o1, --o2], [two
options,	one  description])"
echo "AS_HELP_STRING([[[--o3, --o4]]], [comma inside literal quoting])"
echo "AS_HELP_STRING([--tune1], [check out the tuned formatting],
[            ])"
echo "AS_HELP_STRING([--tune2], [check out the tuned formatting],
[12])"
echo "AS_HELP_STRING([--tune3], [check out the tuned formatting],
[], [40])"
echo "AS_HELP_STRING([--tune4], [check out the tuned formatting],
[12], [40])"

DAS_DATA([output.log],
[[
  --an-option             some text
  --another-much-longer-option
                          some other text which should wrap at our default of
                          80 characters.
  --fooT=barT             foo bar
  --foo[=bar]             foo bar
  --foo[=bar]123456789    foo bar
  --foo[=bar]1234567890   foo bar
  --foo[=bar]12345678901  foo bar
  --foo[=bar]123456789012 foo bar
  --foo[=bar]1234567890123
                          foo bar
  --foo[=bar]             some other text which should wrap at our default of
                          80 characters.
  --foo[=bar]123456789    some other text which should wrap at our default of
                          80 characters.
  --foo[=bar]1234567890   some other text which should wrap at our default of
                          80 characters.
  --foo[=bar]12345678901  some other text which should wrap at our default of
                          80 characters.
  --foo[=bar]123456789012 some other text which should wrap at our default of
                          80 characters.
  --foo[=bar]1234567890123
                          some other text which should wrap at our default of
                          80 characters.
  --foo[=bar]             some other [ex] which should wrap at our default of
                          80 characters.
  --foo[=bar]123456789    some other [ex] which should wrap at our default of
                          80 characters.
  --foo[=bar]1234567890   some other [ex] which should wrap at our default of
                          80 characters.
  --foo[=bar]12345678901  some other [ex] which should wrap at our default of
                          80 characters.
  --foo[=bar]123456789012 some other [ex] which should wrap at our default of
                          80 characters.
  --foo[=bar]1234567890123
                          some other [ex] which should wrap at our default of
                          80 characters.
  --foo[=bar]             some other t[]t which should wrap at our default of
                          80 characters.
  --foo[=bar]123456789    some other t[]t which should wrap at our default of
                          80 characters.
  --foo[=bar]1234567890   some other t[]t which should wrap at our default of
                          80 characters.
  --foo[=bar]12345678901  some other t[]t which should wrap at our default of
                          80 characters.
  --foo[=bar]123456789012 some other t[]t which should wrap at our default of
                          80 characters.
  --foo[=bar]1234567890123
                          some other t[]t which should wrap at our default of
                          80 characters.
  --MACRO                 mac
  --o1, --o2              two options, one description
  [--o3, --o4]            comma inside literal quoting
  --tune1   check out the tuned formatting
  --tune2   check out the tuned formatting
  --tune3                 check out the
                          tuned
                          formatting
  --tune4   check out the tuned
            formatting
]])dnl DAS_DATA

rm -f output.log

AS_EXIT

