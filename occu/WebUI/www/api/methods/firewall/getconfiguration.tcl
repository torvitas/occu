##
# Firewall.getConfiguration
# Liefert die aktuelle Konfiguration der Firewall.
#
# Parameter:
#  <keine>
#
# R�ckgabewert: [object]
#   Folgende Felder sind definiert:
#     services: [array] Enth�lt Informationen zu den einzelnen Services.
#                       Jedes Element ist ein Objekt mit den folgenden Feldern:
#                         id    : [string] Id des Services
#                         ports : [array] TCP-Portnummern des Services
#                                  Jedes Element ist ein int.
#                         access: [string] Zugriffsberechtigung 
#                                 ("full", "restricted", "none")
#     ips     : [array] Liste der IP-Adressen und IP-Addressgruppen f�r den 
#                        eingeschr�nkten Zugriff. Jedes Element ist ein String.
##

source /lib/libfirewall.tcl

Firewall_loadConfiguration

set result "\{"

# Services

set first 1
append result "\"services\": \["
foreach id [array names Firewall_SERVICES] {
  array set service $Firewall_SERVICES($id)
  
  if { 0 == $first } then { append result "," } else { set first 0 }
  
  append result "\{"
  append result "\"id\": [json_toString $id],"
  append result "\"access\": [json_toString $service(ACCESS)],"
  
  set _first 1
  append result "\"ports\": \["
  foreach port $service(PORTS) {
    if { 0 == $_first } then { append result "," } else { set _first 0 }
    append result $port
  }
  append result "\]"
  
  append result "\}"
  
  array_clear service
}
append result "\],"

# IP-Adressen f�r eingeschr�nkten Zugriff

set first 1
append result "\"ips\": \["
foreach ip $Firewall_IPS {
  if { 0 == $first } then { append result "," } else { set first 0 }
  append result [json_toString $ip]
}
append result "\]"

append result "\}"

jsonrpc_response $result
