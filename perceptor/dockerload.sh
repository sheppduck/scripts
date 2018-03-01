#!/bin/bash



createDockerLoad() {
  set -e
  #set -x
  REGISTRY_PORT=":5000"
  NS=pushtest
  # NEW_APP=$1
  PODS=$2
  #if [[ "$PODS" -eq ""  ]] ; then
  #  echo "ERROR: NO PODS FOUND, EXITING!!!"
  #  exit 26
  #fi
  my_pod=$1
  echo "Test: Deploying via Docker Load..."
  echo "Pulling hello-world..."
  sudo docker pull hello-world
  echo "Saving hello-world as a tarball..."
  sudo docker save hello-world > /var/tmp/hello-world.tar
  if [[ $? -gt 0 ]] ; then
      echo "`ls -l` | grep hello-world.tar Cannot save hello-world as a tarball to /tmp exiting- Fail fast!"
      exit "$?"
  else
      echo "Yea, docker image saved successfully!!"
  fi
  echo "Loading image via docker load..."
  sudo docker load -i /var/tmp/hello-world.tar
  if [[ $? -gt 0 ]] ; then
      echo "Image NOT Loaded, exiting - fail fast!!"
      exit "$?"
  else
      echo "Docker Load completed successfully!!! `sudo docker images | grep hello-world`"
  fi
  # Login to Openshift
  # TODO Do something better here for logging in, hide the PW...
  echo "Login to OpenShift..."
  oc login -u=clustadm -p=devops123!
  oc_token=$(oc whoami -t)
  echo "$oc_token"
  if [[ -z $oc_token ]] ; then
      echo "No oc-token found, exiting!!"
      exit 28
  else
      echo "oc_token found: $oc_token"
  fi
  # Swith to the default project (the registry is here)
  echo "Switching project to default, doker registry lives here..." 
  oc project default
  # Let's find the Openshift Registry IP
  # Field 5 is the IP, and we can assume the PORT will always be 5000 and
  # export that
  echo "Finding the OpenShift Registry IP..."
  regIpPort=$(oc get svc | grep docker-registry | cut -d ' ' -f 5)$REGISTRY_PORT
  echo "Registry IP is: $regIpPort"
  if [[ -z $regIpPort ]] ; then
      echo "Something's wrong, cannot get the docker-registry IP and Port!!!"
      exit 27
  else
      echo "Found the docker-registry and port:  $regIpPort"
  fi
  # Now let's login to the Image Registry
  echo " Logging into the Default Image Registry..."
  sudo docker login -u clustadm -e test@synopsys.com -p $oc_token $regIpPort
  # Create a project to push to
  # First, let's see if the project exists - nuke it.
  if [[ -z $NS ]] ; then
      echo "Sweet, NS: $NS not found, let's do this!"
  else
      echo "Dang it, NS: $NS found, Frezy needs to destroy it!"
      burnItDown $NS
  fi
  echo "Creating new project '$NS'"
  oc new-project $NS
  # Now let's tag the image
  echo "Tagging pushtest image..."
  sudo docker tag docker.io/hello-world $regIpPort/pushtest
  if [[ $? -gt 0 ]] ; then
      echo "Tagging has failed, exiting - FAIL Fast!!"
      exit "$?"
  else
      echo "Docker Image tagged successfully!"
  fi
  # Now push this puppy to the Registry
  echo "Pushing docker image to the OpenShift Registry..."
  sudo docker push $regIpPort/pushtest/hello-world
  if [[ $? -gt 0 ]] ; then
      echo "Docker push failed, exiting - FAIL Fast!"
      exit "$?"
  else
      echo "Docker Push was successful!"
  fi
  # Let's see if the pushtest ImageStream is created...
  echo "`oc get is` Did the image deploy as an ImageSteam???  No POD I bet... "
  echo "If there's no PODs, GTFO!"
  if [[ `oc get pods | grep -v STATUS | wc -l` -eq 0 ]] ; then
      echo "There are no PODs for this depoloyment type (dockerLoad) EXITING!"
      exit 1
  else
      echo "PODs Found, now we can move forward with confidence!"
  fi
  # Okay we made it this far, let's now move forward with POD Annotations testing
  until [[ `oc get pods | grep -v STATUS | wc -l` -ge "$PODS"  ]] ; do
    echo "createDockerPush: Waiing on POD(s) to come up, so far: `oc get pods | grep -v NAME`"
    sleep 3
  done
  echo "Done waiting!"
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | cut -d ' ' -f 1` ; do
    tstAnnotate $i
    retVal=$?
    passed=0
    failed=0
    if [[ retVal -gt 0  ]] ; then
      echo "FAIL: createDockerLoad Failed POD Annoations test on $i. Failing Fast!"
      (( failed++  ))
    else
      echo "Passed POD Annoations test on $i!"
      (( passed++  ))
    fi
    done
    echo "createDockerPush Test Passed for all PODs in $NEW_APP."
}

# Verify POD(s) have been annotated with "BlackDuck"
tstAnnotate() {
  my_pod=$1
  echo "Now testing POD Annoations on: $my_pod"
  echo "Checking for BlackDuck POD annotations..."
  a_state=$(oc describe pod $my_pod | grep -i BlackDuck)
  echo "a_state"
  if [[ $a_state -eq ""  ]] ; then
    echo "ERROR: There appears to be no POD Annoations present on $my_pod!"
    exit 1;
  else
    echo "BlackDuck OpsSight Annoations found on $my_pod! TEST PASS"
  fi
}

burnItDown() {
#Burn all the deployments down
echo "[burnItDown] START!!!"
  while oc get project | grep -i -q $NS ; do
      echo "`date` [[ burnItDown ]] still waiting `oc delete project $NS`"
      sleep 8
    done
  echo "[burnItDown] DONE!!"
  }


  createDockerLoad
  # This shit below doesn't seem to do shit...
  if [[ $? -gt 0 ]] ; then
      echo "Failed @ $createDockerLoad"
      echo "exit $?"
  else
      echo "No failures detected."
  fi
 # burnItDown
