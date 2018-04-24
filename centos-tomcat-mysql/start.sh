#!/bin/bash

if [ ! -f ${CATALINA_HOME}/scripts/.tomcat_admin_created ]; then
	${CATALINA_HOME}/scripts/create_admin_user.sh
fi
exec su tomcat -s /opt/tomcat/bin/catalina.sh  run & su mysql -s  /bin/run-mysqld
