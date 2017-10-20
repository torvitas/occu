##
# Device.pollComTest
# Pr�ft das Ergebnis eines Funktionstests
#
# Parameter:
#   id: [string] Id des Ger�ts
#   testId: [string] Id des Funktionstests
#
# R�ckgabewert [string/bool]
#   Zeitpunkt, zu dem der Test erfolgreich bestanden wurde oder false
##

set script {
  var device    = dom.GetObject(id);
  var timestamp = testId;

  if (device)
  {
    if (device.LastTestCompletedTime() >= timestamp)
    {
      Write(device.LastTestCompletedTime());
    }
    else
    {
      Write("false");
    }
  }
}

set result [hmscript $script args]

switch -exact -- $result {
  ""      { jsonrpc_error 500 "homematic script error" }
  "false" { jsonrpc_response "false" }
  default { jsonrpc_response [json_toString $result] }
}
 