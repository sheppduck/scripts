##Experimental MySQL Functions## That you could add to your ~/.bashrc
 
function batterUp {
    echo "Let's clean this mess up and install mysql so you can get to your ######### MySQL DB... now!"
    echo "First we need to get rid of the current Maria-libs"
    sudo rpm -qa | grep "maria" | xargs sudo yum remove -y
    echo "Okay now that's over, time to install mysql"
    sudo yum install -y mysql
}
 
function podid {
    echo $(kubectl get pods -n ######### | grep "$1" | cut -d' ' -f 1)
}
 
function sql {
    if [[ $1 == -r ]] ; then repeat=$2; shift 2; fi
    local pod=$(podid ^db)
    if [[ $pod ]] ; then
     fwd=$(kubectl port-forward $pod 3306 -n ######### >&2 & sleep 3; echo $!)
    fi
    cmd='mysql --protocol=tcp -uroot -A ###db'
    if [[ $* ]] ; then
        while true; do
            echo "$@" | $cmd
            echo
            if [[ $repeat ]]; then sleep $repeat; else break; fi
        done
    else
        $cmd
    fi
    kill -9 $fwd
}
