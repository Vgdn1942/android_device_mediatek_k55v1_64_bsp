#For GMO to reduce runtime memroy usage
ifeq (yes,$(strip $(MTK_GMO_RAM_OPTIMIZE)))

ifneq (yes,$(strip $(MTK_BASIC_PACKAGE)))
ifneq (yes,$(strip $(MTK_BSP_PACKAGE)))
#only support at tk (not basic and bsp package)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.path_cache_size=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.text_small_cache_width=512
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.text_small_cache_height=256
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.disable_asset_atlas=true

endif
endif


# Disable fast starting window in GMO project
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.mtk_perf_fast_start_win=0

#Images for LCD test in factory mode
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_00_gmo.png:$(TARGET_COPY_OUT_VENDOR)/res/images/lcd_test_00.png:mtk
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_01_gmo.png:$(TARGET_COPY_OUT_VENDOR)/res/images/lcd_test_01.png:mtk
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_02_gmo.png:$(TARGET_COPY_OUT_VENDOR)/res/images/lcd_test_02.png:mtk

endif

# PRODUCT_COPY_FILES += $(LOCAL_PATH)/egl.cfg:system/lib/egl/egl.cfg
# PRODUCT_COPY_FILES += $(LOCAL_PATH)/ueventd.mt6755.rc:root/ueventd.mt6755.rc

PRODUCT_COPY_FILES += $(LOCAL_PATH)/factory_init.project.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/factory_init.project.rc
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.project.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.project.rc
PRODUCT_COPY_FILES += $(LOCAL_PATH)/meta_init.project.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/meta_init.project.rc

ifeq ($(strip $(MTK_C2K_SUPPORT)),yes)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.c2k.rc:root/init.c2k.rc
PRODUCT_COPY_FILES += $(LOCAL_PATH)/meta_init.c2k.rc:root/meta_init.c2k.rc
endif

ifeq ($(MTK_SMARTBOOK_SUPPORT),yes)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/sbk-kpd.kl:system/usr/keylayout/sbk-kpd.kl:mtk \
                      $(LOCAL_PATH)/sbk-kpd.kcm:system/usr/keychars/sbk-kpd.kcm:mtk
endif

# Add FlashTool needed files
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/EBR1:EBR1
#ifneq ($(wildcard $(LOCAL_PATH)/EBR2),)
#  PRODUCT_COPY_FILES += $(LOCAL_PATH)/EBR2:EBR2
#endif
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/MBR:MBR
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/MT6755_Android_scatter.txt:MT6755_Android_scatter.txt

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.sf.lcd_density=360

PRODUCT_COPY_FILES += $(LOCAL_PATH)/ht120.mtc:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.ht120.mtc

ifneq ($(filter yes,$(MTK_PUMP_EXPRESS_PLUS_SUPPORT) $(MTK_PUMP_EXPRESS_PLUS_20_SUPPORT) $(MTK_PUMP_EXPRESS_PLUS_30_SUPPORT)),)
  ifeq ($(TARGET_BUILD_VARIANT),eng)
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.eng.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/thermal.conf
  else
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/thermal.conf
  endif

  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.wfd.6755.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_policy_00
  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.pip.6755.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_policy_01
  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.fdvrgis.6755.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_policy_02
  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.meta.6755.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_meta.conf
else
  ifeq ($(TARGET_BUILD_VARIANT),eng)
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.eng_noBCCT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/thermal.conf
  else
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal_noBCCT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/thermal.conf
  endif

  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.wfd.6755_noBCCT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_policy_00
  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.pip.6755_noBCCT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_policy_01
  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.fdvrgis.6755_noBCCT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_policy_02
  PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermal.meta.6755_noBCCT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/.tp/.thermal_meta.conf
endif


# alps/vendor/mediatek/proprietary/external/GeoCoding/Android.mk

# alps/vendor/mediatek/proprietary/frameworks-ext/native/etc/Android.mk

# touch related file for CTS
ifeq ($(strip $(CUSTOM_KERNEL_TOUCHPANEL)),generic)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml
else
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml
endif

