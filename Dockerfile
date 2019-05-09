FROM openjdk:8-jdk-slim
MAINTAINER softonic

ARG JMETER_VERSION=5.1

RUN apt-get clean && \
apt-get update && \
apt-get -qy install \
wget \
telnet \
iputils-ping \
unzip

# Install JMeter
RUN mkdir /jmeter \
&& cd /jmeter/ \
&& wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
&& tar -xzf apache-jmeter-$JMETER_VERSION.tgz \
&& rm apache-jmeter-$JMETER_VERSION.tgz

# Install Plugin Manager
ARG PLUGIN_MANAGER_VERSION=1.3
ARG CMDRUNNER_VERSION=2.2

RUN cd /jmeter/apache-jmeter-$JMETER_VERSION \
  && wget http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/$CMDRUNNER_VERSION/cmdrunner-$CMDRUNNER_VERSION.jar -O lib/cmdrunner-$CMDRUNNER_VERSION.jar \
  && wget http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/$PLUGIN_MANAGER_VERSION/jmeter-plugins-manager-$PLUGIN_MANAGER_VERSION.jar -O lib/ext/jmeter-plugins-manager-$PLUGIN_MANAGER_VERSION.jar \
  && java -cp lib/ext/jmeter-plugins-manager-$PLUGIN_MANAGER_VERSION.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

# Install plugins
ARG PLUGINS=""

RUN if [ -n "$PLUGINS" ]; \
  then \
    cd /jmeter/apache-jmeter-$JMETER_VERSION \
    && ./bin/PluginsManagerCMD.sh install $PLUGINS; \
  fi

ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/

ENV PATH $JMETER_HOME/bin:$PATH
