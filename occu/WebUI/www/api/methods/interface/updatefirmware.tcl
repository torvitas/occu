##
# Interface.updateFirmware
# F�hrt das Firmware-Update eines Ger�ts durch. 
#
# Im Gegensatz zur XML-RPC-Version kann hier lediglich ein Ger�t angegeben werden.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   device:     Seriennummer des betreffenden Ger�tes
#
# R�ckgabewert: [boolean]
#   Enth�lt f�r jedes Ger�t die Information, ob das Update erfolgreich war.
##

set device $args(device)

checkXmlRpcStatus [catch {set result [xmlrpc $interface(URL) updateFirmware  [list string $device]] }]

jsonrpc_response [toJSONBoolean $result]