# USB OTG
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# GPS relative file
ifeq ($(MTK_GPS_SUPPORT),yes)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml
endif

# alps/external/libnfc-opennfc/open_nfc/hardware/libhardware/modules/nfcc/nfc_hal_microread/Android.mk
# PRODUCT_COPY_FILES += external/libnfc-opennfc/open_nfc/hardware/libhardware/modules/nfcc/nfc_hal_microread/driver/open_nfc_driver.ko:$(TARGET_COPY_OUT_VENDOR)/lib/open_nfc_driver.ko:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/nfc.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/nfc.cfg:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/nfcse.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/nfcse.cfg:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/libnfc-nci.conf:system/etc/libnfc-nci.conf
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/libnfc-nxp.conf:system/etc/libnfc-nxp.conf
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/nfc.cfg:system/etc/nfc.cfg
PRODUCT_COPY_FILES += $(LOCAL_PATH)/nfc/nfcse.cfg:system/etc/nfcse.cfg

# alps/frameworks/av/media/libeffects/factory/Android.mk
PRODUCT_COPY_FILES += frameworks/av/media/libeffects/data/audio_effects.conf:system/etc/audio_effects.conf

# alps/mediatek/config/$project
PRODUCT_COPY_FILES += $(LOCAL_PATH)/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.sys.usb.config=mtp
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.service.acm.enable=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.mount.fs=EXT4

#PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapgrowthlimit=256m
#PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapsize=512m

# meta tool
PRODUCT_PROPERTY_OVERRIDES += ro.mediatek.chip_ver=S01
PRODUCT_PROPERTY_OVERRIDES += ro.mediatek.platform=MT6755

# set Telephony property - SIM count
SIM_COUNT := 2
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.sim.count=$(SIM_COUNT)
PRODUCT_PROPERTY_OVERRIDES += persist.radio.default.sim=0

# Audio Related Resource
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/k55v1_64_bsp/factory/res/sound/testpattern1.wav:$(TARGET_COPY_OUT_VENDOR)/res/sound/testpattern1.wav:mtk
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/k55v1_64_bsp/factory/res/sound/ringtone.wav:$(TARGET_COPY_OUT_VENDOR)/res/sound/ringtone.wav:mtk

# Keyboard layout
PRODUCT_COPY_FILES += device/mediatek/mt6755/ACCDET.kl:system/usr/keylayout/ACCDET.kl:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk-kpd.kl:system/usr/keylayout/mtk-kpd.kl:mtk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk-tpd.kl:system/usr/keylayout/mtk-tpd.kl:mtk

# Microphone
PRODUCT_COPY_FILES += $(LOCAL_PATH)/android.hardware.microphone.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.microphone.xml

# Camera
PRODUCT_COPY_FILES += $(LOCAL_PATH)/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml

ifeq ($(strip $(AGOLD_CAMERA_VERSION)),yes)
PRODUCT_PACKAGES += \
	lib_cam_imx258_mipi_raw_SYX_0AQH5_v1 \
	lib_cam_s5k3l8_mipi_raw_BLX_50065B_v1 \
	lib_cam_s5k3l8_mipi_raw_JLX_50064_v1 \
	lib_cam_s5k3l8_mipi_raw_SY_50065_v1 \
	lib_cam_ov13853_mipi_raw_SYX_50016A_v1 \
	lib_cam_ov5670_mipi_raw_SYX_M509_v1

PRODUCT_PACKAGES += \
	lib_lens_dw9714af_v1 \
	lib_lens_dw9714af_v2 \
	lib_lens_dw9714af_v3 \
	lib_lens_dw9714af_v4 \
	lib_lens_dw9714af_v5 \
	lib_lens_dw9714af_v6 \
	lib_lens_dw9714af_v8 \
	lib_lens_dw9714af_v9 \
	lib_lens_dw9714af_v10 \
	lib_lens_dw9714af_v11 \
	lib_lens_dw9714af_v12 \
	lib_lens_dw9714af_v13 \
	lib_lens_dw9714af_v14 \
	lib_lens_dw9800af_v1 \
	lib_lens_dw9800af_v2 \
	lib_lens_dw9800af_v3 \
	lib_lens_dw9763af_v1 \
	lib_lens_dw9763af_v2 \
	lib_lens_dw9763af_v3 \
	lib_lens_dw9763af_v4 \
	lib_lens_dw9763af_v5
