##
# User.deleteCertificate
# L�scht ein vorhandenes Zertifikat (server.pem) unter /etc/config
#
# Parameter:
#   keine
#
# R�ckgabewert: true

catch {file delete /etc/config/server.pem}

jsonrpc_response true