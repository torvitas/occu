##
# Interface.getParamset
# Liefert ein komplettes Paramset.
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   address:     [string] Adresse des logischen Ger�ts
#   paramsetKey: [string] Schl�ssel des Parametersets (z.B. "MASTER" oder "VALUE")
#
# R�ckgabewert: [object]
#   F�r jeden Parameter wird dessen Wert als Zeichenkette zur�ckgegeben.
##

set address     $args(address)
set paramsetKey $args(paramsetKey)

checkXmlRpcStatus [catch { set paramset [xmlrpc $interface(URL) getParamset [list string $address] [list string $paramsetKey]] }]

set result "\{"
set first 1

foreach {name value} $paramset {
  if { 1 != $first } then { append result "," } else { set first 0 }
  append result "[json_toString $name]:[json_toString $value]"
} 

append result "\}"

jsonrpc_response $result
