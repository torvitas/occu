##
# Interface.setTempKey
# �ndert den von der HomeMatic Zentrale verwendeten tempor�ren AES-Schl�ssel.
#
# Paramter:
#   interface:  [string] Bezeichnung der Schnittstelle
#   passphrase: [string]
#
# R�ckgabewert: [boolean]
#   true
##

set passphrase $args(passphrase)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) setTempKey [list string passphrase] }]

jsonrpc_response true
