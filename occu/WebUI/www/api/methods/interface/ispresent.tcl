##
# BidCosRF.isPresent
# Pr�ft, ob der BidCos-RF-Dienst (rfd) l�uft.
#
# Prameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# R�ckgabewert: [bool]
#   true, falls rfd l�uft, sonst false.
##

if { ![catch { xmlrpc $interface(URL) system.listMethods } ] } then {
  jsonrpc_response true
} else {
  jsonrpc_response false
}
