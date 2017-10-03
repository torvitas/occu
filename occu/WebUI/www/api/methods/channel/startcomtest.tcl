##
# Channel.startComTest
# Startet den Funktionstest f�r ein Ger�t
#
# Parameter:
#   id: [string] Id des Kanals
#
# R�ckgabewert: [string]
#   Id des Funktionstests
##

set script {
  var channel = dom.GetObject(id);
  if (channel)
  {
    Write(system.Date("%Y-%m-%d %H:%M:%S"));
    channel.ChnStartComTest();
  }
}

set result [hmscript $script args]

if { "" != $result } then {
  jsonrpc_response [json_toString $result]
} else {
  jsonrpc_error 500 "homematic script error"
}
