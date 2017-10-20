##
# Interface.activateLinkParamset
# Aktiviert ein Link-Parmeterset.
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   address:     [string] Adresse des logischen Ger�ts
#   peerAddress: [string] Adresse des Kommunikationspartners
#   longPress:   [bool]   Aktivert das Parameterset f�r den langen Tastendruck
#
# R�ckgabewert: [bool]
#   true
##

set address     $args(address)
set peerAddress $args(peerAdress)
set longPress   $args(longPress)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) activateLinkParamset [list string $address] [list string $peerAddress] [list bool $longPress] }]

jsonrpc_response true
