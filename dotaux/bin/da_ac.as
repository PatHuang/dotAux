AS_INIT

AS_VAR_IF([#], [0], [
	AS_ERROR([Usage: $0 <file>])
], [
	AS_VAR_SET([EXT], [.ac]) 
	AS_VAR_IF([#], [1], [
		AS_MESSAGE([Process $1$EXT, output to $1...])
		autom4te --language=autoconf $1$EXT -o $1
	], [
		AS_MESSAGE([Process $1$EXT, output to $2...])
		autom4te --language=autoconf $1$EXT -o $2
	])
])

AC_SUBST([FOOBAR], [foobar])

AS_EXIT

