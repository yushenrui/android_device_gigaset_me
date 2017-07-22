# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
DEVICE_PACKAGE_OVERLAYS := device/gigaset/me/overlay

ifneq ($(TARGET_USES_AOSP),true)
# ifdef GIGASET_EDIT
#john.qiu, 2015/07/16 changed for disable nfc config
#TARGET_USES_QCA_NFC := true
TARGET_USES_QCA_NFC := false
# endif
#TARGET_USES_QCOM_BSP := true
endif
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# copy customized media_profiles and media_codecs xmls for 8994
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/gigaset/me/media_profiles.xml:system/etc/media_profiles.xml \
                      device/gigaset/me/media_codecs.xml:system/etc/media_codecs.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
#$(call inherit-product, device/qcom/common/common64.mk)

# ifdef GIGASET_EDIT
#billy.wang@gigasetdigital.com, 2015/02/05 changed for fpc
TARGET_USES_FPC_FINGERPRINT := true

ifeq ($(TARGET_USES_FPC_FINGERPRINT), true)
#$(call inherit-product, vendor/gigaset/fingerprints/device/fingerprints1021.mk)
endif  #TARGET_USES_FPC_FINGERPRINT
# endif

PRODUCT_NAME := msm8994
PRODUCT_DEVICE := msm8994
PRODUCT_BRAND := Android
PRODUCT_MODEL := MSM8994 for arm64

#PRODUCT_BOOT_JARS += qcmediaplayer
#PRODUCT_BOOT_JARS += org.codeaurora.Performance
#PRODUCT_BOOT_JARS += vcard
#PRODUCT_BOOT_JARS += tcmiface
#ifneq ($(strip $(QCPATH)),)
#PRODUCT_BOOT_JARS += qcom.fmradio
#PRODUCT_BOOT_JARS += WfdCommon
#PRODUCT_BOOT_JARS += extendedmediaextractor
#york.zhang for pass CTS by disable Enterprise security feature 2015-06-16 step 8
#PRODUCT_BOOT_JARS += security-bridge
#PRODUCT_BOOT_JARS += qsb-port
#PRODUCT_BOOT_JARS += oem-services
#endif

# default is nosdcard, S/W button enabled in resource
# ifdef GIGASET_EDIT
#john.qiu, 2015/07/14 changed for Settings GUI
#PRODUCT_CHARACTERISTICS := nosdcard
PRODUCT_CHARACTERISTICS := default
# endif

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.class_main.sh \
    init.qcom.rc \
    init.qcom.sh \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    ueventd.qcom.rc


#Android EGL implementation
#PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
ifeq ($(TARGET_USES_AOSP), true)
PRODUCT_COPY_FILES += \
    device/qcom/common/media/audio_policy.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
    device/gigaset/me/audio_policy.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    device/gigaset/me/audio_output_policy.conf:system/vendor/etc/audio_output_policy.conf \
    device/gigaset/me/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/gigaset/me/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/gigaset/me/audio/tfa98xx_17421.cnt:system/etc/firmware/smartpa/tfa98xx_17421.cnt \
    device/gigaset/me/audio/tfa98xx_17427.cnt:system/etc/firmware/smartpa/tfa98xx_17427.cnt \
    device/gigaset/me/audio/17421_version.txt:system/etc/firmware/smartpa/17421_version.txt \
    device/gigaset/me/audio/17427_version.txt:system/etc/firmware/smartpa/17427_version.txt \
    device/gigaset/me/mixer_paths_i2s.xml:system/etc/mixer_paths_i2s.xml \
    device/gigaset/me/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    device/gigaset/me/audio_platform_info_i2s.xml:system/etc/audio_platform_info_i2s.xml \
    device/gigaset/me/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/gigaset/me/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/gigaset/me/audio_platform_info.xml:system/etc/audio_platform_info.xml

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/gigaset/me/listen_platform_info.xml:system/etc/listen_platform_info.xml

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/gigaset/me/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/gigaset/me/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/gigaset/me/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

#HDMI CEC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml

PRODUCT_PACKAGES += \
    wpa_supplicant \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/gigaset/me/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.heartrate.xml:system/etc/permissions/android.hardware.sensor.heartrate.xml \
    frameworks/native/data/etc/android.hardware.sensor.heartrate.ecg.xml:system/etc/permissions/android.hardware.sensor.heartrate.ecg.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

#Add by Harry for Audience ES704
PRODUCT_COPY_FILES += \
       device/gigaset/me/audio/es704_fw/audience-es705-fw.bin:system/etc/firmware/audience/es705/audience-es705-fw.bin \
       device/gigaset/me/audio/es704_fw/audience-es705-vs.bin:system/etc/firmware/audience/es705/audience-es705-vs.bin \
       device/gigaset/me/audio/es704_fw/adnc_cvq_detection_bkg.bin:system/etc/firmware/audience/cvqmodels/adnc_cvq_detection_bkg.bin \
       device/gigaset/me/audio/es704_fw/adnc_cvq_detection_bkg_w_hdrs.bin:system/etc/firmware/audience/cvqmodels/adnc_cvq_detection_bkg_w_hdrs.bin \
       device/gigaset/me/audio/es704_fw/adnc_cvq_training_bkg.bin:system/etc/firmware/audience/cvqmodels/adnc_cvq_training_bkg.bin
