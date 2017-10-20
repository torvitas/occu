##
# Interface.restoreConfigToDevice
# �bertr�gt die auf der HomeMatic Zentrale gespeicherten Konfigurationsdaten erneut an ein Ger�t.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address  : [string] Adresse des logischen Ger�ts
#
# R�ckgabewert: [boolean]
#   true
##

set address $args(address)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) restoreConfigToDevice [list string $address] }]

jsonrpc_response true
