
# make sure we put metadata on VPATH too
BUILT_SOURCES = dmeta/das.m4

COPY_DEPS = $(top_srcdir)/share/dotaux/dmeta/das.m4 $(top_srcdir)/share/dotaux/dmeta/dac.m4 $(top_srcdir)/share/dotaux/dmeta/dat.m4

dmeta/das.m4: Makefile
	@if ! test -d dmeta; then \
		mkdir dmeta; \
		mkdir ext; \
	fi; 
	@if ! test -f $@; then \
		cp -f $(top_srcdir)/share/dotaux/dmeta/* dmeta/; \
		cp -f $(top_srcdir)/share/dotaux/ext/* ext/; \
	fi;

