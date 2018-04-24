# Centos based container with Java and Tomcat
FROM centos/mysql-56-centos7
MAINTAINER xfalcon <****@****.***>

# Install prepare infrastructure
USER 0
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar

# Prepare environment 
ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat 
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Install Oracle Java8
ENV JAVA_VERSION 8u172
ENV JAVA_BUILD 8u172-b11
ENV JAVA_DL_HASH a58eab1ec242421181065cdc37240b08

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
 http://download.oracle.com/otn-pub/java/jdk/${JAVA_BUILD}/${JAVA_DL_HASH}/jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
 tar -xvf jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
 rm jdk*.tar.gz && \
 mv jdk* ${JAVA_HOME}


# Install Tomcat
ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.7

RUN wget http://mirrors.hust.edu.cn/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 rm apache-tomcat*.tar.gz && \
 mv apache-tomcat* ${CATALINA_HOME}

RUN chmod +x ${CATALINA_HOME}/bin/*sh

# Create Tomcat admin user
ADD create_admin_user.sh $CATALINA_HOME/scripts/create_admin_user.sh
ADD start.sh $CATALINA_HOME/scripts/start.sh
ADD mysql-init $APP_DATA/mysql-init
RUN chmod +x $APP_DATA/mysql-init/*.sh
RUN chmod +x $CATALINA_HOME/scripts/*.sh

# Create tomcat user
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME} &&\
 chown -R mysql:mysql ${APP_DATA}

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009
USER 0
CMD ["start.sh"]
