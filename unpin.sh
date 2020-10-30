#!/bin/bash
openssl x509 -inform DER -in *.der -out cacert.pem;
hash=$(openssl x509 -inform PEM -subject_hash_old -in cacert.pem |head -1);
mv cacert.pem $hash.0;
adb root;
adb remount;
adb push $hash.0 /sdcard/ ;
adb shell "mv /sdcard/$hash.0 /system/etc/security/cacerts/";
adb shell "chmod 644 /system/etc/security/cacerts/$hash.0";
adb shell reboot;
#rm $hash.0;
