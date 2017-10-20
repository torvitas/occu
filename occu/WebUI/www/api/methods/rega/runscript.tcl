##
# ReGa.runScript
# F�hrt ein HomeMatic-Script aus.
#
# Privilegstufe: ADMIN
#
# Parameter:
#   script: [string] HomeMatic Script
#
# R�ckgabewert: [string]
#   Ausgabe des HomeMatic Scripts
##

set script $args(script)

jsonrpc_response [json_toString [hmscript_run script]]
