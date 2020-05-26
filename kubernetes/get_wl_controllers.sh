#!/bin/bash

deployments="$(kubectl get deployments --all-namespaces | awk '$5 > 0 {print $2}' |sed "1 d" | wc -l)"
ds="$(kubectl get ds --all-namespaces | awk '$5 > 0 {print $2}'| sed "1 d" | wc -l)"
statefulsets="$(kubectl get statefulsets --all-namespaces | sed "1 d" | wc -l)"
get_wl () {
      total="$(( $ds + $deployments + $statefulsets ))"
      echo "$deployments"
      echo "$ds"
      echo "$statefulsets"
      echo "$total"
}

get_wl
