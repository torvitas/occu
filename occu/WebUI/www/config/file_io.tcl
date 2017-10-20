#!/bin/tclsh

#*******************************************************************************
# file_io.tcl
# Einfache Datei-Operationen.
#
# Autor      : F. Werner
# Erstellt am: 15.04.2008
#
# Script History:
# 15.04.2008, F. Werner: Initial Release
#*******************************************************************************

################################################################################
# Funktionen und Prozeduren                                                    #
################################################################################

#*******************************************************************************
# saveToFile
# Speichert den Inhalt einer Variablen in eine Datei.
#
# Parameter:
#   file_name: Pfad und Name der Datei
#   content  : Name der Variablen, deren Inhalt gespeichert wird
#******************************************************************************* 
proc saveToFile { file_name content } {
  upvar $content file_content
  
  if { ![catch { open $file_name w } fd] } then {
    puts $fd $file_content
    close $fd
  }
}

#*******************************************************************************
# loadFromFile
# Gibt den Inhalt einer Variablen zur�ck.
#
# Falls die Datei nicht existiert oder aus anderen Gr�nden nicht ge�ffnet 
# werden kann, wird die leere Zeichenkette ("") zur�ckgegeben.
#
# Parameter:
#   file_name: Pfad und Name der Datei
#
# R�ckgabewert:
#   Inhalt der Datei oder "", falls die Datei nicht ge�ffnet werden konnte.
#*******************************************************************************
proc loadFromFile { file_name } {
  set content ""
  set fd -1

  catch { set fd [open $file_name r] }
  if { 0 <= $fd } then {
    set content [read $fd]
    close $fd
  }
  return $content
}

#*******************************************************************************
# testFile
# Ermittelt, ob eine Datei existiert.
#
# Parameter:
#   file_name: Pfad und Name der Datei
#
# R�ckgabewert:
#   1, falls die Datei existiert
#   0, falls die Datei nicht ge�ffnet werden konnte
#*******************************************************************************
proc testFile { file_name } {
  set fd -1
  
  catch { set fd [open $file_name r] }
  if { 0 <= $fd } then {
    close $fd
    return 1
  } else {
    return 0
  }
}

#*******************************************************************************
# putFile
# Gibt den Inhalt einer Datei auf STDOUT aus.
#
# Die Datei wird St�ckweise gelesen, um bei gro�en Dateien den 
# Speicherplatzbedarf zu minimieren.
#
# Parameter:
#   file_name: Pfad und Name der Datei
#*******************************************************************************
proc putFile { file_name } {
  set BUFSIZE 1024
  
  set fd -1
  catch { set fd [open $file_name r] }
  if { 0 <= $fd } {
    while { ![eof $fd] } {
      puts -nonewline [read $fd $BUFSIZE] 
    }
   close $fd
  }
}
