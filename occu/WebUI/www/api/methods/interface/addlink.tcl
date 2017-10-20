##
# Interface.addLink
# Erstellt eine direkte Ger�teverkn�pfung.
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   sender:      [string] Adresse des Senders
#   receiver:    [string] Adresse des Emf�ngers
#   name:        [string] Bezeichnung der Verkn�pfung
#   description: [string] Beschreibung der Verkn�pfung
#
# R�ckgabewert: [boolean]
#   true
##

set sender      $args(sender)
set receiver    $args(receiver)
set name        $args(name)
set description $args(description)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) addLink [list string $sender] [list string $receiver] [list string $name]  [list string $description] }]

jsonrpc_response true