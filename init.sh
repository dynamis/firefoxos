#!/bin/bash

# load constants
. constants

# init and update submodule(s)
init_submodule() {
  git submodule init
  git submodule update
}

# init and update compare-locales script
init_compare_locales() {
  git submodule init compare-locales
  git submodule update compare-locales
}

# copy official/unofficial branding properties file
# cp_gaia_branding <gaiadir> <locale>
cp_gaia_branding() {
  local gaiadir=${1:-gaia}
  local locale=${2:-ja}
  
  cp $gaiadir/shared/locales/branding/official/branding.en-US.properties $gaiadir/shared/locales/branding/official/branding.$locale.properties
  cp $gaiadir/shared/locales/branding/unofficial/branding.en-US.properties $gaiadir/shared/locales/branding/unofficial/branding.$locale.properties
}

# clone B2G files and symlink .userconfig file
init_b2g() {
  local b2gdir=${B2GDIR:-B2G}
  
  echo "clone B2G repo and make symlink for .userconfig..."
  git clone $B2GREPO $b2gdir
  
  echo "make symlink for $b2gdir/.userconfig..."
  ln -s ../userconfig $b2gdir/.userconfig
  
  echo "Run |cd B2G; ./config.sh| to start configure and building Firefox OS."
}

# init_gaia <branch> <locale>
init_gaia() {
  case "$1" in
  "master"|"")
    local branch=master
    local gaiadir=$GAIADIR
    ;;
  "v2.0"|"2.0")
    local branch=v2.0
    local gaiadir=$GAIA20DIR
    ;;
  "v1.4"|"1.4")
    local branch=v1.4
    local gaiadir=$GAIA14DIR
    ;;
  "v1.3"|"1.3")
    local branch=v1.3
    local gaiadir=$GAIA13DIR
    ;;
  *)
    echo "Invalid branch '$1' specified."
    exit -1;
  esac
  local locale=${2:-ja}
  
  echo "clone gaia '$branch' branch to '$gaiadir' directory..."
  case "$branch" in
  "master")
    git clone $GAIAREPO $gaiadir
    ;;
  *)
    git clone -b $branch --single-branch $GAIAREPO $gaiadir
    ;;
  esac
  
  echo "copy branding locale files..."
  cp_gaia_branding $gaiadir $locale
  
  echo "Run |./make-gaia.sh reset-gaia| to build and flash Gaia part of the device."
}

# init_l10n <branch> <locale>
init_l10n() {
  local branch=${1:-master}
  local locale=${2:-ja}

  case "$branch" in
  "master"|"")
    echo "clone l10n repos for master branch..."
    git submodule init $GAIALOCALEBASEDIR/en-US
    git submodule init $GAIALOCALEBASEDIR/$locale
    git submodule update $GAIALOCALEBASEDIR/en-US
    git submodule update $GAIALOCALEBASEDIR/$locale
    hg clone https://hg.mozilla.org/l10n-central/$locale $GECKOL10NBASEDIR/$locale
    ;;
  
  "v2.0"|"2.0")
    echo "clone l10n repos for v2.0 (Gecko32) branch..."
    hg clone https://hg.mozilla.org/releases/gaia-l10n/v2_0/en-US/ $GAIA20LOCALEBASEDIR/en-US
    hg clone https://hg.mozilla.org/releases/gaia-l10n/v2_0/$locale/ $GAIA20LOCALEBASEDIR/$locale
    hg clone https://hg.mozilla.org/releases/l10n/mozilla-beta/$locale/ -b $GECKO32BRANCH $GECKO32L10NBASEDIR/$locale
    ;;
  
  "v1.4"|"1.4")
    echo "clone l10n repos for v1.4 (Gecko30) branch..."
    hg clone https://hg.mozilla.org/releases/gaia-l10n/v1_4/en-US/ $GAIA14LOCALEBASEDIR/en-US
    hg clone https://hg.mozilla.org/releases/gaia-l10n/v1_4/$locale/ $GAIA14LOCALEBASEDIR/$locale
    hg clone https://hg.mozilla.org/releases/l10n/mozilla-release/$locale/ -b $GECKO30BRANCH $GECKO30L10NBASEDIR/$locale
    ;;

  "v1.3"|"1.3")
    echo "clone l10n repos for v1.3 (Gecko28) branch..."
    # note: we don't have v1_3/ja repo and use v1_4/ja one instead
    hg clone https://hg.mozilla.org/releases/gaia-l10n/v1_3/en-US/ $GAIA13LOCALEBASEDIR/en-US
    hg clone https://hg.mozilla.org/releases/gaia-l10n/v1_4/$locale/ $GAIA13LOCALEBASEDIR/$locale
    hg clone https://hg.mozilla.org/releases/l10n/mozilla-release/$locale/ -b $GECKO28BRANCH $GECKO28L10NBASEDIR/$locale
    ;;
  *)
    echo "Invalid branch '$1' specified."
    exit -1;
  esac
  
  init_compare_locales
}

# init.sh b2g|gaia:    prepare B2G/Gaia build environment
# init.sh master|vX.X: prepare l10n files for the branch
case "$1" in
"b2g"|"B2G")
  init_b2g
  exit 0
  ;;

"gaia"|"Gaia")
  shift
  init_gaia $*
  exit 0
  ;;

"l10n"|"localization")
  shift
  init_l10n $*
  exit 0
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
