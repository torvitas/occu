##
# User.getReGaVersion
# Ermittelt die gew�hlte ReGaVersion
#
# Parameter: kein
#
# R�ckgabewert: Gew�hlte ReGaVersion
##

if {[catch {set fp [open "/etc/config/ReGaHssVersion" r]}] == 0} {
  set data [read $fp]
  set version [split $data "\n"]
  close $fp
} else {
  set version "NORMAL"
}

jsonrpc_response [json_toString [lindex $version 0]]