#!/bin/bash

#createDockerHub() {
#  set -x
#  WAIT_TIME=$((10))
#  echo "Test: Deploying directly via DockerHUB"
#  oc new-project tst-deploy-dockerhub
#  oc new-app centos/python-35-centos7~https://github.com/openshift/django-ex.git
#  sleep $WAIT_TIME
  # Store the output (in an array perhaps?) and pass the pods to the tstAnnotate function??
#  output=$(oc get pods | grep -i django | cut -d' ' -f 1 | sed 's/:.*//')
#  x=0
#  for my_pod in  ${output[@]}; do
#    echo $my_pod;
#    test2 $my_pod
#    echo "function exit was $?"
#    read x
#     tstAnnotate $my_pod
#     if $? -gt 0 ; then 
#       let x=((++X))
#     fi
#  done

 #  echo "ALL TESTS RAN : FAILURES =$x"
#  echo "Exiting w code $x (the number of failures)"
#  exit $x
# }

createDockerHub() {
  # set -x
  WAIT_TIME=$((10))
  echo "Test: Deploying directly via DockerHUB"
  oc new-project tst-deploy-dockerhub
  oc new-app centos/python-35-centos7~https://github.com/openshift/django-ex.git
  i=0
  sleep $WAIT_TIME
  #until oc get pods | grep -i django | cut -d' ' -f 1 ; do
  #  sleep 2;
  #  (( i++ ))
  # done
  # Store the output in an array and pass the pods to the tstAnnotate function
  output=$(oc get pods | grep -i django | cut -d' ' -f 1 | sed 's/:.*//')
  if [ -z $output ] ; then
    echo "ERROR: No POD(s) found matching $output! - Exiting!"
    return 1;
  else
    echo "POD(s) $my_pod found, w00t! Moving on..."
  fi
  x=0
  for my_pod in ${output[@]} ; do
    echo $my_pod;
    tstAnnotate $my_pod
    echo "Function exit was $?"
    if $? -gt 0 ; then
      (( x++ ))
    fi
  done
  echo "Test Ran : FAILURES = $x"
}

# Verify POD has been annotated with "BlackDuck"
tstAnnotate() {
  my_pod=$1
  echo $0
  echo $1
  echo $my_pod
  echo "now test annotating $my_pod"
  read x

  WAIT_TIME=$((10))
  echo "Checking for BlackDuck POD annotations..."
  sleep $WAIT_TIME
  a_state=$(oc describe pod $my_pod | grep -i BlackDuck)
  if [[ $a_state == "" ]]; then
    echo "ERROR: There appears to be no POD Annoations present on $my_pod!"
    return 1;
  else
    echo "BlackDuck OpsSight Annoations found! TEST PASS"
  fi
}

createDockerHub
