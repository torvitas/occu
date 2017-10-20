##
# CCU.getSSHState
# Pr�ft, ob die Datei /etc/config/sshEnabled vorhanden ist
#
# Parameter: kein
#
# R�ckgabewert: Zustand 0 (deaktiviert) oder 1 (aktiviert)
##

set file "/etc/config/sshEnabled"

jsonrpc_response [file exists $file]