##
# BidCoS_RF.isKeySet
# Ermittelt, ob ein Systemsicherheitsschl�ssel
# imt ARM7 gesetzt ist
##

set result false
if { [catch { exec crypttool -v -t 0 }] } then {
  set result true
}

jsonrpc_response $result
