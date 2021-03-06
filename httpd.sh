#!/bin/bashi -
#
# httpd Startup script for the Apache HTTP Server
#
# chkconfig: - 85 15
# description: The Apache HTTP Server is an efficient and extensible
#              server implementing the current HTTP standards.
# processname: httpd
# config: /usr/local/apache/conf/httpd.conf
# config: /etc/sysconfig/httpd
# pidfile: /var/run/httpd.pid
#
### BEGIN INIT INFO
# Provides: httpd
# Required-Start: $local_fs $remote_fs $network $named
# Required-Stop: $local_fs $remote_fs $network
# Should-Start: distcache
# Short-Description: start and stop Apache HTTP Server
# Description: The Apache HTTP Server is an extensible server
#  implementing the current HTTP standards.
### END INIT INFO

# Source function library.
. /etc/rc.d/init.d/functions

if [ -f /etc/sysconfig/httpd ]; then
	. /etc/sysconfig/httpd
fi

# Start httpd in the C locale by default.
HTTPD_LANG=${HTTPD_LANG-"C"}

# This will prevent initlog from swallowing up a pass-phrase prompt if
# mod_ssl needs a pass-phrase from the user.
INITLOG_ARGS=""

# Set HTTPD=/usr/sbin/httpd.worker in /etc/sysconfig/httpd to use a server
# with the thread-based "worker" MPM; BE WARNED that some modules may not
# work correctly with a thread-based MPM; notably PHP will refuse to start.

# Path to the apachectl script, server binary, and short-form for messages.
APACHE_HOME="/usr/local/apache"
apachectl=${APACHE_HOME}"/bin/apachectl"
httpd=${HTTPD-${APACHE_HOME}"/bin/httpd"}
PROG="Apache HTTP Server"
pidfile=${PIDFILE-/var/run/httpd.pid}
lockfile=${LOCKFILE-/var/lock/subsys/httpd}

STOP_TIMEOUT=${STOP_TIMEOUT-10}
RETVAL=0

# The semantics of these two functions differ from the way apachectl does
# things -- attempting to start while running is a failure, and shutdown
# when not running is also a failure.  So we just do it the way init scripts
# are expected to behave here.
start() {
    echo -n $"Starting $PROG: "
    LANG=$HTTPD_LANG daemon --pidfile=${pidfile} $httpd $OPTIONS
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch ${lockfile}
    return $RETVAL
}

reload() {
    echo -n $"Reloading $PROG: "
    if ! LANG=$HTTPD_LANG $httpd $OPTIONS -t >&/dev/null; then
        RETVAL=6
        echo $"not reloading due to configuration syntax error"
        failure $"not reloading $httpd due to configuration syntax error"
    else
        # Force LSB behaviour from killproc
        LSB=1 killproc -p ${pidfile} $httpd -HUP
        RETVAL=$?
        if [ $RETVAL -eq 7 ]; then
            failure $"httpd shutdown"
        fi
    fi
    return $RETVAL
}

configtest() {
	$apachectl configtest
	RETVAL=$?
	return $RETVAL
}

# When stopping httpd, a delay (of default 10 second) is required
# before SIGKILLing the httpd parent; this gives enough time for the
# httpd parent to SIGKILL any errant children.
stop() {
    echo -n $"Stopping $PROG: "
    killproc -p ${pidfile} -d ${STOP_TIMEOUT} $httpd
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfile} ${pidfile}
}

rh_status() {
	status -p ${pidfile} $httpd
	RETVAL=$?
	return $RETVAL
}

case "$1" in
	start)
		start
		;;
	force-reload|reload)
		configtest || exit 0
		reload
		;;
	restart)
		configtest || exit 0
		stop
		start
		;;
	stop)
		stop
		;;
	status)
		rh_status
		;;
	condrestart|try-restart)
		if rh_status >&/dev/null; then
			stop
			start
		fi
		;;
	configtest)
		configtest
		;;
	graceful|configtest|fullstatus|help)
		$apachectl $@
		RETVAL=$?
		;;
	*)
		echo $"Usage: $PROG {start|reload|force-reload|restart|condrestart|try-restart|stop|status|fullstatus|graceful|configtest|help}"
		RETVAL=2
		;;
esac

exit $RETVAL
