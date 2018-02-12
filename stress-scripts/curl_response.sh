#!/bin/bash
while true
do
    curl -w "@curl-format.txt" -o /dev/null -s "https://ec2-18-220-1-193.us-east-2.compute.amazonaws.com:8443/console"
done
