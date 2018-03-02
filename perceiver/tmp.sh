#!/bin/bash
#oc login -u clustadm -p devops123!
i=0
until oc get pods | grep -i "busybox" ; do
  sleep 1;
  (( i++ ));
done
# while true ; do oc get pods | grep -i -q "busybox" ; sleep 2 ; done
