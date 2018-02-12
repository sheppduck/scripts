#!/usr/bin/env bash
for i in `oc get images --all-namespaces | cut -d' ' -f 1` ; do oc delete image $i ; done
