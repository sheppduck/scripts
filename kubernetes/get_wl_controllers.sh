#!/bin/bash

deployments="$(kubectl get deployments --all-namespaces | awk '$5 > 0 {print $2}' |sed "1 d" | wc -l)"
ds="$(kubectl get ds --all-namespaces | awk '$5 > 0 {print $2}'| sed "1 d" | wc -l)"
statefulsets="$(kubectl get statefulsets --all-namespaces | sed "1 d" | wc -l)"
jobs="$(kubectl get jobs --all-namespaces | grep -v "istio-system" | sed "1 d" | wc -l)"
get_wl () {
      total="$(( $ds + $deployments + $statefulsets + $jobs ))"
      echo "$deployments Deployments"
      echo "$ds DaemonSets"
      echo "$statefulsets StatefulSets"
      echo "$jobs Jobs"
      echo "$total Total WL Controllers"
}

get_wl
