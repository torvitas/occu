##
# Device.setName
# Legt den Namen eines Ger�ts fest.
# 
# Parameter:
#   id: [string] Id des Ger�ts
#   name: [string] Neuer Name des Ger�ts
#
# R�ckgabewer: [string]
#  Neuer Name des Ger�ts.*
#
#  *: Ger�tenamen m�ssen immer eindeutig sein. Falls der neue Ger�tename dies nicht
#     ist, wird er entsprechend angepasst.
##

set script {
  var device = dom.GetObject(id);
  if (device)
  {
    device.Name(name);
    Write(device.Name());
  }
}

jsonrpc_response [json_toString [hmscript $script args]]
