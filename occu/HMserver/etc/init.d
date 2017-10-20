#!/bin/sh
#
# Starts HMServer.
#

LOGLEVEL_HMServer=5
CFG_TEMPLATE_DIR=/etc/config_templates
PIDFILE=/var/run/HMIPServer.pid
STARTWAITFILE=/var/status/HMServerStarted

init() {
	export TZ=`cat /etc/config/TZ | cut -d'-' -f1 | cut -d'+' -f1`
	export JAVA_HOME=/opt/jre-1.8.0_121-compact3
	export PATH=$PATH:$JAVA_HOME/bin
	if [ ! -e /etc/config/log4j.xml ] ; then
		cp $CFG_TEMPLATE_DIR/log4j.xml /etc/config
	fi
}

start() {
	echo -n "Starting HMServer: "
	init
	start-stop-daemon -S -q -m -p $PIDFILE --exec java -- -Xmx64m -Dlog4j.configuration=file:///etc/config/log4j.xml -Dfile.encoding=ISO-8859-1 -jar /opt/HMServer/HMIPServer.jar /etc/crRFD.conf &
	echo "Waiting for HMServer to get ready"
	eq3configcmd wait-for-file -f $STARTWAITFILE -p 5 -t 300
	echo "OK"
}
stop() {
	echo -n "Stopping HMServer: "
	rm -f $STARTWAITFILE
	start-stop-daemon -K -q -p $PIDFILE
	rm -f $PIDFILE
	echo "OK"
}
restart() {
	stop
	start
}

case "$1" in
  start)
	start
	;;
  stop)
	stop
	;;
  restart|reload)
	restart
	;;
  *)
	echo "Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?

