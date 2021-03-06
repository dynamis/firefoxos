#!/bin/bash

. constants
. userconfig

case "$1" in
""|"master")
  export LOCALE_BASEDIR="$userconfig_dir/$GAIALOCALEBASEDIR"
  export L10NBASEDIR="$userconfig_dir/$GECKOL10NBASEDIR"
  cd ./$GAIADIR
  shift
  make $*
  ;;

"v2.0"|"2.0")
  export LOCALE_BASEDIR="$userconfig_dir/$GAIA20LOCALEBASEDIR"
  export L10NBASEDIR="$userconfig_dir/$GECKO32L10NBASEDIR"
  cd ./$GAIA20DIR
  shift
  make $*
  ;;

"v1.4"|"1.4")
  export LOCALE_BASEDIR="$userconfig_dir/$GAIA14LOCALEBASEDIR"
  export L10NBASEDIR="$userconfig_dir/$GECKO30L10NBASEDIR"
  cd ./$GAIA14DIR
  shift
  make $*
  ;;

"v1.3"|"1.3")
  export LOCALE_BASEDIR="$userconfig_dir/$GAIA13LOCALEBASEDIR"
  export L10NBASEDIR="$userconfig_dir/$GECKO28L10NBASEDIR"
  cd ./$GAIA13DIR
  shift
  make $*
  ;;

*)
  export LOCALE_BASEDIR="$userconfig_dir/$GAIALOCALEBASEDIR"
  export L10NBASEDIR="$userconfig_dir/$GECKOL10NBASEDIR"
  cd ./$GAIADIR
  make $*
  ;;
esac
