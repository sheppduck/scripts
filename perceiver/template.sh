#!/bin/bash

sanity_check() {
  oc get version
  oc get pods
  if [[ "$?" == 0 ]] ; then
      echo "OpenShift seems okay."
  else
      echo "FAIL: The OpenShift preconditions for the oc cloent were not met, Exiting..."
      exit 22
  fi
}

createTemplate() {
  NS=php
  #NEW_APP=$1
  PODS=$2
  #my_pod=$1
  # Create the project to deploy to
  # First let's see if the project exists, nuke it if so
  if [[ -z $NS ]] ; then
      echo "Sweet, NS: $NS not found, let's do this!"
  else
      echo "Dang it!  NS: $NS Found, Frenzy needs to destroy it!!"
      burnItDown $NS
  fi
  echo "Test: Deploy Image via OpenShift Template"
  oc new-project $NS
  oc new-app -f /usr/share/openshift/examples/quickstart-templates/rails-postgresql.json
  echo "PODs variable is: $PODS"
  sleep 30
  until [[ `oc get pods | grep -v STATUS | wc -l` -ge "$PODS" ]] ; do
      echo "[createTemplate]: WAiting on POD9s) to come up, so far: `oc get pods | grep -v NAME`"
      sleep 3
  done
  echo "Done waiting!"
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | cut -d ' ' -f 1` ; do
      tstAnnotate $i
      retVal=$?
      passed=0
      failed=0
      if [[ retVal -gt 0 ]] ; then
          echo "FAIL: [createTemplate] Failed POD Annotations Test on $i.  Failing Fast!"
          (( failed++ ))
      else
          echo "PAssed POD Annotations test on $i!"
          (( passed++ ))
      fi
  done
  echo "[createTemplate] Test Passed for all PODs in $NEW_APP"
}

tstAnnotate() {
  my_pod=$1
  echo "New testing POD Annotations on: $my_pod"
  echo "Checking for BlackDuck POD Annotations..."
  a_state=$(oc describe pod $my_pod | grep BlackDuck)
  echo "$a_state"
  if [[ -z a_state ]] ; then
      echo "ERROR: There appears to be no POD Annotations present on $my_pod"
      exit 1;
  else
      echo "PASS: BlackDuck OpsSight POD Annotations found on POD: $my_pod!  TEST PASS"
  fi
}

burnItDown() {
  #Burn the Deployment down
  echo "[burnItDown] START!!!"
  while oc get project | grep -i -q $NS ; do
      echo "`date` [[ burnItDown ]] still waiting `oc delete project $NS`"
      sleep 8
  done
  echo "[burnItDown] DONE!!"
}

createTemplate
  if [[ $? -gt 0 ]] ; then
    echo "Failed @$createTemplate"
    exit $?
 fi
