# build and flash Firefox OS
```
./init.sh b2g
cd B2G
./config.sh flame
# copy branding properties file for ja locale
cp gaia/shared/locales/branding/official/branding.en-US.properties gaia/shared/locales/branding/official/branding.ja.properties
cp gaia/shared/locales/branding/unofficial/branding.en-US.properties gaia/shared/locales/branding/unofficial/branding.ja.properties
# appry patch
patch gaia/shared/resources/apn.json ../patches/apn.json.diff
./build.sh
./flash.sh
```
* WARNING: It takes very very long time (to clone many repositories).

# build and flash Gaia only
```
./init.sh gaia
./init.sh l10n
./reset-gaia.sh
```

# build and flash Gaia v2.0
```
./init.sh gaia v2.0
./init.sh l10n v2.0
./reset-gaia.sh v2.0
```
* NOTE: same for v1.4 or v1.3 branches

# documents
* https://developer.mozilla.org/ja/Firefox_OS/Platform/Gaia/Hacking
* https://developer.mozilla.org/ja/Firefox_OS/Platform/Gaia/Build_System_Primer
* https://developer.mozilla.org/ja/Firefox_OS/Customization_with_the_.userconfig_file
* https://developer.mozilla.org/ja/Firefox_OS/Developing_Gaia/make_options_reference
* https://developer.mozilla.org/ja/Firefox_OS/Developing_Gaia/Market_customizations_guide

# relating repos
* https://github.com/mozilla-b2g/B2G
* https://github.com/mozilla-b2g/gaia
* http://git.mozilla.org/?p=releases/l10n/en-US/gaia.git
* http://git.mozilla.org/?p=releases/l10n/ja/gaia.git
* http://hg.mozilla.org/l10n-central/ja

# memo (almost obsolete)
* https://github.com/dynamis/firefoxos/wiki
