BUILT_SOURCES = $(abs_top_srcdir)/dotaux/dmeta/das.m4

COPY_DEPS = $(abs_top_srcdir)/share/dotaux/dmeta/das.m4 $(abs_top_srcdir)/share/dotaux/dmeta/dac.m4 $(abs_top_srcdir)/share/dotaux/dmeta/dat.m4

$(abs_top_srcdir)/dotaux/dmeta/das.m4: Makefile $(COPY_DEPS)
	@if ! test -d $(abs_top_srcdir)/dotaux; then \
		$(MKDIR_P) $(abs_top_srcdir)/dotaux/dmeta;\
	fi; 
	cp -f $(abs_top_srcdir)/share/dotaux/ext/* $(abs_top_srcdir)/dotaux/; 
	chmod a+x $(abs_top_srcdir)/dotaux/tap-driver.sh;
	cp -f $(abs_top_srcdir)/share/dotaux/dmeta/* $(abs_top_srcdir)/dotaux/dmeta; 

