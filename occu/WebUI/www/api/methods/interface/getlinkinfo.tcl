##
# Interface.getLinkInfo
# Liefert den Namen und die Beschreibung einer direkten Ger�teverkn�pfung
#
# Parameter:
#   interface:       [string] Bezeichnung der Schnittstelle
#   senderAddress:   [string] Adresse des Senders
#   receiverAddress: [string] Adresse des Empf�ngers
#
# R�ckgabewert: [object]
#   Folgende Felder sind definiert:
#     name:        [string] Bezeichnug der Verkn�pfung
#     description: [string] Beschreibung der Verkn�pfung
##

set senderAddress   $args(senderAddress)
set receiverAddress $args(receiverAddress)

checkXmlRpcStatus [catch {array set result [xmlrpc $interface(URL) getLinkInfo [list string $senderAddress] [list string $receiverAddress]] }]

set name        $result(NAME)
set description $result(DESCRIPTION)

jsonrpc_response "\{\"name\":[json_toString $name],\"description\":[json_toString $description]\}"
