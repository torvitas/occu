##
# Session.close
# Schlie�t eine Sitzung
#
# Parameter:
#   _session_id_: [string] Id des Session
#
# R�ckgabewert: [bool]
#   true
##

hmscript {system.ClearSessionID(_session_id_);} args

jsonrpc_response true
