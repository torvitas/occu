 ##
 # Program.deleteProgramByName
 # L�scht ein Programm mit bestimmten Namen.
 #
 # Parameter:
 #   name: [string] Name des Programms
 #
 # R�ckgabewert: true
 ##


 set script {
   object oPrograms = dom.GetObject( ID_PROGRAMS );
   object prog = dom.GetObject(name);

   oPrograms.Remove(prog.ID());

   Write("true");
 }

 jsonrpc_response [hmscript $script args]