#End of add by Harry

#Add by Ethan for NXP tfa9890
PRODUCT_COPY_FILES += \
       device/gigaset/me/audio/tfa9890/17421/90_Sambo.parms:system/etc/settings/17421/90_Sambo.parms \
       device/gigaset/me/audio/tfa9890/17421/coldboot.patch:system/etc/settings/17421/coldboot.patch \
       device/gigaset/me/audio/tfa9890/17421/HQ90_13x18_Sambo_V2R2.eq:system/etc/settings/17421/HQ90_13x18_Sambo_V2R2.eq \
       device/gigaset/me/audio/tfa9890/17421/HQ90_13x18_Sambo_V2R2.preset:system/etc/settings/17421/HQ90_13x18_Sambo_V2R2.preset \
       device/gigaset/me/audio/tfa9890/17421/KS_13x18_Sambo_V2R2.speaker:system/etc/settings/17421/KS_13x18_Sambo_V2R2.speaker \
       device/gigaset/me/audio/tfa9890/17421/Speech90_13x18_Sambo_V2R2.eq:system/etc/settings/17421/Speech90_13x18_Sambo_V2R2.eq \
       device/gigaset/me/audio/tfa9890/17421/Speech90_13x18_Sambo_V2R2.preset:system/etc/settings/17421/Speech90_13x18_Sambo_V2R2.preset \
       device/gigaset/me/audio/tfa9890/17421/TFA9890_N1B12_N1C3_v2.config:system/etc/settings/17421/TFA9890_N1B12_N1C3_v2.config \
       device/gigaset/me/audio/tfa9890/17421/TFA9890_N1C3_1_7_1.patch:system/etc/settings/17421/TFA9890_N1C3_1_7_1.patch \
       device/gigaset/me/audio/tfa9890/17427/90_Sambo.parms:system/etc/settings/17427/90_Sambo.parms \
       device/gigaset/me/audio/tfa9890/17427/coldboot.patch:system/etc/settings/17427/coldboot.patch \
       device/gigaset/me/audio/tfa9890/17427/HQ90_13x18_Sambo_V2R2.eq:system/etc/settings/17427/HQ90_13x18_Sambo_V2R2.eq \
       device/gigaset/me/audio/tfa9890/17427/HQ90_13x18_Sambo_V2R2.preset:system/etc/settings/17427/HQ90_13x18_Sambo_V2R2.preset \
       device/gigaset/me/audio/tfa9890/17427/KS_13x18_Sambo_V2R2.speaker:system/etc/settings/17427/KS_13x18_Sambo_V2R2.speaker \
       device/gigaset/me/audio/tfa9890/17427/Speech90_13x18_Sambo_V2R2.eq:system/etc/settings/17427/Speech90_13x18_Sambo_V2R2.eq \
       device/gigaset/me/audio/tfa9890/17427/Speech90_13x18_Sambo_V2R2.preset:system/etc/settings/17427/Speech90_13x18_Sambo_V2R2.preset \
       device/gigaset/me/audio/tfa9890/17427/TFA9890_N1B12_N1C3_v2.config:system/etc/settings/17427/TFA9890_N1B12_N1C3_v2.config \
       device/gigaset/me/audio/tfa9890/17427/TFA9890_N1C3_1_7_1.patch:system/etc/settings/17427/TFA9890_N1C3_1_7_1.patch 

#End of add by Ethan

#Add by Ethan for APTX vendor lib
#PRODUCT_COPY_FILES += \
#       external/bluetooth/bluedroid/vendor/csr/aptX/libaptXbtshed-ARM-4.4.2.so:system/lib/libaptXbtshed-ARM-4.4.2.so \
#       external/bluetooth/bluedroid/vendor/csr/aptX/libbt-aptX-ARM-4.2.2.so:system/lib/libbt-aptX-ARM-4.2.2.so
#End of add by Ethan

# #ifdef GIGASET_EDIT
# /*cesc.xu@swdp.system, 2015/06/29. added. add exfat support */
PRODUCT_COPY_FILES += \
       device/gigaset/me/exfat_tools/fsck.exfat:system/bin/fsck.exfat \
       device/gigaset/me/exfat_tools/mkfs.exfat:system/bin/mkfs.exfat \
       device/gigaset/me/exfat_tools/mount.exfat:system/bin/mount.exfat
# #endif /*GIGASET_EDIT*/ 

# Display
PRODUCT_PACKAGES += \
    copybit.msm8994 \
    gralloc.msm8994 \
    hwcomposer.msm8994 \
    memtrack.msm8994 \
    liboverlay

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

