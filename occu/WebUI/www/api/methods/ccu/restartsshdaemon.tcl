##
# CCU.restartSSHDaemon
# Restartet den SSH-Daemon
#
# Parameter: kein
#
# R�ckgabewert: kein
##

catch {exec /etc/init.d/S50sshd restart}