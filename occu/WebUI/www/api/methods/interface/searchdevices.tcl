##
# Interface.searchDevices
# Durchsucht den Bus nach neuen Ger�ten.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# R�ckgabewert: [integer]
#   Anzahl der gefundenen Ger�te
##

checkXmlRpcStatus [catch { set count [xmlrpc $interface(URL) searchDevices] }]

jsonrpc_response $count
