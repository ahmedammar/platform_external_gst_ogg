# This file is the top android makefile for all sub-modules.

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LIBOGG_TOP := $(LOCAL_PATH)

LIBOGG_BUILT_SOURCES := src/Android.mk
LIBOGG_BUILT_SOURCES := $(patsubst %, $(abspath $(LIBOGG_TOP))/%, $(LIBOGG_BUILT_SOURCES))

ifeq ($(NDK_BUILD),true)
LIB := $(SYSROOT)/usr/lib
else
LIB := $(TARGET_OUT_SHARED_LIBRARIES)
endif

.PHONY: libogg-configure
libogg-configure: $(TARGET_CRTBEGIN_DYNAMIC_O) $(TARGET_CRTEND_O) $(LIB)/libc.so $(LIB)/libz.so
	echo $(LIBOGG_BUILT_SOURCES)
	cd $(LIBOGG_TOP) ; \
	CC="$(CONFIGURE_CC)" \
	CFLAGS="$(CONFIGURE_CFLAGS)" \
	LD=$(TARGET_LD) \
	LDFLAGS="$(CONFIGURE_LDFLAGS)" \
	CPP=$(CONFIGURE_CPP) \
	CPPFLAGS="$(CONFIGURE_CPPFLAGS)" \
	PKG_CONFIG_PATH=$(CONFIGURE_PKG_CONFIG_PATH) \
	PKG_CONFIG_TOP_BUILD_DIR=/ \
	$(abspath $(LIBOGG_TOP))/$(CONFIGURE) --host=arm-linux-androideabi \
	--prefix=/system --disable-nls --disable-loadsave \
	--disable-valgrind --disable-gtk-doc && \
	for file in $(LIBOGG_BUILT_SOURCES); do \
		rm -f $$file && \
		make -C $$(dirname $$file) $$(basename $$file) ; \
	done

CONFIGURE_TARGETS += libogg-configure

-include $(LIBOGG_TOP)/src/Android.mk
