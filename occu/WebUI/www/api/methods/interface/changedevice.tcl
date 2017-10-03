##
# Interface.changeDevice
# L�scht ein Ger�t aus der Schnittstelle
#
# Parameter:
#   interface: [string]  Bezeichnung der Schnittstelle
#   addressNewDevice:  [string]  Adresse des logischen Ger�ts
#   addressOldDevice:  [string]  Adresse des logischen Ger�ts
#
# R�ckgabewert: [boolean]
#   true (Falls der Tausch nicht vollzogen werden kann, tritt eine Exception auf)
##

set addressOld $args(addressOldDevice)
set addressNew $args(addressNewDevice)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) replaceDevice [list string $addressOld] [list string $addressNew] }]

jsonrpc_response true
