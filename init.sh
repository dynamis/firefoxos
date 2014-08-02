#!/bin/bash

#### Setup Localization and Config files
# get submodule files
git submodule init
git submodule update

# get gecko l10n files
mkdir -p gecko-l10n
hg clone http://hg.mozilla.org/l10n-central/ja gecko-l10n/ja


#### Setup B2G Build Environment
# get B2G file and symlink for .userconfig
git clone git@github.com:mozilla-b2g/B2G.git
ln -s ../userconfig B2G/.userconfig


#### Setup Gaia Build Environment
# get gaia files and copy branding properties file for ja locale
git clone git@github.com:mozilla-b2g/gaia.git
cp gaia/shared/locales/branding/official/branding.en-US.properties gaia/shared/locales/branding/official/branding.ja.properties
cp gaia/shared/locales/branding/unofficial/branding.en-US.properties gaia/shared/locales/branding/unofficial/branding.ja.properties
