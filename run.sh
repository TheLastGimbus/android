#!/bin/bash
set -e

cd lineage
cp ../my-manifests/*.xml .repo/local_manifests/
repo sync

mkdir -p vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/
cp ../microg-patches/frameworks_base_config.xml vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/config.xml
printf "\nPRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/microg\n" >> vendor/lineage/config/common.mk
printf "\n\$(call inherit-product, prebuilts/tlg-aurora-store/products/tlg.mk)\n" >> vendor/lineage/config/common.mk

cd frameworks/base
git clean -f
git restore .
patch --force -p1 -i ../../../microg-patches/android_frameworks_base-Android13.patch
git clean -f
cd ../..


source build/envsetup.sh

breakfast sunfish

croot
brunch sunfish
