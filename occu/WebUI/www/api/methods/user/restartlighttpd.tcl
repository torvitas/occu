##
# User.restartLighttpd
# Restartet den Lighttpd Webserver
#
# Parameter:
#   keine
#
# R�ckgabewert: true


exec /etc/init.d/S50lighttpd restart

jsonrpc_response true