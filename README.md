# init
```
init.sh
```

# build and flash Firefox OS
```
cd B2G
./config.sh flame
./build.sh
./flash.sh
```

# build and flash Gaia only
```
./reset-gaia.sh
```
* NOTE: Major version of Gecko/Gaia should be same.

# build debug profile
```
./build-debugprofile.sh
```

# documents
* https://developer.mozilla.org/ja/Firefox_OS/Platform/Gaia/Hacking
* https://developer.mozilla.org/ja/Firefox_OS/Platform/Gaia/Build_System_Primer
* https://developer.mozilla.org/ja/Firefox_OS/Customization_with_the_.userconfig_file

# relating repos
* https://github.com/mozilla-b2g/B2G
* https://github.com/mozilla-b2g/gaia
* http://git.mozilla.org/?p=releases/l10n/en-US/gaia.git
* http://git.mozilla.org/?p=releases/l10n/ja/gaia.git
* http://hg.mozilla.org/l10n-central/ja

# memo (almost obsolete)
* https://github.com/dynamis/firefoxos/wiki
