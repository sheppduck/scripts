#!/bin/bash
#============================================
##  Credits:  Joel Effing Sheppard -  2018 ##
#============================================

#==========================================================================================
##      Purpose:  This script takes an input file that has N docker repo/image names     ##
##      and then using sed adds an OpenShift command (a prefix and a suffix) so that     ##
##      one can easily deploy HUNDREDS or THOUSANDS of docker images to OpenShift        ##
##      with ease.  The input file is created by using a 'docker search' command         ##
##      in conjunction with the Linux 'cut' command. Here's an example docker search     ##
##  docker search zip --limit 100 | cut -d ' ' -f1 | grep -v NAME > /path/to/a/file.txt  ##
#==========================================================================================

#========================
##   Setup variables   ##
#========================
readonly IMGS_INFILE=$(cat "$1" | wc -l)
readonly IN_FILE="$1"

#========================================================
##     Take the infile and add the prefix using sed    ##
#========================================================
ocPrefix() {
    echo "** There are: $IMGS_INFILE images in "$1" **"
    echo "Adding prefix to all images in "$1" NOW!!"
    set -x
    sed -i "s/^/oc import-image $RANDOM --from /" $IN_FILE
    set +x
}

#=============================================
##     Now add the prefix also using sed    ##
#=============================================
ocSuffix() {
    set -x
    echo "Adding Suffix to all images in "$!" NOW!!"
    sed -i "s/$/:latest --confirm/" $IN_FILE
    set +x
}

#===========================
##  Release the Hounds!!  ##
#===========================
ocPrefix
ocSuffix
