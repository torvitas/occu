##
# Interface.getlgwstatus.tcl
# Liefert eine Liste der verf�gbaren Schnittstellen
#
# Parameter:
# interface: [string] Bezeichnung der Schnittstelle
#
# R�ckgabewert:
# object containing:
# serial:    [string] Seriennummer
# connected: [bool]  
#
##

checkXmlRpcStatus [catch {array set result [xmlrpc $interface(URL) getLGWStatus] }]

set serial    $result(SERIAL)
set connected $result(CONNECTED)

jsonrpc_response "\{\"serial\":[json_toString $serial],\"connected\":[toJSONBoolean $connected]\}"