#cc.li@rom, 2015.11.21, move it to vendor/gigaset/build/vendor-gigaset-platform.mk, and change 'su' to 'gsu'
# #ifdef GIGASET_EDIT
# /*cesc.xu@swdp.system, 2015/08/19. added. add root mode for release build */
#ifeq ($(TARGET_BUILD_VARIANT),user)
#PRODUCT_PACKAGES += \
#    su
#endif
# #endif /*GIGASET_EDIT*/
#endif /*GIGASET_EDIT*/

# add by william.yang@gigasetdigital.com for ffmpeg at 2015/04/13
PRODUCT_PACKAGES += libavutil libswresample libavcodec libavformat libswscale
PRODUCT_PACKAGES += libffmpeg_utils libFFmpegExtractor libnamparser
PRODUCT_PACKAGES += libstagefright_soft_ffmpegadec libstagefright_soft_ffmpegvdec
# add by william.yang end


ifeq ($(TARGET_USES_QCA_NFC),true)
NFC_D := true

ifeq ($(NFC_D), true)
    PRODUCT_PACKAGES += \
        libqnfc-nci \
        libqnfc_nci_jni \
        nfc_nci.msm8994 \
        QNfc \
        Tag \
        GsmaNfcService \
        com.gsma.services.nfc \
        com.gsma.services.utils \
        com.gsma.services.nfc.xml \
        com.android.nfc_extras \
        com.android.qcom.nfc_extras \
        com.android.qcom.nfc_extras.xml \
        com.android.nfc.helper \
        SmartcardService \
        org.simalliance.openmobileapi \
        org.simalliance.openmobileapi.xml \
        com.vzw.nfc\
        com.vzw.nfc.xml\
        libassd
else
    PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8994 \
    NfcNci \
    Tag \
    com.android.nfc_extras
endif

# file that declares the MIFARE NFC constant
# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
        frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml

# SmartcardService, SIM1,SIM2,eSE1 not including eSE2,SD1 as default
ADDITIONAL_BUILD_PROPERTIES += persist.nfc.smartcard.config=SIM1,SIM2,eSE1
endif # TARGET_USES_QCA_NFC

#PRODUCT_SUPPORTS_VERITY := true
#PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system
PRODUCT_AAPT_CONFIG += xlarge large

# For ES704
# Set the following flag to:
# true for streaming using Audience High Bandwidth interface only
# false for streaming using Audience High Bandwidth interface, SLIMbus recording and concatenation in HAL
ADNC_HIGH_BANDWIDTH_INTERFACE_ONLY := false

ifeq ($(ADNC_HIGH_BANDWIDTH_INTERFACE_ONLY), true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.audience.highbw=1
endif #ADNC_HIGH_BANDWIDTH_INTERFACE_ONLY

ifneq ($(ADNC_HIGH_BANDWIDTH_INTERFACE_ONLY), true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.audience.highbw=0
endif #ADNC_HIGH_BANDWIDTH_INTERFACE_ONLY

# Set the following flag to:
# true for enabling MU law decoding for CVQ streaming data
# false for disabling MU law decoding for CVQ streaming data
ADNC_MU_LAW_DECODE_ENABLE := true

# Set the following flag to:
# true for enabling CVQ KW preservation
# false for disabling CVQ KW preservation
ADNC_KW_PRESERVATION_ENABLE := false

ifeq ($(ADNC_KW_PRESERVATION_ENABLE), true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.audience.kwpres=1
endif #ADNC_KW_PRESERVATION_ENABLE

ifneq ($(ADNC_KW_PRESERVATION_ENABLE), true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.audience.kwpres=0
endif #ADNC_KW_PRESERVATION_ENABLE

# Set the following flag to:
# true for enabling CVQ user kw training utterance recording on user space
# false for disabling CVQ user kw training utterance recording on user space
ADNC_TRAINING_KW_RECORD_ENABLE := false

ifeq ($(ADNC_TRAINING_KW_RECORD_ENABLE), true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.audience.kwrec=1
endif #ADNC_TRAINING_KW_RECORD_ENABLE

ifneq ($(ADNC_TRAINING_KW_RECORD_ENABLE), true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.audience.kwrec=0
endif #ADNC_TRAINING_KW_RECORD_ENABLE

# #ifdef GIGASET_EDIT
# /*cesc.xu@swdp.system, 2015/07/23. added. set MTP as default mode for release build */
#ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp
#endif
# #endif /*GIGASET_EDIT*/


# GIGASET_EDIT  289 
# scott.chen@swdp.system 2015-7-7
#-include vendor/gigaset/build/vendor-gigaset-platform.mk 


# Del by Harry,not need
# PRODUCT_PACKAGES += SpeechService

# GIGASET_EDIT
# burce.zeng@rom.framework, 2015/05/9, add for gigaset config product
#-include vendor/gigaset/build/vendor-gigaset.mk

$(call inherit-product-if-exists, vendor/gigaset/me/me-vendor.mk)

