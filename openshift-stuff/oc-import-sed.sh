#!/bin/bash

#========================
##   Setup variables   ##
#========================
readonly IMGS_INFILE=$(cat "$1" | wc -l)
readonly IN_FILE="$1"
#========================================================
#   Compare how many lines exist in the text file      ##
#   to the prefix being added by sed, we only want     ##
#   to add a prefix to what is in the file already     ##
#   Not infinitely keep adding a prefix and a new line ##
#========================================================
ocPrefix() {
    echo "** There are: $IMGS_INFILE images in "$1" **"
    echo "Adding prefix to all images in "$1" NOW!!"
    set -x
    sed -i "s/^/oc import-image $RANDOM --from /" $IN_FILE
    set +x
}

#==========================================================
#     FIX THIS MESS BELOW ONCE FIGURE OUT THE ABOVE PUZZLE!
#==========================================================
ocSuffix() {
    set -x
    echo "Adding Suffix to all images in "$!" NOW!!"
    sed -i "s/$/:latest --confirm/" $IN_FILE
    set +x
}

ocPrefix
ocSuffix
