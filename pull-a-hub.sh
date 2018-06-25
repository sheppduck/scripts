#!/bin/bash
# This script will: attempt to pull hub docker nightly builds and container
# images from bds-docker.test-repo.blackducksoftware.com and then through
# magical powers of docker and bash pushes said nightly containers to GKE Verification  
# Author: Joel Sheppard 2018 Synopsys Inc.

set -x
# TODO COMMENT THE SHIT OUT OF THIS!! JOEL
HUB_VERSION="4.7.1"
NIGHTLY_BLDS="https://test-repo.blackducksoftware.com/artifactory/bds-hub-nightly/com/blackducksoftware/hub/hub-docker"
UN="reader"
PDub="EGGlaptop4EGG_&"
TMP_DIR="/tmp/testernetes"
export BIT_BUCKET="/home/kippernetes/kippernetes/bitbucket"
KIPP_EXTNS="/opt/kipp-extensions"

rm -rf /tmp/testernetes/*

# =================================#
# Pull the nightly Hub build
# =================================#
dl_hub () {
wget --user $UN --password $PDub $NIGHTLY_BLDS/$HUB_VERSION/hub-docker-$HUB_VERSION.tar -P $TMP_DIR
exit_status=$?
echo "Exit status was $exit_status"
if [[ $exit_status -eq 0 ]] ; then
    echo "Yay, Hub $HUB_VERSION nightly TARBALL was successfully saved to $TMP_DIR"
    echo "`ls -ltra $HUB_TMP | grep hub-docker-`"
else
    echo "[ERROR] Something went wrong, unable to save the Hub $HUB_VERSION nightly, the exit code was $exit_status."
    exit 1
fi
}
# ==================================#
# Extract the Hub Nightly TARBALL
# ==================================#
unzip_hub () {
# pushd into our temp location
pushd $TMP_DIR
pwd
tar -C $TMP_DIR -xvf $TMP_DIR/hub-docker-$HUB_VERSION.tar
exit_status="$?"
# now popd back to where we were (e.g. /home/kipp.../kipp.../
popd
echo "Hub tarball extraction exit code was $exit_status"
if [[ $exit_status -eq 0 ]] ; then
    echo "Hub tarball extracted successfully"
else
    echo "*******[ERROR] Hard to believe but something went wrong with unpacking the Hub tarball - weird right?!?!?! The exit code was $exit_status!!! *******"
    exit 1
fi
}
# ====================================#
# Copy all the things to bitbucket DIR
# ====================================#
bitbucket_copy () {
# pushd into our temp location
pwd
pushd $TMP_DIR/hub-docker-$HUB_VERSION
    pwd
    echo "Copying kubernetes dir to $BIT_BUCKET..."
    yes | cp -a ./kubernetes/. $BIT_BUCKET/kube
    exit_status="$?"
    if [[ $exit_status -eq 0 ]] ; then
        echo "[Kube] Copy was successful, moving on to Docker Swarm."
    else
        echo "i*******[ERROR] Something's gone wrong with the Kube copy, aborting! Exit code was: $exit_status!!! *******"
        exit 3
    fi
popd
pwd
pushd $TMP_DIR/hub-docker-$HUB_VERSION
    pwd
    echo "Copying Docker Swarm dir to $BIT_BUCKET..."
    yes | cp -a ./docker-swarm/. $BIT_BUCKET/swarm
    exit_status="$?"
    if [[ $exit_status -eq 0 ]] ; then
        echo "[Swarm] Copy was successful - Docker Swarm dir copied!"
    else
        echo "*******[ERROR] Somethings gone wrong with the Swarm copy, aborting! Exit code was $exit_status!!! *******"
        exit 4
    fi
    # Pop back out to where we were...
popd
pwd
}

# =====================================#
# Deploy Hub Images to gke verification
#======================================#
prepCluster()  {
# pushd into /opt/kipp-extensions dir
pushd $KIPP_EXTNS
    pwd
    echo "Calling prepare-cluster, pushing $HUB_VERSION to GKE..."
    sudo ./prepare-cluster.sh
    exit_status=$?
    if [[ $exit_status -eq 0 ]] ; then
        echo "[prepare-cluster]: exit code $exit_status, $HUB_VERSION images successfully pushed to GKE Verification"
    else
        echo "*******[ERROR]: prepare-cluster exit code $exit_status, somethings broken!!!! *******"
        echo "**************************"
        echo "**************************"
        exit 5
    fi
    # Pop on back out to where we were...
popd
pwd
}
# ==============================#
# Next Function
# ==============================#

dl_hub
unzip_hub
bitbucket_copy
prepCluster
