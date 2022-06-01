
# dockerfile to build image for JBoss EAP 6.4

# start from rhel 7.2
#FROM rhel
FROM ubi8/ubi:8.3
# file author / maintainer
MAINTAINER "FirstName LastName" "emailaddress@gmail.com"


# update OS
RUN yum -y update && \
yum -y install sudo openssh-clients unzip java-1.8.0-openjdk-devel && \
yum clean all

# enabling sudo group
# enabling sudo over ssh
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
sed -i 's/.*requiretty$/Defaults !requiretty/' /etc/sudoers

# add a user for the application, with sudo permissions
RUN useradd -m jboss ; echo jboss: | chpasswd ; usermod -a -G wheel jboss

# create workdir
RUN mkdir -p /opt/rh

WORKDIR /opt/rh

# install JBoss EAP 6.4.0
ADD jboss-eap-6.4.0.zip /tmp/jboss-eap-6.4.0.zip
RUN unzip /tmp/jboss-eap-6.4.0.zip

# set environment
ENV JBOSS_HOME /opt/rh/jboss-eap-6.4

# create JBoss console user
RUN $JBOSS_HOME/bin/add-user.sh admin admin@2016 --silent
# configure JBoss
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> $JBOSS_HOME/bin/standalone.conf

# set permission folder
RUN chown -R jboss:jboss /opt/rh

# JBoss ports
EXPOSE 8080 9990 9999

# start JBoss
ENTRYPOINT $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml

# deploy app
ADD myapp.war "$JBOSS_HOME/standalone/deployments/"

USER jboss
CMD /bin/bash
