#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/selene

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable Virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch.mk)

# Apex
TW_EXCLUDE_APEX := true

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# API
PRODUCT_SHIPPING_API_LEVEL := 30

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery

PRODUCT_PACKAGES += \
    create_pl_dev \
    create_pl_dev.recovery

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service-recovery \
    android.hardware.gatekeeper@1.0-impl-recovery

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.gatekeeper=beanpod

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libpuresoftkeymasterdevice

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so

PRODUCT_PACKAGES += \
    libshim_beanpod

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# libion & libxml2
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

PRODUCT_VENDOR_PROPERTIES += \
    log.tag=I \
    persist.log.tag=I
