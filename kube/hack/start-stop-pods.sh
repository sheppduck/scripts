#!/bin/bash
NS=shepp
SNAME=SheppCo

# Scale UP all PODs to 1
function start_all_pods {
    start_all_pods=$(kubectl get deploy -n $NS --no-headers=true | cut -d ' ' -f1 | xargs -I % kubectl scale --replicas=1 deployment/% -n $NS)
    until [[ `kubectl get pods -n $NS | grep -v STATUS | wc -l` -eq 1  ]] ; do
        echo "START_all_pods: Waiting on $NS POD(s) to come up, so far: \n `kubectl get pods -n $NS | grep -v NAME`"
        sleep 3
    done
    echo "All $NS PODs are Running - Done waiting! - Exiting"
}
 
# Scale DOWN all PODs to 0
function stop_all_pods {
    stop_all_pods=$(kubectl get deploy -n $NS --no-headers=true | cut -d ' ' -f1 | xargs -I % kubectl scale --replicas=0 deployment/% -n $NS)
    until [[ `kubectl get pods -n turbonomic | grep -v STATUS | wc -l` -eq 0  ]] ; do
        echo -e "STOP_all_pods: Waiting on $NS POD(s) to TERMINATE, so far: \n `kubectl get pods -n $NS | grep -v NAME`"
        sleep 3
    done
    echo "All $SNAME PODs are Terminated - Done waiting! - Exiting"
