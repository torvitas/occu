##
# Interface.getDeviceDescription
# Liefert die Beschreibung eines logischen Ger�ts.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Ger�ts
#
# R�ckgabewert: [object]
#   Ger�tebeschreibung.
##

set address $args(address)

checkXmlRpcStatus [catch { set device [xmlrpc $interface(URL) getDeviceDescription [list string $address]] }]

jsonrpc_response [getDeviceDescription $device]
