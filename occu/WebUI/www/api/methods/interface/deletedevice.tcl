##
# Interface.deleteDevice
# L�scht ein Ger�t aus der Schnittstelle
#
# Parameter:
#   inteface: [string]  Bezeichnung der Schnittstelle
#   address:  [string]  Adresse des logischen Ger�ts
#   flags:    [integer] Flags
#                       0x01: [DELTE_FLAG_RESET]  Setzt das Ger�t in den Werkszustand zur�ck
#                       0x02: [DELETE_FLAG_FORCE] L�scht das Ger�t auch, wenn dieses nicht erreichbar ist
#                       0x04: [DELETE_FLAG_DEFER] L�scht das Ger�t bei der n�chsten Gelegenheit
#
# R�ckgabewert: [boolean]
#   true (Falls das Ger�t nicht gel�scht werden kann, tritt eine Exception auf)
##

set address $args(address)
set flags   $args(flags)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) deleteDevice [list string $address] [list int $flags] }]

jsonrpc_response true