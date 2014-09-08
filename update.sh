#!/bin/bash

. constants

# full and update all submodule files
#git submodule foreach git pull
#git submodule update

case "$1" in
"b2g"|"B2G")
  git -C $B2GDIR pull
  ;;

"gaia"|"Gaia")
  case "$2" in
  "master"|"")
    git -C $GAIADIR pull
    ;;
  "v2.0"|"2.0")
    git -C $GAIA20DIR pull
    ;;
  "v1.4"|"1.4")
    git -C $GAIA14DIR pull
    ;;
  "v1.3"|"1.3")
    git -C $GAIA13DIR pull
    ;;
  *)
    echo "Invalid branch '$2' specified."
    exit -1;
  esac
  ;;

"l10n"|"localization")
  case "$2" in
  "master"|"")
    git submodule update $GAIALOCALEBASEDIR/en-US
    git submodule update $GAIALOCALEBASEDIR/ja
    hg -R $GECKOL10NBASEDIR/ja pull -u
    ;;

  "v2.0"|"2.0")
    hg -R $GAIA20LOCALEBASEDIR/en-US pull -u
    hg -R $GAIA20LOCALEBASEDIR/ja pull -u
    hg -R $GECKO32L10NBASEDIR/ja pull -u -b $GECKO32BRANCH
    ;;

  "v1.4"|"1.4")
    hg -R $GAIA14LOCALEBASEDIR/en-US pull -u
    hg -R $GAIA14LOCALEBASEDIR/ja pull -u
    hg -R $GECKO30L10NBASEDIR/ja pull -u -b $GECKO30BRANCH
    ;;

  "v1.3"|"1.3")
    hg -R $GAIA13LOCALEBASEDIR/en-US pull -u
    hg -R $GAIA13LOCALEBASEDIR/ja pull -u
    hg -R $GECKO28L10NBASEDIR/ja pull -u -b $GECKO28BRANCH
    ;;
  esac
  ;;

*)
  echo "Usage: $0 <target> <branch>"
  echo
  echo Valid targets to init are:
  echo - b2g
  echo - gaia
  echo - l10n
  echo Valid gaia/l10n branches to init are:
  echo - master
  echo - v2.0
  echo - v1.4
  echo - v1.3
  exit -1
  ;;
esac
