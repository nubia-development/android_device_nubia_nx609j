#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        # Patch blobs for VNDK
        vendor/lib/hw/camera.msm8998.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libgui.so" "${2}"
            "${PATCHELF}" --remove-needed "libandroid.so" "${2}"
            "${PATCHELF}" --remove-needed "android.hidl.base@1.0.so" "${2}"
            ;;
        vendor/lib/libnubia_effect.so | vendor/lib64/libnubia_effect.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libgui.so" "${2}"
            ;;
        vendor/lib/libNubiaImageAlgorithm.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed  "libjnigraphics.so" "${2}"
            "${PATCHELF}" --remove-needed  "libnativehelper.so" "${2}"
            "${PATCHELF}" --add-needed "libui_shim.so" "${2}"
            "${PATCHELF}" --add-needed "libNubiaImageAlgorithm_shim.so" "${2}"
            ;;
        vendor/lib/libarcsoft_picauto.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libandroid.so" "${2}"
            ;;
        vendor/lib64/libgf_hal.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libpowermanager.so" "${2}"
            ;;
        vendor/lib64/libgoodixfingerprintd_binder.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --add-needed "libbinder_shim.so" "${2}"
            ;;
        vendor/lib64/android.hardware.gatekeeper@1.0.so | vendor/lib64/vendor.goodix.hardware.fingerprint@1.0.so)
            [ "$2" = "" ] && return 0
            grep -q libhidlbase_shim.so "${2}" || "${PATCHELF}" --add-needed "libhidlbase_shim.so" "${2}"
            ;;
        vendor/lib/libSonyIMX318PdafLibrary.so | vendor/lib/libarcsoft_beautyshot.so | vendor/lib/libarcsoft_beautyshot_image_algorithm.so | vendor/lib/libarcsoft_beautyshot_video_algorithm.so | vendor/lib/libarcsoft_high_dynamic_range.so | vendor/lib/libarcsoft_low_light_shot.so | vendor/lib/libarcsoft_night_shot.so | vendor/lib/libarcsoft_picauto.so | vendor/lib64/libarcsoft_beautyshot.so | vendor/lib64/libarcsoft_beautyshot_image_algorithm.so | vendor/lib64/libarcsoft_beautyshot_video_algorithm.so | vendor/lib64/libarcsoft_low_light_shot.so | vendor/lib64/libarcsoft_night_shot.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required!
export DEVICE=nx609j
export DEVICE_COMMON=msm8998-common
export VENDOR=nubia
export VENDOR_COMMON=${VENDOR}

export DEVICE_BRINGUP_YEAR=2017

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"
