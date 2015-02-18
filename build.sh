#!/bin/bash

export="MAVEN_OPTS=-Xmx2G -XX:MaxPermSize=256m"
unset CODENVY_LOCAL_CONF_DIR
mvn clean install