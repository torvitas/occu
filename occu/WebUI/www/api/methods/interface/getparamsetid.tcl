##
# Interface.getParamsetId
# Liefert die Id eines Parametersets.
#
# Parameter:
#   interface:    [string] Bezeichnug der Schnittstelle
#   address:      [string] Adresse des logischen Ger�ts
#   paramsetType: [string] Typ des Parametersets (MASTER oder LINK)
#
# R�ckgabewert: [string]
#   Id des Parametersets
##

set addres $args(address)
set paramsetType $args(paramsetType)

checkXmlRpcStatus [catch { set paramsetId [xmlrpc $interface(URL) getParamsetId [list string $address] [list string $paramsetType]] }]

jsonrpc_response [json_toString $paramsetId]
