#!/bin/bash

# full and update submodule files
git submodule foreach git pull
git submodule update

# pull and update gecko l10n files
hg -R gecko-l10n/ja pull
hg -R gecko-l10n/ja update
