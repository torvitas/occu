##
# ReGa.isPresent
# Pr�ft, ob die Logikschicht (ReGa) bereit ist.
#
# Privilegstufe: NONE
# Parameter:     <keine>
#
# R�ckgabewert: [bool]
#   true, falls ReGa l�uft, sonst false.
##

if { "OK" == [hmscript_runInline "Write('OK');"] } then {
  jsonrpc_response true
} else {
  jsonrpc_response false
}