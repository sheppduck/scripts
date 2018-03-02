#!/bin/bash

creates2i() {
  NS=puma-test-app
  NEW_APP=$1
  PODS=$2
#  if [[ "$PODS" -eq "" ]] ; then
#      echo "ERROR: NO PODS FOUND, EXITING!!"
#      exit 25
#  else
#      echo "Nice! PODS found: $PODS."
#  fi
  my_pod=$1
  # Create a project to create the S2I in
  # First let's see if the project exists, nuke it if so
  if [[ -z $NS ]] ; then
      echo "Sweet, NS: $NS not found, let's do this!"
  else
      echo "Dang it! NS: $NS Found, Frenzy needs to destroy this NS!"
      burnItDown $NS
  fi
  echo  "Logging into OpenShift"
  oc login -u clustadm =p devops123!
  echo "Test: Deploy a Source to Image (S2i)"
  oc new-project $NS
  echo "Deploying the S2i App..."
  oc new-app https://github.com/openshift/sti-ruby.git \
      --context-dir=2.0/test/puma-test-app
  sleep 30
  until [[ `oc get pods | grep -v STATUS | wc -l` -ge "$PODS" ]] ; do
      echo "[createS2i]: Waiting on PODS to come up, so far: `oc get pods | grep -v NAME`"
      sleep 3
  done
  echo "Done waiting!"
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | cut -d ' ' -f 1` ; do
      tstAnnotate $i
      retVal=$?
      passed=0
      failed=0
      if [[ retVal -gt 0 ]] ; then
          echo :"FAIL: [createS2i] Failed POD Annotations test on $i. Failing Fast!"
          (( failed++ ))
      else
          echo "[createS2i] Passed POD Annotations rtest on $i!"
          (( passed++ ))
      fi
  done
  echo "[createS2i] Test PASSED for all POD(s) in $NEW_APP"
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

creates2i
#creates2i https://github.com/openshift/sti-ruby.git --context-dir=2.0/test/puma-test-app 1
  if [[ $? -gt 0 ]] ; then
    echo "Failed @$creates2i"
    exit $?
  fi
