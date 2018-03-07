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
<<<<<<< HEAD
=======
  PODS=$1
  #my_pod=$1
>>>>>>> ecc216746d0934f7cd1f487de725964520e7e2e4
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
<<<<<<< HEAD
  echo "PODs variable is: $PODS"
  sleep 15
  until [[ `oc get pods | grep "rails-postgresql-example-1-hook-pre"` ]] ; do
      echo "[createTemplate]: WAiting on POD9s) to come up, so far: `oc get pods | grep -v NAME`"
      sleep 2
  done
  echo "Done waiting!"
  sleep 10
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | cut -d ' ' -f 1` ; do
=======
  until [[ `oc get pods | grep rails-postgresql-example-1-hook-pre | grep Completed` ]] ; do
        echo "[createTemplate]: Waiting on PODs to come up, so far: `oc get pods | grep -v NAME`"
        sleep 1
  done
  sleep 10
  echo "Waiting for the REAL rails-postgresql-1-<random> to come up..."
  echo -e "`oc get pods` \nIf we got here, then: Done waiting!"
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | grep Running | cut -d ' ' -f 1` ; do
      echo "[[DEBUGGIUNG]]: DOLLAR-EYE is: $i"
>>>>>>> ecc216746d0934f7cd1f487de725964520e7e2e4
      tstAnnotate $i
      retVal=$?
      passed=0
      failed=0
      if [[ retVal -gt 0 ]] ; then
          echo "FAIL: [createTemplate] Failed POD Annotations Test on $i.  Failing Fast!"
          exit 46
          echo "[[DEBUGGING]]: "$?""
          (( failed++ ))
      else
          echo "Passed POD Annotations test on $i!"
          (( passed++ ))
      fi
  done
  echo "[createTemplate] Test Passed for all PODs!"
}

tstAnnotate() {
  PODS=$1
  echo "New testing POD Annotations on: $PODS"
  echo "Checking for BlackDuck POD Annotations..."
  a_state=$(oc describe pod $PODS | grep BlackDuck)
  echo "$a_state"
  if [[ -z a_state ]] ; then
      echo "ERROR: There appears to be no POD Annotations present on $PODS"
      exit 1;
  else
      echo "PASS: BlackDuck OpsSight POD Annotations found on POD: $PODS!  TEST PASS"
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
