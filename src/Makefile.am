## Process this file with automake to produce Makefile.in

INCLUDES = -I$(top_srcdir)/include -I$(top_builddir)/include

lib_LTLIBRARIES = libogg.la

libogg_la_SOURCES = framing.c bitwise.c
libogg_la_LDFLAGS = -no-undefined -version-info @LIB_CURRENT@:@LIB_REVISION@:@LIB_AGE@

# build and run the self tests on 'make check'

noinst_PROGRAMS = test_bitwise test_framing

test_bitwise_SOURCES = bitwise.c
test_bitwise_CFLAGS = -D_V_SELFTEST

test_framing_SOURCES = framing.c
test_framing_CFLAGS = -D_V_SELFTEST

check: $(noinst_PROGRAMS)
	./test_bitwise$(EXEEXT)
	./test_framing$(EXEEXT)

debug:
	$(MAKE) all CFLAGS="@DEBUG@"

profile:
	$(MAKE) all CFLAGS="@PROFILE@"


Android.mk: Makefile.am
	androgenizer -:PROJECT libogg -:SHARED libogg \
	 -:TAGS user eng debug \
         -:REL_TOP $(top_srcdir) -:ABS_TOP $(abs_top_srcdir) \
	 -:SOURCES $(libogg_la_SOURCES) \
	 -:CFLAGS $(DEFS) $(INCLUDES) $(libogg_la_CFLAGS) \
	 -:LDFLAGS $(libogg_la_LDFLAGS) \
	 -:HEADERS $(top_srcdir)/include/ogg/ogg.h \
	 	$(top_srcdir)/include/ogg/os_types.h \
	 	$(top_srcdir)/include/ogg/config_types.h \
	 -:HEADER_TARGET ogg \
	 -:PASSTHROUGH LOCAL_ARM_MODE:=arm \
	> $@
