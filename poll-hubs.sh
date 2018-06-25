#!/bin/bash
# This shell script is for polling dockerhub for BlackDuck Hub images
# The goal is to vett what release version to run QA-Sheppernetes tests against
# If e.g. we can pull the hub-cfssl:4.5.0 container from dockerhub, then 4.5.0
# is GA and as such Sheppernetes must be changed to test some other version
# (e.g. 4.5.1 or 4.6.0)
# Eventually we'll design a way to test all salient Hub versions under active
# development (i.e. RC build, master, and point releases)
HUB_VERSION="4.7.0"
sudo docker pull blackducksoftware/hub-cfssl:$HUB_VERSION
exit_status="$?"
echo "Last command return code was: "$exit_status""
if [ $exit_status -gt 0  ] ; then
    echo "Unable to pull hub-cfssl:$HUB_VERSION container, Safe to keep testing."
else
    echo "I can pull $HUB_VERSION containers, that means we've released $HUB_VERSION to GA!  Time to find out what Hub Version to test next..."
    exit 1
fi
