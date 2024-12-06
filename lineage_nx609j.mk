#
# Copyright (C) 2017 The LineageOS Open Source Project
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
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit from nx609j device
$(call inherit-product, device/nubia/nx609j/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := lineage_nx609j
PRODUCT_BRAND := Nubia
PRODUCT_DEVICE := nx609j
PRODUCT_MANUFACTURER := Nubia
PRODUCT_MODEL := Red Magic

PRODUCT_GMS_CLIENTID_BASE := android-zte

TARGET_VENDOR := nubia
TARGET_VENDOR_PRODUCT_NAME := NX609J
TARGET_VENDOR_DEVICE_NAME := NX609J

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="NX609J-user 9 PKQ1.181021.001 eng.nubia.20210421.021356 release-keys" \
    BuildFingerprint=nubia/NX609J/NX609J:9/PKQ1.181021.001/eng.nubia.20210421.021356:user/release-keys \
    DeviceName=NX609J \
    DeviceProduct=NX609J
