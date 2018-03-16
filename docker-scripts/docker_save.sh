#!/bin/bash
docker save -o /tmp/shepp/hub-zookeeper.tar blackducksoftware/hub-zookeeper:4.5.0
docker save -o /tmp/shepp/hub-webapp.tar blackducksoftware/hub-webapp:4.5.0
docker save -o /tmp/shepp/hub-solr.tar blackducksoftware/hub-solr:4.5.0
docker save -o /tmp/shepp/hub-scan.tar blackducksoftware/hub-scan:4.5.0
docker save -o /tmp/shepp/hub-registration.tar blackducksoftware/hub-registration:4.5.0
docker save -o /tmp/shepp/hub-postgres.tar blackducksoftware/hub-postgres:4.5.0
docker save -o /tmp/shepp/hub-nginx.tar blackducksoftware/hub-nginx:4.5.0
docker save -o /tmp/shepp/hub-logstash.tar blackducksoftware/hub-logstash:4.5.0
docker save -o /tmp/shepp/hub-jobrunner.tar blackducksoftware/hub-jobrunner:4.5.0
docker save -o /tmp/shepp/hub-documentation.tar blackducksoftware/hub-documentation:4.5.0
docker save -o /tmp/shepp/hub-cfssl.tar blackducksoftware/hub-cfssl:4.5.0
docker save -o /tmp/shepp/hub-authentication.tar blackducksoftware/hub-authentication:4.5.0
