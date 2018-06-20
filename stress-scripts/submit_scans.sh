#!/bin/bash
# Script that submits many scans (MAX_SCANS var) to a black duck hub.  You'll need your own JAR files
# In a DIR structire like (e.g. /home/user/hub_load/project-123456-foo/codelocatoin-98765 and in this DIR
# Have some JAR files.  You should create dozens of DIRs like this with hundreds of JARS to scan in each /codelocation-98765

HUB=$1

OIFS=$IFS; IFS=$'\n';
jars=($(find . -name \*.jar -print))
IFS=$OIFS;

scanner="scan.cli-4.7.0/bin/scan.cli.sh"
scanner="scan.cli-4.6.2/bin/scan.cli.sh"

pos=0
scans=0
MAX_SCANS=50
MAX_CODELOCATIONS=1
while [ $pos -lt ${#jars[@]} ]
do
  num_jars=$(( ( RANDOM % 15 ) + 1 ))
  end=$((pos + num_jars))
  if [ $end -gt ${#jars[@]} ]
  then
    num_jars=$((#jars[@] - pos))
  fi
  project_jars=("${jars[@]:$pos:$num_jars}")
  project_name="2-project-$(($RANDOM))"-joel2
  mkdir $project_name

  RANDOM=`date "+%s"`
  versions=$(( ( RANDOM % 20 ) + 1 ))
  for ((v=1; v<=$versions;v++))
  do
    num_codelocations=$(( ( RANDOM % 2 ) + 1 ))
    if [ $num_codelocations -gt $MAX_CODELOCATIONS ]
    then
      num_codelocations=1
    fi
    for ((cl=0; cl<$num_codelocations;cl++))
    do
      RANDOM=`date "+%s"`
      cl_name="codelocation-$((RANDOM))"
      mkdir $project_name/$cl_name
      cp ${project_jars[@]} $project_name/$cl_name
      SCAN_CLI_OPTS=-Dspring.profiles.active=bds-disable-scan-graph BD_HUB_PASSWORD=blackduck $scanner -v --project $project_name --name $cl_name --release $v --host $HUB --port 443 --insecure --username sysadmin $project_name/$cl_name
      # Joel S.  Added this sleep as a sort of rate limiter - wait 1m before submitting next scan
      sleep 60
      ((scans++))
      echo "Total scans submitted: $scans"
      if [ $scans -gt $MAX_SCANS ]
      then
        exit 0
      fi
    done
  done
  rm -rf $project_name
  pos=$((pos + num_jars + 1))
done
