## script to docker save all hub containers
## run script with blah params...

#!/bin/bash

docker save -o hub-zookeeper_$TAG.tar blackducksoftware/hub-zookeeper:$TAG
docker save -o hub-webapp_$TAG.tar blackducksoftware/hub-webapp:$TAG
docker save -o hub-solr.tar blackducksoftware/hub-solr:$TAG
docker save -o hub-registration_$TAG.tar blackducksoftware/hub-registration:$TAG
docker save -o hub-postgres_$TAG.tar blackducksoftware/hub-postgres:$TAG
docker save -o hub-nginx_$TAG.tar blackducksoftware/hub-nginx:$TAG
docker save -o hub-logstash_$TAG.tar blackducksoftware/hub-logstash:$TAG
docker save -o hub-jobrunner_$TAG.tar blackducksoftware/hub-jobrunner:$TAG
docker save -o hub-documentation_$TAG.tar blackducksoftware/hub-documentation:$TAG
docker save -o hub-cfssl_$TAG.tar blackducksoftware/hub-cfssl:$TAG
docker save -o hub-solr_$TAG.tar blackducksoftware/hub-solr:$TAG