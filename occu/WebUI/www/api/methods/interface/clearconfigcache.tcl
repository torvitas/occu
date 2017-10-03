##
# Interface.clearConfigCache
# L�scht alle Konfigurationsdaten, welche die HomeMatic Zentral f�r das Ger�t speichert.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Ger�ts
#
# R�ckgabewert: [boolean]
#   true 
##

set address $args(address)

checkXmlRpcStatus [catch { xmlrpc $interface(URL) clearConfigCache [list string $address] }]

jsonrpc_response true
