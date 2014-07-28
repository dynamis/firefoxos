#!/bin/bash

BASEDIR=$(pwd)
PATCHDIR=$BASEDIR/patches
TEMPDIR=temp/patch-apn

# temporary directory
rm -rf $TEMPDIR
mkdir -p $TEMPDIR
cd $TEMPDIR

# pull, extract and edit apn.json file
adb pull /system/b2g/webapps/settings.gaiamobile.org/application.zip
unzip application.zip shared/resources/apn.json
patch shared/resources/apn.json $PATCHDIR/apn.json.diff
zip -u application.zip shared/resources/apn.json

# Remount file systems and push to the device
adb shell mount -o remount rw /system
adb push application.zip /system/b2g/webapps/settings.gaiamobile.org/application.zip

# Reboot
echo "Please restart Setting apps (or reboot the device) and set up apn for your SIM!"
