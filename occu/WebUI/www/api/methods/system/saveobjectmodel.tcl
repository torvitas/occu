##
# system.saveObjectModel
# Speichert das Object Model
#
# Parameter:
#   keine
#
# R�ckgabewert: true
##


set script {
  system.Save();
  Write("true");
}

jsonrpc_response [hmscript $script args]