# Use the non-open-source part, if present
-include vendor/mediatek/k55v1_64_bsp/BoardConfigVendor.mk

TARGET_BOARD_PLATFORM := mt6755

# Recovery
# Enable twrp variant only for 'make recoveryimage'
# Do not enable for full build
#RECOVERY_VARIANT := twrp

# Use the 6755 common part
include device/mediatek/mt6755/BoardConfig.mk

BOARD_MTK_VENDOR_SIZE_KB := 524288

#Config partition size
-include $(MTK_PTGEN_OUT)/partition_size.mk
ifneq ($(strip $(MTK_AB_OTA_UPDATER)), yes)
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
endif
BOARD_FLASH_BLOCK_SIZE := 4096

MTK_INTERNAL_CDEFS := $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$($(t))\"))

MTK_GLOBAL_CFLAGS += $(MTK_INTERNAL_CDEFS)

ifneq ($(MTK_K64_SUPPORT), yes)
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
BOARD_KERNEL_CMDLINE = bootopt=64S3,32S1,32S1 \
	androidboot.selinux=permissive
else
BOARD_KERNEL_CMDLINE = bootopt=64S3,32S1,32S1
endif
else
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,64N2 \
	androidboot.selinux=permissive
else
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,64N2
endif
endif

# TWRP
ifeq ($(RECOVERY_VARIANT),twrp)
include device/mediatek/k55v1_64_bsp/twrp.mk
endif

-include device/mediatek/build/core/soong_config.mk
