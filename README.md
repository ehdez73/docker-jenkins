# Docker Continuous Integration

This image contains a Jenkins and a Sonar installation

* Jenkins 1.647 with plugins:
   * git
   * git-client
   * scm-api
   * build-pipeline-plugin
   * parameterized-trigger
   * jquery
   * conditional-buildstep
   * run-condition
   * token-macro
   * copyartifact
   * promoted-builds
   * groovy-postbuild
   * Github-pull-request-builder

* Java 1.8
* PhantomJS



# Some useful commands:

    # Build the image
    $ docker build --tag="ehdez73/docker-jenkins" .

    # Run a container
    $ docker docker run -d \
          -p 8888:8080 \
          --name="jenkins" \
          ehdez73/docker-jenkins

    # Attach to the container
    $ docker exec -i -t jenkins /bin/bash

    # Stop the container
    $ docker stop jenkins

    # Re-start the container
    $ docker start jenkins

    # remove the container
    $ docker rm jenkins

    # remove the image
    $ docker rmi ehdez73/docker-jenkins


## Usage
* Browse to Jenkins : [http://localhost:8888](http://localhost:8888)
