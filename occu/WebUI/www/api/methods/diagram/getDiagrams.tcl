##
# Diagram.getDiagrams
# Ermittelt die zur Verf�gung stehenden Diagramme zur Messwerterfassung
#
# Parameter:
#   keine
#
# R�ckgabewert: Liste der zur Verf�gung stehenden Diagramme
##


# funktioniert mit $interface(URL) noch nicht
#checkXmlRpcStatus [catch { set level [xmlrpc $interface(URL) logLevel [list int $level]] }]

# TEST
jsonrpc_response [xmlrpc "172.25.50.140:54321" "listDiagrams" ""]


