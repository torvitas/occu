##
# Interface.getServiceMessageCount
# Liefert die Anzahl der Servicemeldungen
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# R�ckgabewert: [integer]
#   Anzahl der aktiven Servicemeldungen
##


checkXmlRpcStatus [catch { set serviceMessages [xmlrpc $interface(URL) getServiceMessages] }]

jsonrpc_response [llength $serviceMessages]
