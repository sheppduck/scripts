#!/bin/bash

# TestRail Test Case C7440
# Tested as working Feb 2018
createDockerHub() {
  NS=tst-deploy-dockerhub
  NEW_APP=$1
  PODS=$2
  if [[ -z "$PODS" ]] ; then
    echo "ERROR: NO PODS FOUND, EXITING!!!"
    exit 24
  fi
  echo "Test: Deploying directly via DockerHUB with $NEW_APP and we want to see $PODS"
  oc new-project $NS
  oc new-app $NEW_APP
  echo "PODS equals: $PODS"
  until [[ `oc get pods | grep -v STATUS | wc -l` -ge "$PODS" ]] ; do
    echo "createDockerHub: Waiing on PODs to come up, so far: `oc get pods | grep -v NAME`"
    sleep 3
  done
  echo "Done waiting!"
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | cut -d ' ' -f 1` ; do
    tstAnnotate $i
    retVal=$?
    passed=0
    failed=0
    if [[ $retVal -gt 0 ]] ; then
      echo "Failed POD Annotations test on $i. Failing Fast!"
      (( failed++ ))
      exit $retVal
    else
      echo "Passed POD Annoations test on $i!"
      (( passed++ ))
    fi
  done
  echo "createDockerHub Test Passed for all PODs in $NEW_APP."
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
