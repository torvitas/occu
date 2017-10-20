##
# Interface.addDevice
# Lernt ein Ger�t anhand seiner Seriennummer an die HomeMatic Zentrale an.
#
# Parameter:
#   interface:    [string] Bezeichnung der Schnittstelle
#   serialNumber: [string] Seriennummer des Ger�ts
#
# R�ckgabewert: [object]
#   Ger�tebeschreibung des angelernten Ger�ts.
##

set serialNumber $args(serialNumber)

checkXmlRpcStatus [catch {set device [xmlrpc $interface(URL) addDevice [list string $serialNumber]] }]

jsonrpc_response [getDeviceDescription $device]
