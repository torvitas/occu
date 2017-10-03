##
# SafeMode.enter
# Startet die HomeMatic Zentrale im abgesicherten Modus
#
# Parameter:
#   paasword: [string] Passwort f�r den abgesicherten Modus
#
# R�ckgabewert: [bool]
#   true
##

set FLAG_FILE "/etc/config/safemode"

# Flag-Datei erzeugen
set fd [open $FLAG_FILE w]
puts $fd 1
close $fd

# Neustart
rega system.Save()
exec /sbin/reboot

jsonrpc_response true
