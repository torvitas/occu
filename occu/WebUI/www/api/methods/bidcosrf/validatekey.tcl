##
# BidCoS_RF.validateKey
# Pr�ft, ob der angegebene Sicherheits-Schl�ssel korrekt ist.
#
# Parameter:
#   key: [string] System-Sicherheitsschl�ssel
##

set result true
if { [catch { exec crypttool -v -t 3 -k "$args(key)" }] } then {
  set result false
}

jsonrpc_response $result