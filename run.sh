#!/bin/bash

# start jenkins
java -jar /opt/jenkins.war 1>/var/log/jenkins.log 2>&1
