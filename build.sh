#!/bin/sh
# remove previous images and containers
docker rm -f jenkins
docker rmi -f ehdez73/docker-jenkins

# build and run the container
docker build --tag="ehdez73/docker-jenkins" .
docker run -d \
	-p 8888:8080 \
	--name="jenkins" ehdez73/docker-jenkins

