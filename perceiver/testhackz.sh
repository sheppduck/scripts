#!/bin/bash

# Store the output (in an array perhaps?) and pass the pods to the tstAnnotate function??
output=$(oc get pods | grep -i django | cut -d' ' -f 1 | sed 's/:.*//')
for my_pod in $output; do
  echo $my_pod;
done

#output=$(oc get pods | grep -i django | cut -d' ' -f 1 | sed 's/:.*//')
#for x in $output; do 
#  echo $x;
#done
#echo $out | awk '{for(i=1;i<=NF;i++) print $i;}'
#ar=($out)
#echo ${ar[0]}
#echo ${ar[1]}
#  if [ -z 

