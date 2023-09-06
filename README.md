# TLG's Linago Distro :sunglasses:

Hello there (future me probably) :wave: - this is my fork of LineageOS that will allow me easily build it and make some small modifications

## What to fork?? How to modify stuff??

Main repo to fork turned out to be this - it contains `default.xml` file that google's `repo` listens to to pull EVERYTHING else

- Main way of me modifing lineage's stuff is to modify said file to point to my forks - for example, if I wanted to modify SystemUI app, I would:
  1. Fork `LineageOS/android_frameworks_base`
  2. Modify stuff in `packages/SystemUI`
  3. Switch `<project path="frameworks/base" name="LineageOS/android_frameworks_base" groups="pdk-cw-fs,pdk-fs" />` in `default.xml` to point to my fork instead
  4. ...then keep merging Lineage's `frameworks` into mine and hope nothing conflicts

- Second way, if something is small enough, I will apply patches/stuff through scripts ran just after `repo sync`

- Third way (not to modify but add more stuff, like external pre-installed apps) will be to add their repo manifests to `.repo/local_manifests/`

## How to start

Create a `lineage` folder here, `cd` to it, and then run:
```bash
repo init -u https://github.com/TheLastGimbus/android.git -b lineage-20.0 --git-lfs
repo sync
```

## Modifications that were done
### MicroG
- manifest pointing to `TheLastGimbus/android_vendor_partner_gms` that contains prebuilts of MicroG and manifests on where `repo` should put them
- patch files in `microg-patches/` stolen from `https://github.com/lineageos4microg/docker-lineage-cicd/tree/master/src/signature_spoofing_patches`
  - i just manually download `android_frameworks_base-Android13.patch` and put it here bc it's already unstable enough to fool ourselfs into automatically pulling this repo or smth
- `post-repo-microg-patch.sh` script that applies the patches