endif

# Audio Policy
PRODUCT_COPY_FILES += $(LOCAL_PATH)/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf:mtk

ifneq ($(MTK_AUDIO_TUNING_TOOL_VERSION),)
  ifneq ($(strip $(MTK_AUDIO_TUNING_TOOL_VERSION)),V1)
    AUDIO_PARAM_OPTIONS_LIST += SPK_PATH_INT=yes
    AUDIO_PARAM_OPTIONS_LIST += SPK_PATH_LO=no
    AUDIO_PARAM_OPTIONS_LIST += SPK_PATH_HP=no
    AUDIO_PARAM_OPTIONS_LIST += SPK_PATH_NO_ANA=no
  endif
endif

#Images for LCD test in factory mode
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/k55v1_64_bsp/factory/res/images/lcd_test_00.png:$(TARGET_COPY_OUT_VENDOR)/res/images/lcd_test_00.png:mtk
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/k55v1_64_bsp/factory/res/images/lcd_test_01.png:$(TARGET_COPY_OUT_VENDOR)/res/images/lcd_test_01.png:mtk
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/k55v1_64_bsp/factory/res/images/lcd_test_02.png:$(TARGET_COPY_OUT_VENDOR)/res/images/lcd_test_02.png:mtk


# overlay has priorities. high <-> low.
DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/sd_in_ex_otg

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
ifdef OPTR_SPEC_SEG_DEF
  ifneq ($(strip $(OPTR_SPEC_SEG_DEF)),NONE)
    OPTR := $(word 1,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF)))
    SPEC := $(word 2,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF)))
    SEG  := $(word 3,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF)))
    DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/operator/$(OPTR)/$(SPEC)/$(SEG)
  endif
endif
ifneq (yes,$(strip $(MTK_TABLET_PLATFORM)))
  ifeq (480,$(strip $(LCM_WIDTH)))
    ifeq (854,$(strip $(LCM_HEIGHT)))
      DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/FWVGA
    endif
  endif
  ifeq (540,$(strip $(LCM_WIDTH)))
    ifeq (960,$(strip $(LCM_HEIGHT)))
      DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/qHD
    endif
  endif
endif
ifeq (yes,$(strip $(MTK_GMO_ROM_OPTIMIZE)))
  DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/slim_rom
endif
ifeq (yes,$(strip $(MTK_GMO_RAM_OPTIMIZE)))
  DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/slim_ram
endif
DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/navbar

$(call inherit-product, device/mediatek/mt6755/device.mk)

$(call inherit-product-if-exists, vendor/mediatek/libs/$(MTK_TARGET_PROJECT)/device-vendor.mk)

# GAPPS
$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)

GAPPS_VARIANT := nano

GAPPS_FORCE_PACKAGE_OVERRIDES := true

GAPPS_BYPASS_PACKAGE_OVERRIDES := \
    GoogleDialer \
    GoogleMessaging

GAPPS_PRODUCT_PACKAGES += \
    CalculatorGoogle \
    CalendarGooglePrebuilt \
    CarrierServices \
    GoogleContacts \
    GoogleContactsSyncAdapter \
    GoogleDialer \
    GoogleMessaging \
    GooglePackageInstaller \
    LatinImeGoogle \
    PlayGames \
    PrebuiltDeskClockGoogle \
    PrebuiltGmail \
    PrebuiltKeep \
    TranslatePrebuilt \
    YouTube

GAPPS_EXCLUDED_PACKAGES := \
    Books \
    Hangouts \
    Music2 \
    Newsstand \
    Photos \
    Street \
    Velvet \
    Videos

