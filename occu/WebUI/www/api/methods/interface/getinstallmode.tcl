##
# Interface.getInstallMode
# Liefert die verbleibende Restzeit zur�ck, f�r die sich die Schnittstelle noch im Anlernmodus befindet.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# R�ckgabewert: [integer]
#   Restzeit des Anlernmodus in Sekunden.
##

checkXmlRpcStatus [catch {set  remainingTime [xmlrpc $interface(URL) getInstallMode] }]

jsonrpc_response $remainingTime