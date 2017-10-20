##
# Interface.getLinkPeers
# Liefert die Kommunikationspartner eines logischen Ger�ts
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Ger�ts
#
# R�ckgabewert: [array]
# 
#
##

set address $args(address)

checkXmlRpcStatus [catch {set peers [xmlrpc $interface(URL) getLinkPeers [list string $address]] }]

set result "\["
set first  1

foreach peer $peers {
	if { 1 != $first } then { append result "," } else { set first 0 }
	append result [json_toString $peer]
}

append result "\]"

jsonrpc_response $result
 