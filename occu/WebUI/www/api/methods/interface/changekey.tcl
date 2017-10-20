##
# Interface.changeKey
# �ndert den verwendeten AES-Schl�ssel.
#
# Parameter:
#   interface:  [string] Bezeichnung der Schnittstelle
#   passphrase: [string] 
#
# R�ckgabewert: [boolean]
#   true
##

set passphrase $args(passphrase)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) [list string $passphrase] }]

jsonrpc_response true