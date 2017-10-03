##
# Program.execute
# F�hrt ein Programm auf der HomeMatic Zentrale aus
#
# Parameter:
#  id: [string] Id des Programms
#
# R�ckgabewert: [bool]
#   true, falls das Programm erfolgreich ausgef�hrt werden konnte.
##

set script {
  var program = dom.GetObject(id);
  Write(program.ProgramExecute());
}

if { "true" == [hmscript $script args] } then {
  jsonrpc_response true
} else {
  jsonrpc_response false
}