##
# Device.setOperateGroupOnly
# Legt fest, ob das Ger�t bei Verwendung in einer Gruppe als Einzelger�t bedienbar ist.
# 
# Parameter:
#   id: [string] Id des Ger�ts
#   mode: [boolean] true = kann nur in der Gruppe bedient werden - false = kann auch als Einzelger�t bedient werden
#
##

set script {
  var bmode = false;
  if (mode == "true") { bmode = true; }

  var device = dom.GetObject(id);
  if (device)
  {
    device.MetaData("operateGroupOnly", bmode);
  }
}

jsonrpc_response [json_toString [hmscript $script args]]
