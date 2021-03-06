LOCAL_PATH:= system/core/libpixelflinger
include $(CLEAR_VARS)
#
# C/C++ and ARMv5 objects
#
include $(CLEAR_VARS)

PIXELFLINGER_SRC_FILES:= \
	codeflinger/CodeCache.cpp \
	format.cpp \
	clear.cpp \
	raster.cpp \
	buffer.cpp

ifeq ($(filter x86%,$(TARGET_ARCH)),)
PIXELFLINGER_SRC_FILES += \
	codeflinger/ARMAssemblerInterface.cpp \
	codeflinger/ARMAssemblerProxy.cpp \
	codeflinger/GGLAssembler.cpp \
	codeflinger/load_store.cpp \
	codeflinger/blending.cpp \
	codeflinger/texturing.cpp \
	fixed.cpp.arm \
	picker.cpp.arm \
	pixelflinger.cpp.arm \
	trap.cpp.arm \
	scanline.cpp.arm \

endif

PIXELFLINGER_CFLAGS := -fstrict-aliasing -fomit-frame-pointer

PIXELFLINGER_SRC_FILES_arm := \
	codeflinger/ARMAssembler.cpp \
	codeflinger/disassem.c \
	col32cb16blend.S \
	t32cb16blend.S \

ifeq ($(ARCH_ARM_HAVE_NEON),true)
PIXELFLINGER_SRC_FILES_arm += col32cb16blend_neon.S
PIXELFLINGER_CFLAGS_arm += -D__ARM_HAVE_NEON
endif

PIXELFLINGER_SRC_FILES_arm64 := \
	codeflinger/Arm64Assembler.cpp \
	codeflinger/Arm64Disassembler.cpp \
	arch-arm64/col32cb16blend.S \
	arch-arm64/t32cb16blend.S \

PIXELFLINGER_SRC_FILES_x86 := \
	codeflinger/x86/X86Assembler.cpp \
	codeflinger/x86/GGLX86Assembler.cpp \
	codeflinger/x86/load_store.cpp \
	codeflinger/x86/blending.cpp \
	codeflinger/x86/texturing.cpp \
	fixed.cpp \
	picker.cpp \
	pixelflinger.cpp \
	trap.cpp \
	scanline.cpp

PIXELFLINGER_C_INCLUDES_x86 := \
	external/libenc
	
ifndef ARCH_MIPS_REV6
PIXELFLINGER_SRC_FILES_mips := \
	codeflinger/MIPSAssembler.cpp \
	codeflinger/mips_disassem.c \
	arch-mips/t32cb16blend.S \

endif

#
# Static library version
#
include $(CLEAR_VARS)
LOCAL_CLANG := false
LOCAL_MODULE:= libpixelflinger_static
LOCAL_SRC_FILES := $(PIXELFLINGER_SRC_FILES)
LOCAL_SRC_FILES_arm := $(PIXELFLINGER_SRC_FILES_arm)
LOCAL_SRC_FILES_arm64 := $(PIXELFLINGER_SRC_FILES_arm64)
LOCAL_SRC_FILES_x86 := $(PIXELFLINGER_SRC_FILES_x86)
ifndef ARCH_MIPS_REV6
LOCAL_SRC_FILES_mips := $(PIXELFLINGER_SRC_FILES_mips)
endif
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_C_INCLUDES += $(LOCAL_EXPORT_C_INCLUDE_DIRS)
LOCAL_CFLAGS := $(PIXELFLINGER_CFLAGS)
LOCAL_C_INCLUDES_x86 := $(PIXELFLINGER_C_INCLUDES_x86)
include $(BUILD_STATIC_LIBRARY)
