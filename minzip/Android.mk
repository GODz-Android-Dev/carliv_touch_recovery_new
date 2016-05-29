LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	Hash.c \
	SysUtil.c \
	DirUtil.c \
	Inlines.c \
	Zip.c

LOCAL_C_INCLUDES := \
	external/zlib \
	external/safe-iop/include \
	external/lzma/xz-embedded

LOCAL_STATIC_LIBRARIES := libselinux
LOCAL_STATIC_LIBRARIES += libxz
LOCAL_STATIC_LIBRARIES += libz

LOCAL_MODULE := libminzip

LOCAL_CFLAGS += -Wall

include $(BUILD_STATIC_LIBRARY)