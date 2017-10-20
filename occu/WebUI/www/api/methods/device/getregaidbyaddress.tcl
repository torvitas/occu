##
# Device.getReGaIDByAddress
# Gibt die interne ReGa-ID eines Ger�tes aufgrund der Seriennummer zur�ck
# 
# Parameter:
#   address: [string] SerienNummer des Ger�ts
#
# R�ckgabewer: [string]
# ReGa-ID
#
##

set script {
   string id;
   string devId = "noDeviceFound";
   foreach(id, root.Devices().EnumIDs()) {
     var device = dom.GetObject(id);
     if (device.Address() == address) {
       devId = device.ID();
     }
   }

  Write(devId);
}

jsonrpc_response [json_toString [hmscript $script args]]
