##
# Device.getNewDeviceCount
# Gibt die Anzahl der neuen Ger�te zur�ck
#
# Parameter:
#   keine
#
# R�ckgabewert: [string]
#  Anzahl der neuen Ger�te
#
##

set script {
  integer iNewCount = 0;
  object obj = dom.GetObject(ID_DEVICES);
  if ( obj ) {
    string tmp = "";
    foreach( tmp, obj.EnumEnabledIDs() ) {
      object elem = dom.GetObject(tmp);
      if (elem && (elem.ReadyConfig() == false) && (elem.Name() != 'Gateway')) {
        iNewCount = iNewCount + 1;
      }
    }
    Write(iNewCount);
  }
}

jsonrpc_response [json_toString [hmscript $script args]]