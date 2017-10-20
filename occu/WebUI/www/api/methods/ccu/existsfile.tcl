##
# CCU.existsFile
# Pr�ft, ob eine Datei oder ein Verzeichniss vorhanden ist
#
# Parameter:
# file: [string] Dateiname / Ordnername. Alles inclusive Pfad.
##
# R�ckgabewert: 0/1

set result false;

if {[file exists $args(file)] == 1} {
  set result true;
}

jsonrpc_response $result
