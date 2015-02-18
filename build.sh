#!/bin/bash

export MAVEN_OPTS=-Xmx4G -XX:MaxPermSize=256m
unset CODENVY_LOCAL_CONF_DIR
mvn clean install