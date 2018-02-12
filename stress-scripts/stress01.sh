#This script will create about 100 projects and new apps in OpenShift,
#then after a set sleep (wait) will start deleteing projects with a 5 min wait between each delete
#lastly we grep for all images and delete those
#script then loops back and starts all over again creating apps and projects... then del all again.


#!/usr/bin/env bash
x=1
while [ $x -le 600 ]
do
  oc login -u=clustadm -p=qapw4all
  oc new-project rubyex
  oc project rubyex
  oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git
  oc new-project ruby-hellowrld
  oc project ruby-hellowrld
  oc new-app ruby-hellowrld/my-ruby~https://github.com/openshift/ruby-hello-world.git
  oc new-project puma-test-app
  oc project puma-test-app
  oc new-app https://github.com/openshift/sti-ruby.git \ --context-dir=2.0/test/puma-test-app
  oc new-project mysql1
  oc project mysql1
  oc new-app mysql
  oc new-project helloworld-mysql
  oc project helloworld-mysql
  oc new-app https://github.com/openshift/ruby-hello-world mysql
  oc new-project nginxandmysql
  oc project nginxandmysql
  oc new-app nginx+mysql
  oc new-project myphpex
  oc project myphpex
  oc new-app php
  oc new-project glassfish
  oc project glassfish
  oc new-app glassfish
  oc new-project wildfly
  oc project wildfly
  oc new-app jboss/wildfly
  oc new-project liberty
  oc project liberty
  oc new-app websphere-liberty
  oc new-project orientdb
  oc project orientdb
  oc new-app orientdb
  oc new-project tomee
  oc project tomee
  oc new-app tomee
  oc new-project gcc
  oc project gcc
  oc new-app gcc
  oc new-project elixir
  oc project elixir
  oc new-app elixir
  oc new-project groovy
  oc project groovy
  oc new-app groovy
  oc new-project kapacitor
  oc project kapacitor
  oc new-app kapacitor
  oc new-project ros
  oc project ros
  oc new-app ros
  oc new-project tomcat
  oc project tomcat
  oc new-app tomcat
  oc new-project tomcat801
  oc project tomcat801
  oc new-app rossbachp/apache-tomcat8
  oc new-project openjdk1801
  oc project openjdk1801
  oc new-app openjdk
  oc new-project sso701
  oc project sso701
  oc new-app ukti/directory-sso
  oc new-project dotnet01
  oc project dotnet01
  oc new-app microsoft/dotnet 
  oc new-project jenkins01
  oc project jenkins01
  oc new-app jenkins
  oc new-project mariadb01
  oc project mariadb01
  oc new-app mariadb
  oc new-project mongo01
  oc project mongo01
  oc new-app mongo
  oc new-project mysql0101
  oc project mysql0101
  oc new-app mysql
  oc new-project node01
  oc project node01
  oc new-app node
  oc new-project perl01
  oc project perl01
  oc new-app perl 
  oc new-project php01
  oc project php01
  oc new-app php
  oc new-project postgresql01
  oc project postgresql01
  oc new-app postgresql
  oc new-project python01
  oc project python01
  oc new-app python
  oc new-project redis01
  oc project redis01
  oc new-app redis
  oc new-project rubyruby
  oc project rubyruby
  oc new-app ruby
  oc new project nginx
  oc project nginx
  oc new-app nginx
  oc new project redis
  oc project redis
  oc new-app redis
  oc new project busybox
  oc project busybix
  oc new-app busybox
  oc new project ubuntu
  oc project ubuntu
  oc new-app ubuntu
  oc new project alpine
  oc project alpine
  oc new-app alpine
  oc new project mysql
  oc project mysql
  oc new-app mysql
  oc new project mongo
  oc project mongo
  oc new-app mongo
  oc new project elasticsearch
  oc project elasticsearch
  oc new-app elasticsearch
  oc new project logstash
  oc project logstash
  oc new-app logstash
  oc new project postgres
  oc project postgres
  oc new-app postgres
  oc new project node
  oc project node
  oc new-app node
  oc new project ello
  oc project ello
  oc new-app hello-world
  oc new project httpd
  oc project httpd
  oc new-app httpd
  oc new project wordpress
  oc project wordpress
  oc new-app wordpress
  oc new project centos
  oc project centos
  oc new-app centos
  oc new project gazebo
  oc project gazebo
  oc new-app gazebo
  oc new project consul
  oc project consul
  oc new-app consul
  oc new project debian
  oc project debian
  oc new-app debian
  oc new project python
  oc project python
  oc new-app python
  oc new project memcached
  oc project memcached
  oc new-app memcached
  oc new project php
  oc project php
  oc new-app php
  oc new project jenkins
  oc project jenkins
  oc new-app jenkins
  oc new project java
  oc project java
  oc new-app java
  oc new project rabbitmq
  oc project rabbitmq
  oc new-app rabbitmq
  oc new project golang
  oc project golang
  oc new-app golang
  oc new project kibana
  oc project kibana
  oc new-app kibana
  oc new project mariadb
  oc project mariadb
  oc new-app mariadb
  oc new project haproxy
  oc project haproxy
  oc new-app haproxy
  oc new project tomcat
  oc project tomcat
  oc new-app tomcat
  oc new project fedora
  oc project fedora
  oc new-app fedora
  oc new project amazonlinux
  oc project amazonlinux
  oc new project cassandra
  oc project cassandra
  oc new-app cassandra
  oc new project traefik
  oc project traefik
  oc new-app traefik
  oc new project maven
  oc project maven
  oc new-app maven
  oc new project rethinkdb
  oc project rethinkdb
  oc new-app rethinkdb
  oc new project openjdk
  oc project openjdk
  oc new-app openjdk
  oc new project owncloud
  oc project owncloud
  oc new-app owncloud
  oc new project ghost
  oc project ghost
  oc new-app ghost
  oc new project nats
  oc project nats
  oc new-app nats
  oc new project perl
  oc project perl
  oc new-app perl
  oc new project telegraf
  oc project telegraf
  oc new-app telegraf
  oc new project sentry
  oc project sentry
  oc new-app sentry
  oc new project influxdb
  oc project influxdb
  oc new-app influxdb
  oc new project vault
  oc project vault
  oc new-app vault
  oc new project drupal
  oc project drupal
  oc new-app drupal
  oc new project neo4
  oc project neo4
  oc new-app neo4
  oc new project redmine
  oc project redmine
  oc new-app redmine
  oc new project percona
  oc project percona
  oc new-app percona
  oc new project ubuntu-debootstrap
  oc project ubuntu-debootstrap
  oc new-app ubuntu-debootstrap
  oc new project jruby
  oc project jruby
  oc new-app jruby
  oc new project iojs
  oc project iojs
  oc new-app iojs
  oc new project django
  oc project django
  oc new-app django
  oc new project sonarqube
  oc project sonarqube
  oc new-app sonarqube
  oc new project oraclelinux
  oc project oraclelinux
  oc new-app oraclelinux
  oc new project mono
  oc project mono
  oc new-app mono
  oc new project drupal
  oc project drupal
  oc new-app drupal
  oc new project jetty
  oc project jetty
  oc new-app jetty
  oc new project pypy
  oc project pypy
  oc new-app pypy
  oc new project buildpack-deps
  oc project buildpack-deps
  oc new-app buildpack-deps
  oc new project rocket.chat
  oc project rocket.chat
  oc new-app rocket.chat
  oc new project rails
  oc project rails
  oc new-app rails
  oc new project joomla
  oc project joomla
  oc new-app joomla
  oc new project solr
  oc project solr
  oc new-app solr
  oc new project couchbase
  oc project couchbase
  oc new-app couchbase
  oc new project zookeeper
  oc project zookeeper
  oc new-app zookeeper
  oc new project erlang
  oc project erlang
  oc new-app erlang
  oc new project notary
  oc project notary
  oc new-app notary
  oc new project kong
  oc project kong
  oc new-app kong
  oc new project couchdb
  oc project couchdb
  oc new-app couchdb
  oc new project crate
  oc project crate
  oc new-app crate
  oc new project opensuse
  oc project opensuse
  oc new-app opensuse
  oc new project arangodb
  oc project arangodb
  oc new-app arangodb
  oc new project odoo
  oc project odoo
  oc new-app odoo
  #Lets see if the below works - not working, need to configure the service account for logging first!
  #oc new-project fluentd
  #oc new-app logging-deployer-template 
  sleep 10m
  oc login -u=clustadm -p=qapw4all
   oc delete project rubyex
  sleep 5m
  oc delete project ruby-hellowrld
  sleep 5m
  oc delete project puma-test-app
  sleep 5m
  oc delete project mysql1
  sleep 5m
  oc delete project helloworld-mysql
  sleep 5m
  oc delete project nginxandmysql
  sleep 5m
  oc delete project myphpex
  sleep 5m
  oc delete project glassfish
  sleep 5m
  oc delete project wildfly
  sleep 5m
  oc delete project liberty
  sleep 5m
  oc delete project orientdb
  sleep 5m
  oc delete project tomee
  sleep 5m
  oc delete project gcc
  sleep 5m
  oc delete project elixir
  sleep 5m
  oc delete project groovy
  sleep 5m
  oc delete project kapacitor
  sleep 5m
  oc delete project ros
  sleep 5m
  oc delete project tomcat
  sleep 5m
  oc delete project tomcat801
  sleep 5m
  oc delete project openjdk1801
  sleep 5m
  oc delete project sso701
  sleep 5m
  oc delete project dotnet01
  sleep 5m
  oc delete project jenkins01
  sleep 5m
  oc delete project mariadb01
  sleep 5m
  oc delete project mongo01
  sleep 5m
  oc delete project mysql0101
  sleep 5m
  oc delete project node01
  sleep 5m
  oc delete project perl01
  sleep 5m
  oc delete project php01
  sleep 5m
  oc delete project postgresql01
  sleep 5m
  oc delete project python01
  sleep 5m
  oc delete project redis01
  sleep 5m
  oc delete project rubyruby
  sleep 5m
  oc delete project nginx
  sleep 5m
  oc delete project redis
  sleep 5m
  oc delete project busybix
  sleep 5m
  oc delete project ubuntu
  sleep 5m
  oc delete project alpine
  sleep 5m
  oc delete project mysql
  sleep 5m
  oc delete project mongo
  sleep 5m
  oc delete project elasticsearch
  sleep 5m
  oc delete project logstash
  sleep 5m
  oc delete project postgres
  sleep 5m
  oc delete project node
  sleep 5m
  oc delete project ello
  sleep 5m
  oc delete project httpd
  sleep 5m
  oc delete project wordpress
  sleep 5m
  oc delete project centos
  sleep 5m
  oc delete project gazebo
  sleep 5m
  oc delete project consul
  sleep 5m
  oc delete project debian
  sleep 5m
  oc delete project python
  sleep 5m
  oc delete project memcached
  sleep 5m
  oc delete project php
  sleep 5m
  oc delete project jenkins
  sleep 5m
  oc delete project java
  sleep 5m
  oc delete project rabbitmq
  sleep 5m
  oc delete project golang
  sleep 5m
  oc delete project kibana
  sleep 5m
  oc delete project mariadb
  sleep 5m
  oc delete project haproxy
  sleep 5m
  oc delete project tomcat
  sleep 5m
  oc delete project fedora
  sleep 5m
  oc delete project amazonlinux
  sleep 5m
  oc delete project cassandra
  sleep 5m
  oc delete project traefik
  sleep 5m
  oc delete project maven
  sleep 5m
  sleep 5m
  oc delete project rethinkdb
  sleep 5m
  oc delete project openjdk
  sleep 5m
  oc delete project owncloud
  sleep 5m
  oc delete project ghost
  sleep 5m
  oc delete project nats
  sleep 5m
  oc delete project perl
  sleep 5m
  oc delete project telegraf
  sleep 5m
  oc delete project sentry
  sleep 5m
  oc delete project influxdb
  sleep 5m
  oc delete project vault
  sleep 5m
  oc delete project drupal
  sleep 5m
  oc delete project neo4
  sleep 5m
  oc delete project redmine
  sleep 5m
  oc delete project percona
  sleep 5m
  oc delete project ubuntu-debootstrap
  sleep 5m
  oc delete project jruby
  sleep 5m
  oc delete project iojs
  sleep 5m
  oc delete project django
  sleep 5m
  oc delete project sonarqube
  sleep 5m
  oc delete project oraclelinux
  sleep 5m
  oc delete project mono
  sleep 5m
  oc delete project drupal
  sleep 5m
  oc delete project jetty
  sleep 5m
  oc delete project pypy
  sleep 5m
  oc delete project buildpack-deps
  sleep 5m
  oc delete project rocket.chat
  sleep 5m
  oc delete project rails
  sleep 5m
  oc delete project joomla
  sleep 5m
  oc delete project solr
  sleep 5m
  oc delete project couchbase
  sleep 5m
  oc delete project zookeeper
  sleep 5m
  oc delete project erlang
  sleep 5m
  oc delete project notary
  sleep 5m
  oc delete project kong
  sleep 5m
  oc delete project couchdb
  sleep 5m
  oc delete project crate
  sleep 5m
  oc delete project opensuse
  sleep 5m
  oc delete project arangodb
  sleep 5m
  oc delete project odoo
  sleep 2m
  #get all OS images, then delete them
  /var/tmp/stress-scripts/loopnamespaces.sh
  sleep 2m
  x=$(( $x + 1))
done
