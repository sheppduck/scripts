#!/bin/bash
# Authors: Joel Sheppard
# Purpose:  Kubernetes Update process - pulling directly from DockerHub

# Pre-Flight checks:
# move to the helm directory
cd /###/###/###/helm/

# Wipe existing ### Installation out
helm delete --purge ##-release

# Let's delete the PVs now
deletePV() {
    # Edit the pv yaml and remove the Finalizer and one line after
    'kubectl -n ### get pv -o yaml | sed -e '/finalizers:/,+1d' | kubectl replace -f -' #I've thought about trying kubectl apply here instead of replace -f... apply will apply the change immediately
    pv_count=$('kubectl get pv | awk '{print $6}' | grep -v STATUS | grep -i "Bound" | wc -l')
    until [[ $pv_count -eq 0 ]] ; do
        'kubectl get pv | awk {'print $1'} |  xargs -I % kubectl delete pv --force --grace-period=0'
        echo -e "##DELETING ### PV(s)## so far: \n 'kubectl get pv | grep -i "Bound"'
        sleep 2
    done
    echo "All ### PVs have been #DELETED# - Done waiting, exiting - bye!"

}

# Check if any ### Services are still running and purge them if so
checkSvcs() {
    svc_count=$('kubectl get services -n ### | awk '{print $1}' | wc -l')
    svcs=$('kubectl get services -n ### | awk '{print $1}'')
    until [[ $svc_count -eq 0 ]] ; do
        'kubectl delete services -n ### --grace-period=0 --force'
        echo -e "### Services Found, #Deleting.... \n remaining: $svcs  #"
        sleep 2
    done
    echo "All ### Services have been #DELETED# - Done waiting, exiting - bye!"
}

# Delete the current Docker Images
deleteDockerImgs() {
    img_count=$('sudo docker images | grep -i "###" | awk '{print $3}'')
    until [[ $img_count -eq 0 ]] ; do
        'sudo docker images | grep "###" | xargs -I % docker rmi -f'
        #'sudo docker rmi $(sudo docker images | grep ### | awk '{print $3}'')
        echo "$img_count - ### Images Found, #Deleting....#"
        sleep 2
    done
}
# Let's pull from DockerHub
pullContainers() {
    echo "### Enter ### Version string you want to pull from DockerHub e.g. ('#.##.#-SNAPSHOT'):"
    read ##_ver
    pull_ver="$##_ver"
    ip=$(cat /opt/local/etc/###.conf | grep -i "node=" | cut --complement -c1-6 | sed 's/"$//')
    helm install xl --name ###-release --namespace ### --set global.tag=$pull_ver --set-string global.externalIP=$ip --set ###.enabled=true --set ###.enabled=true
    # Do we want an add'l 'kubectl get pods -n ### | wc -l' -gt 30??
}



deletePV
checkSvcs
deleteDockerImgs
pullContainers
