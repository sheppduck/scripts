NS=tst-deploy-dockerhub
#!/bin/bash


# TODO JOEL ADD COMMENT ON ARGS
createNewApp() {
  NEW_APP=$1
  PODS=$2
  y_pod=$1                                                                                                               
  echo "CNA TESTING Deploying from Dockerhub with $NEW_APP and we want to see $PODS pods!"
  # set -x
  echo "CNA Test: Deploying directly via DockerHUB"
  oc new-project tst-deploy-dockerhub
  oc new-app $NEW_APP
  
  COUNTER_0=0
  until [[ `oc get pods | grep -v STATUS | wc -l` -ge "$PODS" ]] ; do
	echo "CNA waiting on pods to come up, sofar: `oc get pods | grep -v NAME`"
	sleep 3
  done
  echo "CNA done waiting !"
  for i in `oc get pods | grep -v build | grep -v deploy | grep -v NAME | cut -d ' ' -f 1`; do
	tstAnnotate $i
	retVal=$?
	passed=0
	if [[ $retVal -gt 5 ]] ; then
		echo "failed annotation test on $i. failing fast !"
		(( passed++ ))
		exit $retVal
	fi
  done
  echo "TEST PASSED for all pods in $NEW_APP"
}

# Verify POD has been annotated with "BlackDuck"
tstAnnotate() {
  my_pod=$1
  echo "now testing annotations on: $my_pod"
  echo "Checking for BlackDuck POD annotations..."
  a_state=$(oc describe pod $my_pod | grep -i BlackDuck)
  echo "$a_state"
  if [[ $a_state == "" ]]; then
    echo "ERROR: There appears to be no POD Annoations present on: $my_pod! $a_state"
    exit 1;
  else
    echo "BlackDuck OpsSight Annoations found! TEST PASS"
  fi
}

cleanup() {
	while oc get ns | grep -q $NS ; do
		echo "`date` [[ cleanup ]] still wating `oc delete project $NS`"	
		sleep 3
	done
}

cleanup
createNewApp centos/python-35-centos7~https://github.com/openshift/django-ex.git 2
