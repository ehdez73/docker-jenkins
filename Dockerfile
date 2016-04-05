FROM ehdez73/docker-jdk8
MAINTAINER Ernesto Hernandez "ehdez73@gmail.com"

EXPOSE 8080

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN echo "Europe/Madrid" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

############################################################ BUILD TOOLS #########################################################
# GIT
#####
RUN apt-get install -y git

# Gradle Settings
#################
ADD gradle.properties /root/.gradle/gradle.properties


# PhantomJS 2.0 (headless)
###########################
ADD https://github.com/Pyppe/phantomjs2.0-ubuntu14.04x64/raw/master/bin/phantomjs /usr/local/bin/phantomjs
RUN chmod +x /usr/local/bin/phantomjs
#RUN apt-get install -q -y build-essential g++ flex bison gperf ruby perl libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev libpng-dev libjpeg-dev

RUN apt-get install -q -y libicu52 libfontconfig libfontconfig1 libjpeg8 libpng12-0


############################################################ JENKINS  ############################################################
ENV JENKINS_VERSION 1.656
##########################
ADD http://mirrors.jenkins-ci.org/war/$JENKINS_VERSION/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war

# Plugins
##########
ENV SERVICE_NAME jenkins
ENV JENKINS_HOME /jenkins
ENV JENKINS_PLUGINS_LOCAL $JENKINS_HOME/plugins
ENV JENKINS_PLUGINS_REMOTE https://updates.jenkins-ci.org/download/plugins

ADD $JENKINS_PLUGINS_REMOTE/build-pipeline-plugin/1.5.2/build-pipeline-plugin.hpi   $JENKINS_PLUGINS_LOCAL/build-pipeline-plugin.hpi
ADD $JENKINS_PLUGINS_REMOTE/git/2.4.4/git.hpi                                       $JENKINS_PLUGINS_LOCAL/git.hpi
ADD $JENKINS_PLUGINS_REMOTE/git-client/1.19.6/git-client.hpi                        $JENKINS_PLUGINS_LOCAL/git-client.hpi
ADD $JENKINS_PLUGINS_REMOTE/jquery/1.11.2-0/jquery.hpi                              $JENKINS_PLUGINS_LOCAL/jquery.hpi
ADD $JENKINS_PLUGINS_REMOTE/parameterized-trigger/2.30/parameterized-trigger.hpi    $JENKINS_PLUGINS_LOCAL/parameterized-trigger.hpi
ADD $JENKINS_PLUGINS_REMOTE/token-macro/1.12.1/token-macro.hpi                      $JENKINS_PLUGINS_LOCAL/token-macro.hpi
ADD $JENKINS_PLUGINS_REMOTE/scm-api/1.1/scm-api.hpi                                 $JENKINS_PLUGINS_LOCAL/scm-api.hpi
ADD $JENKINS_PLUGINS_REMOTE/conditional-buildstep/1.3.3/conditional-buildstep.hpi   $JENKINS_PLUGINS_LOCAL/conditional-buildstep.hpi
ADD $JENKINS_PLUGINS_REMOTE/run-condition/1.0/run-condition.hpi                     $JENKINS_PLUGINS_LOCAL/run-condition.hpi
ADD $JENKINS_PLUGINS_REMOTE/copyartifact/1.37/copyartifact.hpi                      $JENKINS_PLUGINS_LOCAL/copyartifact.hpi
ADD $JENKINS_PLUGINS_REMOTE/promoted-builds/2.25/promoted-builds.hpi              $JENKINS_PLUGINS_LOCAL/promoted-builds.hpi
ADD $JENKINS_PLUGINS_REMOTE/ansicolor/0.4.2/ansicolor.hpi                           $JENKINS_PLUGINS_LOCAL/ansicolor.hpi
ADD $JENKINS_PLUGINS_REMOTE/groovy-postbuild/2.3.1/groovy-postbuild.hpi             $JENKINS_PLUGINS_LOCAL/groovy-postbuild.hpi
ADD $JENKINS_PLUGINS_REMOTE/ghprb/1.31.2/ghprb.hpi                                  $JENKINS_PLUGINS_LOCAL/ghprb.hpi
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

ENTRYPOINT ["/root/run.sh"]
