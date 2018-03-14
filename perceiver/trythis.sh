#!/bin/bash
ignore_bld=$(oc get pods | grep -i build | cut -d' ' -f 1)
echo "ignore_bld is: $ignore_bld"
if [[ "$ignore_bld" == *build ]] 
then
    echo "true"
else
    echo "false"
fi
