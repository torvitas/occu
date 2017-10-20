#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) once.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) cgi.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) session.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/ic_common.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) common.tcl]
loadOnce tclrpc.so

#Datenbank der Ger�tebeschreibungen f�rs WebUI
sourceOnce [file join $env(DOCUMENT_ROOT) config/devdescr/DEVDB.tcl]

#ISE-Daten
array set ise_CHANNELNAMES ""
ise_getChannelNames ise_CHANNELNAMES

array set ise_FUNCTIONS ""
ise_getChannelFunctions ise_FUNCTIONS

array set ise_ROOMS ""
ise_getChannelRooms ise_ROOMS

#=====

proc put_page {} {

  global iface_url HTMLTITLE sidname sid
  global step dev_descr_sender dev_descr_receiver iface sender_address receiver_address name description group_name group_description sender_group

#cgi_debug -on

  puts "<div id=\"ic_selchannel\">"
      
    puts "<div id=\"id_body\">"
      
      puts "<div id=\"id_subOffsetDivPopup\" class=\"subOffsetDivPopup CLASS21900\" >"
      
      puts "<div id=\"body_wrapper\">"

      if {$step > 1} then {
        put_PreviousStep
      }

      set realchannels    0
      set virtualchannels 0
        
      if {$step < 3} then {
        # wegen dem IE muss das Style overflow:visible eingestellt sein
        puts "<div id=\"ChnTblContentDiv\" class=\"CLASS21908\" style=\"overflow:visible\" >"
        puts "<table border=\"1\" id=\"ChnListTbl\" class=\"ChnListTbl\" width=\"100%\" cellspacing=\"0\">"
        put_colgroup
        put_tableheader

        put_tablebody realchannels virtualchannels
        puts "</table>"
        puts "</div>"

        put_js_SizeTable
        #put_js_sortby 0
        
        #if {$realchannels == 0 && $virtualchannels > 0} then {
        # Funktioniert an dieser Stelle noch nicht, da der Button noch gar nicht vorhanden ist.
        #  put_js_ShowVirtualChannels
        #}
      }
      
      #body_wrapper
      puts "</div>"

       puts "<div id=\"global_values\" style=\"display: none; visibility: hidden;\">"
      puts "<form action=\"#\">"
      puts "<input id=\"global_sid\" type=\"hidden\" name=\"$sidname\"          value=\"$sid\"/>"
      puts "<input id=\"global_iface\" type=\"hidden\" name=\"iface\"             value=\"$iface\"/>"
      puts "<input id=\"global_sender_address\" type=\"hidden\" name=\"sender_address\"    value=\"$sender_address\"/>"
      puts "<input id=\"global_sender_group\" type=\"hidden\" name=\"sender_group\"    value=\"$sender_group\"/>"
      puts "<input id=\"global_receiver_address\" type=\"hidden\" name=\"receiver_address\"  value=\"$receiver_address\"/>"
      puts "<input id=\"global_realchannels\"    type=\"hidden\" name=\"realchannels\"          value=\"$realchannels\"/>"
      puts "<input id=\"global_virtualchannels\" type=\"hidden\" name=\"virtualchannels\"          value=\"$virtualchannels\"/>"
      puts "</form>"
      puts "</div>"

      #subOffsetDivPopup
      puts "</div>"

      puts "<script type=\"text/javascript\">"
      #puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>Programme &amp; Verkn&uuml;pfungen</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>Direkte Verkn&uuml;pfungen</span> &gt; Neue Verkn&uuml;pfung anlegen - Schritt $step/3\");"
      puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>\"+translateKey('menuProgramsLinksPage')+\"</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>\"+translateKey('submenuDirectLinks')+\"</span> &gt; \"+translateKey('lblPathCreateNewLink')+\" - \"+translateKey('lblPathStepX')+\" $step/3\");"

      puts "  var s = \"\";"
      puts "  s += \"<table cellspacing='8'>\";"
      puts "  s += \"<tr>\";"
      if {$step < 3} then {
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.enter(LinkListPage);'>\${btnCancel}</div></td>\";"
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton CLASS21901' onclick='ResetFilterAndTable();'>\${footerBtnResetFilter}</div></td>\";"

        if {$virtualchannels > 0} then {
          puts "  s += \"<td align='center' valign='middle'><div class='FooterButton CLASS21909' onclick='ToggleVirtualKeys();' id='ToggleVirtualKeys'>\${footerBtnVirtualChannelsShow}</div></td>\";"
        }
      } else {
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.enter(LinkListPage);'>\${btnCancel}</div></td>\";"
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton CLASS21901' onclick='CollectData_AddLink(1);'>\${footerBtnCreateEdit}</div></td>\";"
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='CollectData_AddLink(0);'>\${footerBtnCreate}</div></td>\";"
      }
      puts "  s += \"</tr>\";"
      puts "  s += \"</table>\";"
      puts "  setFooter(s);"
      
      # Tabelle sortieren
      if {$step < 3} then  {
        puts "  SORTED_COL = -1;"
        puts "  Sort('ChnListTbl', 0);"
      }
      puts "</script>"
      
    #id_body
    puts "</div>"
      
  #ic_selchannel
  puts "</div>"
}

proc put_colgroup {} {
  puts "<colgroup>"
#Name
  puts "  <col width=\"21%\" />"
#Typenbezeichnung
  puts "  <col width=\"10%\" />"
#Bild
  puts "  <col width=\"4%\" />"
#Bezeichnung
  puts "  <col width=\"18%\" />"
#Seriennummer
  puts "  <col width=\"10%\" />"
#Kategorie
  puts "  <col width=\"5%\" />"
#�bertragungsmodus
  puts "  <col width=\"5%\" />"
#Gewerk
  puts "  <col width=\"10%\" />"
#Raum
  puts "  <col width=\"10%\" />"
#Aktion
  puts "  <col width=\"7%\" />"
  puts "</colgroup>"
}

proc put_NaviButtons {} {

  global step

#cgi_debug -on

  puts "<div class=\"popupControls\">"
  puts "<table class=\"CLASS21902\">"
  puts "<tbody>"
  
  puts "<TR>"

  if {$step < 3} then {
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"CloseSelChannel();\" ><div>\${btnCancel}</div></td>"
    puts "<TD class=\"ActiveButton CLASS21903\" onclick=\"ResetFilterAndTable();\"><div>\${footerBtnResetFilter}</div></TD>"
    puts "<TD class=\"ActiveButton CLASS21903\" onclick=\"ToggleVirtualKeys();\"><div id=\"ToggleVirtualKeys\">\${footerBtnVirtualChannelsShow}</div></TD>"
    puts "<td class=\"CLASS21911\">&nbsp;</td>"
  } else {
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"CloseSelChannel();\"><div>\${btnCancel}</div></td>"
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"AddLink(\$F('global_iface'), \$F('global_sender_address'), \$F('global_sender_group'), \$F('global_receiver_address'), \$F('input_name'), \$F('input_description'), \$F('input_group_name'), \$F('input_group_description'), 'IC_SETPROFILES'    );\"><div>\${footerBtnCreateEdit}</div></td>"
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"AddLink(\$F('global_iface'), \$F('global_sender_address'), \$F('global_sender_group'), \$F('global_receiver_address'), \$F('input_name'), \$F('input_description'), \$F('input_group_name'), \$F('input_group_description'), 'IC_LINKPEERLIST');\"><div>\${footerBtnCreate}</div></td>"
    puts "<td class=\"CLASS21911\">&nbsp;</td>"
  }

  puts "</TR>"
  puts "</tbody>"

  puts "</table>"
  puts "</div>"
}

proc test_space {testObject} {
  
# wenn &nbsp; vorhanden, dann 1, sonst 0

  if {$testObject == "&nbsp;"} {
    return 1
    } else {
    return 0
    }
}

# This can be used to extend the regular link description
proc getExtendedLinkDescription {channelType channel} {
  set result ""
  if {$channelType == "SWITCH_SENSOR"} {
    if {$channel == 1} {
      set result "/ \${chType_SWITCH_SENSOR_Int}"
    } elseif {$channel == 2} {
     set result "/ \${chType_SWITCH_SENSOR_Ext}"
    }
  }
  return $result
}

proc put_PreviousStep {} {

#cgi_debug -on
  global ise_CHANNELNAMES step receiver_links
  global dev_descr_sender dev_descr_receiver iface sender_address receiver_address name description group_name group_description sender_group dev_descr_sender_group

#cgi_debug -on
  
  array set SENTRY ""
  set SENTRY(RECEIVERADDR) "&nbsp;"
  set SENTRY(RECEIVERNAME) "&nbsp;"
  set SENTRY(RECEIVERNAME_DISPLAY) "&nbsp;"
  set SENTRY(SENDERADDR)   "&nbsp;"
  set SENTRY(SENDERNAME)   "&nbsp;"
  set SENTRY(SENDERNAME_DISPLAY) "&nbsp;"
  set SENTRY(SENDERGROUPADDR)   "&nbsp;"
  set SENTRY(SENDERGROUPNAME)   "&nbsp;"
  set SENTRY(SENDERGROUPNAME_DISPLAY) "&nbsp;"
  set SENTRY(LINKNAME)     "&nbsp;"
  set SENTRY(LINKDESC)     "&nbsp;"
  set SENTRY(WARNINGS)     ""


  if {$receiver_address != ""} then {
    set SENTRY(RECEIVERADDR) $receiver_address
    if { [catch { set SENTRY(RECEIVERNAME) $ise_CHANNELNAMES($iface;$receiver_address)} ] } then {
         set SENTRY(RECEIVERNAME) "$iface"
         append SENTRY(RECEIVERNAME) ".$receiver_address"
    }

    if {[test_space $SENTRY(RECEIVERNAME)] == 1} {
    set SENTRY(RECEIVERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_receiver(PARENT_TYPE)', 250, $dev_descr_receiver(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">$SENTRY(RECEIVERNAME)</div>"
    } else {
    set SENTRY(RECEIVERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_receiver(PARENT_TYPE)', 250, $dev_descr_receiver(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $SENTRY(RECEIVERNAME)]</div>"
  }
    
  }

    
  if {$sender_address != ""} then {
    set SENTRY(SENDERADDR) $sender_address
    if { [catch { set SENTRY(SENDERNAME) $ise_CHANNELNAMES($iface;$sender_address)} ] } then {
         set SENTRY(SENDERNAME) "$iface"
         append SENTRY(SENDERNAME) ".$sender_address"
    }
    
    if {[test_space $SENTRY(SENDERNAME)] == 1 } {
    set SENTRY(SENDERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender(PARENT_TYPE)', 250, $dev_descr_sender(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">$SENTRY(SENDERNAME)</div>"
    } else {
    set SENTRY(SENDERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender(PARENT_TYPE)', 250, $dev_descr_sender(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $SENTRY(SENDERNAME)]</div>"
  }
  }

  if {$sender_group != ""} then {
    set SENTRY(SENDERGROUPADDR) $sender_group
    if { [catch { set SENTRY(SENDERGROUPNAME) $ise_CHANNELNAMES($iface;$sender_group)} ] } then {
         set SENTRY(SENDERGROUPNAME) "$iface"
         append SENTRY(SENDERGROUPNAME) ".$sender_group"
    }
    
    if {[test_space $SENTRY(SENDERGROUPNAME)] == 1} {
    set SENTRY(SENDERGROUPNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender_group(PARENT_TYPE)', 250, $dev_descr_sender_group(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">$SENTRY(SENDERGROUPNAME)</div>"
    } else {
    set SENTRY(SENDERGROUPNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender_group(PARENT_TYPE)', 250, $dev_descr_sender_group(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $SENTRY(SENDERGROUPNAME)]</div>"
  }

    }

  if {$step < 3} then {
    set SENTRY(LINKNAME)      "<input id=\"input_name\"              name=\"name\"              type=\"hidden\" value=\"\"/>&nbsp;"
    set SENTRY(LINKDESC)      "<input id=\"input_description\"       name=\"description\"       type=\"hidden\" value=\"\"/>&nbsp;"
    set SENTRY(LINKGROUPNAME) "<input id=\"input_group_name\"        name=\"group_name\"        type=\"hidden\" value=\"\"/>&nbsp;"
    set SENTRY(LINKGROUPDESC) "<input id=\"input_group_description\" name=\"group_description\" type=\"hidden\" value=\"\"/>&nbsp;"
  } else {
    if {$name       == ""                       } then {set name       "$SENTRY(SENDERNAME) \${lblLinkNameWith} $SENTRY(RECEIVERNAME)"}
    if {$group_name == "" && $sender_group != ""} then {set group_name "$SENTRY(SENDERGROUPNAME) \${lblLinkNameWith} $SENTRY(RECEIVERNAME)"}

    set description1 ""
    set description2 ""
    set extSenderDescr ""
    set extReceiverDescr ""

    catch {set extReceiverDescr [getExtendedLinkDescription $dev_descr_receiver(TYPE) $dev_descr_receiver(INDEX)]}

    catch {set description1 "\${lblStandardLink} $dev_descr_sender(TYPE) $extSenderDescr - $dev_descr_receiver(TYPE) $extReceiverDescr"}
    catch {set description2 "\${lblStandardLink} $dev_descr_sender(TYPE) $extSenderDescr - $dev_descr_receiver(TYPE) $extReceiverDescr"}

    set SENTRY(LINKNAME)      "<input id=\"input_name\"              name=\"name\"              type=\"text\" value=\"$name\"/>"
    set SENTRY(LINKDESC)      "<input id=\"input_description\"       name=\"description\"  class=\"stringtable_input\"     type=\"text\" value=\"$description1\"/>"
    # puts "<script type=\"text/javascript\">st_setStringTableValues();</script>"
    set SENTRY(LINKGROUPNAME) "<input id=\"input_group_name\"        name=\"group_name\"        type=\"text\" value=\"$group_name\"/>"
    set SENTRY(LINKGROUPDESC) "<input id=\"input_group_description\" name=\"group_description\" class=\"stringtable_input\"  type=\"text\" value=\"$description2\"/>"
    puts "<script type=\"text/javascript\">st_setStringTableValues();</script>"
    puts "<script type=\"text/javascript\">"
      puts "var descrElem = jQuery(\"#input_description\");"
      puts "var groupDescrElem = jQuery(\"#input_group_description\");"
      puts "jQuery(\"#input_name\").attr(\"value\",translateString(\"$name\"));"
      puts "jQuery(\"#input_group_name\").attr(\"value\",translateString(\"$group_name\"));"
      puts "descrElem.attr(\"value\",translateString(descrElem.val()));"
      puts "groupDescrElem.attr(\"value\",translateString(groupDescrElem.val()));"
    puts "</script>"

    #Warnung vor dem �berschreiben von Verkn�pfungen----------------------------------
    set i 0
    
    if { [LinkExists receiver_links $sender_address $receiver_address ] == 1 } then {
      append SENTRY(LINKNAME) "<img src=\"/ise/img/dialog-warning.png\" alt=\"Warnung\" title=\"Verkn&uuml;pfung gibt es schon\"/>"
      #append SENTRY(LINKNAME) "Achtung, die Verkn&uuml;pfung existiert bereits und wird &uuml;berschrieben."
      append SENTRY(LINKNAME) "\${dialogCreateLinkHintLinkExists}"
      incr i
    }

    if { [LinkExists receiver_links $sender_group $receiver_address ] == 1 } then {
      append SENTRY(LINKGROUPNAME) "<img src=\"/ise/img/dialog-warning.png\" alt=\"Warnung\" title=\"Verkn&uuml;pfung gibt es schon\"/>"
      #append SENTRY(LINKGROUPNAME) "Achtung, die Verkn&uuml;pfung existiert bereits und wird &uuml;berschrieben."
      append SENTRY(LINKNAME) "\${dialogCreateLinkHintLinkExists}"
      incr i
    }

    if {$i > 0} then {
      #append SENTRY(WARNINGS) "<script type=\"text/javascript\">ShowWarningMsg(\"Sie sind dabei $i bestehende Verkn�pfungen zu �berschreiben.\");</script>"
      append SENTRY(WARNINGS) "<script type=\"text/javascript\">ShowWarningMsg(translateKey(\"dialogCreateLinkMsgLinkExistsA\") +\"$i\"+ translateKey(\"dialogCreateLinkMsgLinkExistsB\"));</script>"
    }
    #---------------------------------------------------------------------------------
  }

  puts "<div id=\"previous_step_wrapper\" >"
  
  puts "<table border=\"1\" id=\"createLinkStep1\" cellspacing=\"0\" class=\"j_translate\" >"

  puts "<colgroup>"
  puts "  <col width=\"10%\" />"
  puts "  <col width=\"10%\" />"
  puts "  <col width=\"25%\" />"
  puts "  <col width=\"25%\" />"
  puts "  <col width=\"10%\" />"
  puts "  <col width=\"10%\" />"
  puts "</colgroup>"
  
  puts "<THEAD>"

  puts "<TR>"
  puts "<TD COLSPAN=\"2\" align=\"center\">\${thSender}</TD>"
  puts "<TD COLSPAN=\"2\" align=\"center\" class=\"BlueHeader\">\${thLink}</TD>"
  puts "<TD COLSPAN=\"2\" align=\"center\">\${thReceiver}</TD>"
  puts "</TR>"
  puts "<TR class=\"CLASS21913\">"
  puts "<TD align=\"center\">\${thName}</TD>"
  puts "<TD align=\"center\">\${thSerialNumber}</TD>"
  puts "<TD align=\"center\" class=\"BlueHeader\">\${thName}</TD>"
  puts "<TD align=\"center\">\${thDescription}</TD>"
  puts "<TD align=\"center\">\${thName}</TD>"
  puts "<TD align=\"center\">\${thSerialNumber}</TD>"
  puts "</TR>"
  
  puts "</THEAD>"

  puts "<TBODY>"
      
  puts "<tr>"
  puts "<td align=\"center\">$SENTRY(SENDERNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(SENDERADDR)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKNAME)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKDESC)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERADDR)</td>"
  puts "</tr>"

  puts "<tr [expr {$sender_group != ""?"":"style=\"display:none;\""}]>"
  puts "<td align=\"center\">$SENTRY(SENDERGROUPNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(SENDERGROUPADDR)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKGROUPNAME)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKGROUPDESC)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERADDR)</td>"
  puts "</tr>"

  puts "</TBODY>"

  puts "</table>"

  puts "<script type=\"\">translatePage(\"#createLinkStep1\")</script>"

  puts $SENTRY(WARNINGS)
  
  puts "</div>"
}

proc put_js_ShowVirtualChannels {} {
  set msg [cgi_quote_html "Es stehen nur virtuelle Kan�le zur Verf�gung."]
  puts "<script type=\"text/javascript\">alert('$msg'.unescapeHTML()); ToggleVirtualKeys();</script>"
}

proc put_js_sortby {colNr} {
  puts "<script type=\"text/javascript\">Sort('ChnListTbl', $colNr);</script>"
}

proc put_js_SizeTable {} {
  puts "<script type=\"text/javascript\">SizeTable();</script>"
}

proc put_tableheader {} {

  global step

  puts "<THEAD id=\"chnListHead\" class=\"j_translate\" >"
  
  puts "<TR>"
  puts "<TD class=\"chnListTbl_Caption\" align=\"left\" colspan=\"10\">$step. \${thLinkPeer}</TD>"
  puts "</TR>"
  
  puts "<TR id=\"tr_caption_colnames\" align=\"center\">"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 0);\">\${thName}<img src=\"/ise/img/arrow_up.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 1);\">\${thTypeDescriptor}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"nosort\">\${thPicture}</TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 3);\">\${thDescriptor}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 4);\">\${thSerialNumber}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 5);\">\${thCategorie}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 6);\">\${thTransmitMode}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 7);\">\${thFunc}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 8);\">\${thRoom}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"nosort\">\${thAction}</TD>"
  puts "</TR>"

  puts "<script type=\"text/javascript\">translatePage(\"#chnListHead\")</script>"

  puts "<TR align=\"center\">"

  #Name
  put_FilterControl TEXTINPUT  0

  #Typenbezeichnung
  put_FilterControl TEXTINPUT  1 

  #Bild
  put_FilterControl NONE       2
  #puts "<td class=\"unfiltered CLASS21914\" >&nbsp;</td>"

  #Bezeichnung
  put_FilterControl TEXTINPUT  3

  #Seriennummer / Adresse
  put_FilterControl TEXTINPUT  4
  
  #Kategorie
  put_FilterControl CHECKBOXES 5 [list "\${lblReceiver}" "\${lblSender}"]

  #�bertragungsmodus
  put_FilterControl CHECKBOXES 6 [list "\${lblStandard}" "\${lblSecured}"]

  #Gewerk
  set ise_FUNCTIONS ""
  ise_getFunctions ise_FUNCTIONS
  put_FilterControl CHECKBOXES 7 $ise_FUNCTIONS
  
  #Raum
  set ise_ROOMS ""
  ise_getRooms ise_ROOMS
  put_FilterControl CHECKBOXES 8 $ise_ROOMS
  
  #Aktion
  put_FilterControl NONE       9
  #puts "<td class=\"chkCell CLASS21914\" >&nbsp;</td>"

  puts "</TR>"

  puts "</THEAD>"

  # This makes the filter running
  puts "<script type=\"text/javascript\">"
    puts "jQuery(\"#chnListHead input:checkbox\").each(function()\{"
      puts "var elem = jQuery(this);"
      puts "var elemVal = elem.val();"
      puts "var transValue = translateKey(elemVal);"
      puts "if (elemVal != transValue) \{"
        puts "elem.val(transValue);"
      puts "\} else \{"
        puts "elem.val(translateString(elem.val()));"
      puts "\}"
    puts "\});"
  puts "</script>"



}

#control: NONE|TEXTINPUT|CHECKBOXES|RADIOBOXES
proc put_FilterControl {control colNr {entrylist ""} } {

  #cgi_debug -on

  if {$control == "NONE"} then {
    puts "<td id=\"id_filtertd_$colNr\" class=\"nofilter\">"
    puts "<div class=\"spacer\">&nbsp;</div>"
    puts "<div class=\"CLASS21915\">&nbsp;"
  } else {
    puts "<td id=\"id_filtertd_$colNr\" class=\"unfiltered\">"
    puts "<div onclick=\"ShowFilterControl($colNr);\">Filter</div>"
    puts "<div class=\"CLASS21915\">"
  }
  
  puts "<div class=\"filterBox\" id=\"id_filtercontrol_$colNr\" style=\"display: none; visibility: hidden;\">"

  if {$control == "TEXTINPUT"} then {
    
    puts "<input type=\"text\" id=\"inputTextFilter_$colNr\" name=\"input_filtercontrol_$colNr\" onkeypress=\"filterCheckEnterEsc(event.keyCode, $colNr);\" /><br/>"
    
  } elseif {$control == "CHECKBOXES"} then {
    
    if {[llength $entrylist] > 0} then {
      
      puts "<table>"
      foreach entry $entrylist {
        puts "<tr>"
        puts "<td>[cgi_quote_html $entry]</td>"
        puts "<td><input type=\"checkbox\" name=\"input_filtercontrol_$colNr\" value=\"[cgi_quote_html $entry]\"></td>"
        puts "</tr>"
      }
      puts "</table>"
    } else {
      puts "Keine Eintr&auml;ge vorhanden."
    }

  } elseif {$control == "RADIOBOXES"} then {
    
    foreach entry $entrylist {
      puts "[cgi_quote_html $entry] <input type=\"radio\" name=\"input_filtercontrol_$colNr\" value=\"[cgi_quote_html $entry]\"><br/>"
    }
    
    puts "Keine Auswahl<input type=\"radio\" name=\"input_filtercontrol_$colNr\" value=\"\"><br/>"
  }
  
  puts "<div class=\"CLASS21916\">"
  puts "  <span onclick=\"filterTable();\" class=\"CLASS21917\">\${btnOk}</span>"
  puts "</div>"
  
  puts "</div>"
  
  puts "</div>"
  puts "</td>"
}

proc put_tablefooter {} {

  #cgi_debug -on

  puts "<TFOOT id=\"chnListFoot\">"
  
  puts "<TR>"
  puts "<td colspan=\"10\">"
  puts "<table id=\"chnListFoot_NaviTbl\">"
  puts "<tr>"
  puts "<TD class=\"CLASS21903\"><div class=\"CLASS21904\" onclick=\"ResetFilterAndTable();\">\${footerBtnResetFilter}</div></TD>"
  puts "<TD class=\"CLASS21903\"><div class=\"CLASS21904\" id=\"ToggleVirtualKeys\" onclick=\"ToggleVirtualKeys();\">\${footerBtnVirtualChannelsShow}</div></TD>"
  puts "<TD class=\"CLASS21905\">&nbsp;</TD>"
  puts "</tr>"
  puts "</table>"
  puts "</td>"
  puts "</TR>"

  puts "</TFOOT>"
}

#proc trim_dev_descr {p_dev_descr} {
#
  #upvar $p_dev_descr dev_descr
  #foreach d [array names dev_descr] {
    #trimright dev_descr($d)
  #}
#}
#
#proc trimright {p_var} {
  #upvar $p_var var
  #set var [string trimright $var " "]
#}

proc LinkExists {p_LINKLIST sender_address receiver_address} {

  upvar $p_LINKLIST linklist
  set match 0
  
  foreach _link $linklist {

    array set link $_link

    if {$link(SENDER) == $sender_address && $link(RECEIVER) == $receiver_address} then {
      set match 1
      break
    }
  }

  return $match
}

proc showHmIPChannel {devType direction address chType} {
  # direction 1 = sender, 2 = receiver

  set devType [string toupper $devType]
  set ch [lindex [split $address ":"] 1]

  # The internal device button of some devices aren`t allowed for external links
  # The next code filters e. g. a HMIP-PSM AND a HMIP-PSM-UK or a HmIP-PCBS AND a HmIP-PCBS-BAT
  if {(
    ($devType == "HMIP-PS")
    || ([string equal -nocase -length 8 $devType "HMIP-PSM"] == 1)
    || ([string equal -nocase -length 8 $devType "HMIP-PDT"] == 1)
    || ([string equal -nocase -length 9 $devType "HMIP-PCBS"] == 1)
    ) && $direction == 1} { #; channel is sender
    # don't show the channel
    return 0
  }

  if {$devType == "HMIP-WTH" && ($chType == "HEATING_CLIMATECONTROL_SWITCH_TRANSMITTER")} {
   # show the channel
    return 1
  }

  # The weekly program is not yet in use, so we can't use it for links
  if {$chType == "WEEK_PROGRAM"} {
   # don't show the channel
    return 0
  }

  # Hide certain channels of HmIP devices when the expert mode is not activated.
  if {! [session_is_expert]} {
    # The HmIP-PSM is available as HmIP-PSM-IT/CH/UK etc.
    if {(($devType == "HMIP-PS") || ([string equal -nocase -length 8 $devType "hmip-psm"] == 1) || ($devType == "HMIP-PCBS")) && ($chType == "SWITCH_VIRTUAL_RECEIVER")} {
     if {$ch >= 4} {return 0}
    }

    if {($devType == "HMIP-BDT") && ($chType == "DIMMER_VIRTUAL_RECEIVER")} {
     if {$ch >= 5} {return 0}
    }

    if {(($devType == "HMIP-PDT") || ($devType == "HMIP-PDT-UK")) && ($chType == "DIMMER_VIRTUAL_RECEIVER")} {
     if {$ch >= 4} {return 0}
    }

    if {($devType == "HMIP-FDT") && ($chType == "DIMMER_VIRTUAL_RECEIVER")} {
     if {$ch >= 3} {return 0}
    }

    if {($devType == "HMIP-BSM") && ($chType == "SWITCH_VIRTUAL_RECEIVER")} {
     if {$ch >= 5} {return 0}
    }

    if {($devType == "HMIP-FSM" || $devType == "HMIP-FSM16") && ($chType == "SWITCH_VIRTUAL_RECEIVER")} {
     if {$ch >= 3} {return 0}
    }

    if {($devType == "HMIP-MIOB") && ($chType == "SWITCH_VIRTUAL_RECEIVER")} {
      if {$ch != 3 && $ch != 7} {return 0}
    }

    if {($devType == "HMIP-BBL" || $devType == "HMIP-FBL") && ($chType == "BLIND_VIRTUAL_RECEIVER")} {
     if {$ch >= 5} {return 0}
    }

    if {($devType == "HMIP-BROLL" || $devType == "HMIP-FROLL") && ($chType == "SHUTTER_VIRTUAL_RECEIVER")} {
     if {$ch >= 5} {return 0}
    }

    if {($devType == "HMIP-MOD-OC8") && ($chType == "SWITCH_VIRTUAL_RECEIVER")} {
      if {
            ($ch == 11) || ($ch == 12) || ($ch == 15) || ($ch == 16) || ($ch == 19) || ($ch == 20)
         || ($ch == 23) || ($ch == 24) || ($ch == 27) || ($ch == 28) || ($ch == 31) || ($ch == 32)
         || ($ch == 35) || ($ch == 36) || ($ch == 39) || ($ch == 40)
      } {
        return 0
      }
    }
  }
  # show the channel
  return 1
}

#return: Anzahl der reellen Kan�le
proc put_tablebody {p_realchannels p_virtualchannels} {

  global DEV_DESCRIPTION
  global iface_url ise_CHANNELNAMES ise_FUNCTIONS ise_ROOMS
  global step dev_descr_sender dev_descr_receiver iface sender_address receiver_address sender_group

#cgi_debug -on

  upvar $p_realchannels    realchannels
  upvar $p_virtualchannels virtualchannels

  #Step 2=====
   set ROLENAME2CHECK ""
  set dev_roles ""

  if {$step == 2} then {
    if {$receiver_address != ""} then {
      set ROLENAME2CHECK LINK_SOURCE_ROLES
      set dev_roles $dev_descr_receiver(LINK_TARGET_ROLES)
    } else {
      set ROLENAME2CHECK LINK_TARGET_ROLES
      set dev_roles $dev_descr_sender(LINK_SOURCE_ROLES)
    }
  }
  #==========

  set rowcount 0
  set virtualcount 0

  puts "<TBODY id=\"chnListBody\" style=\"display:none\">"

  foreach iface_loop [array names iface_url] {

    #Liste nur Ger�te desselben Interfaces auf (iface = in der URL �bergebenes Interface, iface_loop = alle bekannten Interfaces)
    if {$iface != "" && $iface_loop != $iface} then { continue }

    if { [catch { set devlist [xmlrpc $iface_url($iface_loop) listDevices [list bool 0]] } ] } then {
      #puts "<div class=\"CLASS21906\">Interface-Prozess '$iface_loop' l�uft nicht.</div>"
      puts "<div class=\"CLASS21906 j_InterfaceProcess hidden\">\${interfaceProcessNotReadyA} '$iface_loop' \${interfaceProcessNotReadyB}</div>"
      continue
    }

    set devcount [llength $devlist]

    for {set i 0} {$i < $devcount} {incr i} {


      array set dev_descr [lindex $devlist $i]
      array set dev_descr_group ""
      set has_group 0
      catch {
        set dummy $dev_descr(GROUP)
        # A non-HmIP device has only a GROUP parameter when it's defined within the devicedescription. The parameter contains the address of the group partner.
        # A HmIP device has always a GROUP parameter. When no group available the parameter is ""
        if {$dummy != ""} {
          set has_group 1
          incr i
          array set dev_descr_group [lindex $devlist $i]
        }
      }
            
      if {($dev_descr(TYPE) == "VIRTUAL_DIMMER") || ($dev_descr(TYPE) == "VIRTUAL_DUAL_WHITE_BRIGHTNESS") || ($dev_descr(TYPE) == "VIRTUAL_DUAL_WHITE_COLOR") } {
        #Virtuelle Dimmerkan�le nur anzeigen wenn Expertenmodus aktiv UND der virtuelle Kanal aktiv geschaltet ist.
        #Die virtuellen Dimmerkan�le k�nnen in den Kanalparametern unter dem Punkt 'Verkn�pfungsregel' aktiviert werden.
        if {[session_is_expert]} {
          set error [catch {array set ch_ps [xmlrpc $iface_url($iface_loop) getParamset [list string $dev_descr(ADDRESS)] [list string MASTER]]}]
          #Expertenmodus aktiv, Kanal deaktivert = Kanal nicht anzeigen
          if {$ch_ps(LOGIC_COMBINATION) == "0" } {
            array_clear dev_descr
            continue
          } 
        } else {
          #Expertenmodus nicht aktiv = Kanal nicht anzeigen
          array_clear dev_descr
          continue
        }
      }  

      #Bestimmte Kan�le der HmIP-Ger�te d�rfen nicht auftauchen
      set parentType ""
      set isChannel [catch {set parentType $dev_descr(PARENT_TYPE)}]

      if {$isChannel == 0} {
        # Don't show certain HmIP-Channels AND invisible marked channels (FLAGS visible = 0)
        if {([showHmIPChannel $parentType $dev_descr(DIRECTION) $dev_descr(ADDRESS) $dev_descr(TYPE) ] == 0) || (! ($dev_descr(FLAGS) & 1))} {
          array_clear dev_descr
          continue
        }
      }

      #Nur Kan�le, keine Ger�te
      #Kan�le, die kein LINK-Parameterset haben, k�nnen nicht verkn�pft werden und erscheinen in dieser Liste nicht.
      if { $dev_descr(PARENT) == "" || [lsearch $dev_descr(PARAMSETS) LINK] == -1 } then {
        #puts "<div class=\"CLASS21906\">Diesen nicht: $dev_descr(PARENT) Paramsets: $dev_descr(PARAMSETS) lsearch: [lsearch $dev_descr(PARAMSETS) LINK]</div>"
        array_clear dev_descr
        continue 
      }

      #Nur verkn�pfbare Kan�le anzeigen, wenn wir Schritt 2 bearbeiten
       if { $step == 2 && ![check_role_match $dev_roles $dev_descr($ROLENAME2CHECK)] || $step == 2 && ![check_isSameDeviceAndValid $sender_address $receiver_address $dev_descr(ADDRESS) $dev_descr(TYPE)]} then {
        #puts "<div class=\"CLASS21906\">Diesen schon gar nicht: $dev_descr(ADDRESS)</div>"
        array_clear dev_descr
        continue
      }

      #Nur Kan�le anzeigen, die schon vom Posteingang in die Ger�teliste �bertragen wurden
      if { ![ metadata_getReadyConfig $iface_loop $dev_descr(PARENT) ] } then {
        continue
      }

      catch {
        #Nur Kan�le anzeigen, die keiner Gruppe zugeordnet sind
        if {[metaData_isGroupOnly $ise_CHANNELNAMES($iface_loop;$dev_descr(ADDRESS))] == "true"} {
          continue
        }
      }
      array set SENTRY ""
      if { ([catch { set SENTRY(NAME) $ise_CHANNELNAMES($iface_loop;$dev_descr(ADDRESS))} ])} then {
        set SENTRY(NAME) "$iface_loop"
        append SENTRY(NAME) ".$dev_descr(ADDRESS)"
      }
      if { $has_group == 1 && [catch { append SENTRY(NAME) ", $ise_CHANNELNAMES($iface_loop;$dev_descr_group(ADDRESS))" } ] } then {
        append SENTRY(NAME) ", $iface_loop"
        append SENTRY(NAME) ".$dev_descr_group(ADDRESS)"
      }

      set SENTRY(TYPE)  "$dev_descr(PARENT_TYPE)<br />Ch.: $dev_descr(INDEX)"
      if {$has_group == 1} then {
        append SENTRY(TYPE) " und $dev_descr_group(INDEX)"
      }

      #Image===
      set senderimgpath_50  [DEV_getImagePath $dev_descr(PARENT_TYPE)  50]

      if {$senderimgpath_50 == ""} { set senderimgpath_50 "#" }

      #set SENTRY(IMAGE) "<img src=\"/config/$senderimgpath_50\" alt=\"$dev_descr(PARENT_TYPE)\" onmouseover=\"picDivShow('$dev_descr(PARENT_TYPE)', 250, $dev_descr(INDEX));\" onmouseout=\"picDivHide();\"/>"
      set SENTRY(IMAGE) "<div id=\"picDiv_$rowcount\" class=\"CLASS21907\" onmouseover=\"picDivShow(jg_250, '$dev_descr(PARENT_TYPE)', 250, [expr {$has_group==1?"'$dev_descr(INDEX)+$dev_descr_group(INDEX)'":"'$dev_descr(INDEX)'"} ], this);\" onmouseout=\"picDivHide(jg_250);\"></div>"
      append SENTRY(IMAGE) "<script type=\"text/javascript\">"
      append SENTRY(IMAGE) "var jg_$rowcount = new jsGraphics(\"picDiv_$rowcount\");"
      append SENTRY(IMAGE) "InitGD(jg_$rowcount, 50);"
      append SENTRY(IMAGE) "Draw(jg_$rowcount, '$dev_descr(PARENT_TYPE)', 50, [expr {$has_group==1?"'$dev_descr(INDEX)+$dev_descr_group(INDEX)'":"'$dev_descr(INDEX)'"} ]);"
      append SENTRY(IMAGE) "</script>"
      #===
      
      if { [catch {set SENTRY(DESCRIPTION) "$DEV_DESCRIPTION($dev_descr(PARENT_TYPE))" } ] } then {
        set SENTRY(DESCRIPTION) "$dev_descr(PARENT_TYPE)"
      }

      set SENTRY(ADDRESS)  $dev_descr(ADDRESS)
      if {$has_group == 1} then {
        append SENTRY(ADDRESS) "<br/>$dev_descr_group(ADDRESS)"
      }
      
      #set SENTRY(DIRECTION)  [expr {$dev_descr(DIRECTION)==2?"Empf&auml;nger":"Sender"} ]
      set SENTRY(DIRECTION)  [expr {$dev_descr(DIRECTION)==2?"\${lblReceiver}":"\${lblSender}"} ]
      #if {$has_group == 1} then {
        #append SENTRY(DIRECTION) "<br/>[expr {$dev_descr_group(DIRECTION)==2?"\${lblReceiver}":"\${lblSender}"} ]"
      #}

      #set aes_active(1) [expr {$dev_descr(AES_ACTIVE)?"Gesichert":"Standard"} ]
      set aes_active(1) [expr {$dev_descr(AES_ACTIVE)?"\${lblSecured}":"\${lblStandard}"} ]
      set aes_active(2) ""
      if {$has_group == 1} then {
        #set aes_active(2) [expr {$dev_descr_group(AES_ACTIVE)?"Gesichert":"Standard"} ]
        set aes_active(2) [expr {$dev_descr_group(AES_ACTIVE)?"\${lblSecured}":"\${lblStandard}"} ]
      }
      set SENTRY(AES_ACTIVE) ""
      foreach aes_state [uniq [list $aes_active(1) $aes_active(2)]] {
        append SENTRY(AES_ACTIVE) "$aes_state, "
      }
      set SENTRY(AES_ACTIVE) [string trimright $SENTRY(AES_ACTIVE) ", "]
      if { $SENTRY(AES_ACTIVE) == "" } then { set SENTRY(AES_ACTIVE) "-" }
      
      set function(1) ""
      set function(2) ""
      catch { set function(1) $ise_FUNCTIONS($iface_loop;$dev_descr(ADDRESS))       }
      if {$has_group == 1} then {
        catch { set function(2) $ise_FUNCTIONS($iface_loop;$dev_descr_group(ADDRESS)) }
      }
      set SENTRY(FUNCTIONGROUP) ""
      foreach afunction [uniq [concat $function(1) $function(2)]] {
        if {[string first "func" $afunction] == 0} {
          append SENTRY(FUNCTIONGROUP) "\$\{$afunction\}, "
        } else {
          # User defined function name. Shouldn�t be translated..
          append SENTRY(FUNCTIONGROUP) "$afunction, "
        }
      }
      set SENTRY(FUNCTIONGROUP) [string trimright $SENTRY(FUNCTIONGROUP) ", "]
      if { $SENTRY(FUNCTIONGROUP) == "" } then { set SENTRY(FUNCTIONGROUP) "&nbsp;" }
      
      set room(1) ""
      set room(2) ""
      catch { set room(1) $ise_ROOMS($iface_loop;$dev_descr(ADDRESS))       }
      if {$has_group == 1} then {
        catch { set room(2) $ise_ROOMS($iface_loop;$dev_descr_group(ADDRESS)) }
      }
      set SENTRY(ROOM) ""
      foreach aroom [uniq [concat $room(1) $room(2)]] {
        if {[string first "room" $aroom] == 0} {
          append SENTRY(ROOM) "\$\{$aroom\}, "
        } else {
          # User defined room name. Shouldn�t be translated..
          append SENTRY(ROOM) "$aroom, "
        }
      }
      set SENTRY(ROOM) [string trimright $SENTRY(ROOM) ", "]
      if { $SENTRY(ROOM) == "" } then { set SENTRY(ROOM) "&nbsp;" }

      if {$step == 2} then {
        if {$sender_address != ""} then {
          set SENTRY(ACTION) "<div onclick=\"ShowNewLinkSummary('$iface_loop', '$sender_address',     '$dev_descr(ADDRESS)', \$F('input_name'), \$F('input_description') [expr {$sender_group!="" ? ", \$F('input_group_name'), \$F('input_group_description')" : ""}]);\" class=\"CLASS21904\">\${btnSelect}</div>"
        } else {
          set SENTRY(ACTION) "<div onclick=\"ShowNewLinkSummary('$iface_loop', '$dev_descr(ADDRESS)', '$receiver_address',   \$F('input_name'), \$F('input_description') [expr {$sender_group!="" ? ", \$F('input_group_name'), \$F('input_group_description')" : ""}]);\" class=\"CLASS21904\">\${btnSelect}</div>"
        }
      } else {
        set SENTRY(ACTION) "<div onclick=\"Select2ndLinkPartner('$iface_loop', '$dev_descr(ADDRESS)', $dev_descr(DIRECTION));\" class=\"CLASS21904\">\${btnSelect}</div>"
      }

      puts "<tr [expr {$dev_descr(TYPE) == "VIRTUAL_KEY"?"class=\"virtual_key_hidden\"":""} ] >"

      #puts "<script type=\"text/javascript\">console.log(\"$dev_descr(PARENT_TYPE)\");</script>"

      if { [test_space $SENTRY(NAME)] == 1 } then { puts "<td id=\"dev$rowcount\">$SENTRY(NAME)</td>" } else { puts "<td id=\"dev$rowcount\">[cgi_quote_html $SENTRY(NAME)]</td>" }

      puts "<script type=\"text/javascript\">"
        #puts "var ext = getExtendedDescription(\"$dev_descr(PARENT_TYPE)\", \"$dev_descr(INDEX)\");"
        puts "var ext = getExtendedDescription(\{\"deviceType\" : \"$dev_descr(PARENT_TYPE)\", \"channelType\" : \"$dev_descr(TYPE)\" ,\"channelIndex\" : \"$dev_descr(INDEX)\", \"channelAddress\" : \"$dev_descr(ADDRESS)\" \});"
        puts "if (ext.length > 0) \{"
          puts "jQuery(\"#dev$rowcount\").html(\"<br/>$SENTRY(NAME)<br/><br/>\" + ext);"
        puts "\}"
      puts "</script>"

      puts "<td>$SENTRY(TYPE)</td>"

      puts "<td class=\"chnListTbl_dev_img\">$SENTRY(IMAGE)</td>"

      # This adds the device name (not the channel name) to the channel description
      set deviceName ""
      catch {set deviceName $ise_CHANNELNAMES($iface_loop;[lindex [split $dev_descr(ADDRESS) ":"] 0])}

      if { [test_space $SENTRY(DESCRIPTION)] == 1 } then { puts "<td>$SENTRY(DESCRIPTION)</td>" } else { puts "<td>[cgi_quote_html $SENTRY(DESCRIPTION)]<br/>$deviceName</td>" }

      puts "<td>$SENTRY(ADDRESS)</td>"
      puts "<td>$SENTRY(DIRECTION)</td>"
      puts "<td>$SENTRY(AES_ACTIVE)</td>"

      if { [test_space $SENTRY(FUNCTIONGROUP)] == 1 } then { puts "<td id=\"group$rowcount\">$SENTRY(FUNCTIONGROUP)</td>" } else { puts "<td id=\"group$rowcount\">[cgi_quote_html $SENTRY(FUNCTIONGROUP)]</td>" }

      if { [test_space $SENTRY(ROOM)] == 1 } then { puts "<td id=\"room$rowcount\">$SENTRY(ROOM)</td>" } else { puts "<td id=\"room$rowcount\">[cgi_quote_html $SENTRY(ROOM)]</td>" }

      puts "<script type=\"text/javascript\">"
        puts "var groupElem = jQuery(\"#group$rowcount\");"
        puts "var roomElem = jQuery(\"#room$rowcount\");"
        puts "groupElem.html(translateString(groupElem.html()));"
        puts "roomElem.html(translateString(roomElem.html()));"
      puts "</script>"

      puts "<td align=\"center\">$SENTRY(ACTION)</td>"
      puts "</tr>"

      incr rowcount
      
      if {$dev_descr(TYPE) == "VIRTUAL_KEY"} then { incr virtualcount }
      
      array_clear SENTRY
      array_clear dev_descr
    }
  }

  if {$rowcount == 0} then {
    puts "<TR>"
    puts "<TD height=\"100\" align=\"center\" COLSPAN=\"10\">\${noLinkableChannelsAvailable}</TD>"
    puts "</TR>"
  }

  puts "</TBODY>"

  set realchannels    [expr $rowcount - $virtualcount]
  set virtualchannels $virtualcount
  puts "<script type=\"text/javascript\">"
    puts "translatePage(\".j_InterfaceProcess\"); "
    puts "jQuery(\".j_InterfaceProcess\").show();"
    puts "translatePage(\"#chnListBody\"); "
    puts "jQuery(\"#chnListBody\").css(\"display\", \"table-row-group\");"
  puts "</script>"
}

cgi_eval {

#cgi_debug -on
  cgi_input

  if {[session_requestisvalid 0] > 0} then {

    #-----------------------------------------
    #allg. globale Parameter
    set step 1
    array set dev_descr_sender       ""
    array set dev_descr_receiver     ""
    array set dev_descr_sender_group ""
    set sender_group                 ""
     set receiver_links               ""
    
    #URL-Parameter
    set iface             ""
    set sender_address    ""
    set receiver_address  ""
    set name              ""
    set description       ""
    set group_name        ""
    set group_description ""

    catch {import iface}
    catch {import sender_address}
    catch {import receiver_address}
    catch {import name}
    catch {import description}
    catch {import group_name}
    catch {import group_description}
    #-----------------------------------------

    http_head
    
    if { $iface != "" && $sender_address != "" && $receiver_address != "" } then {
      
      set step 3
      set url $iface_url($iface)
        array set dev_descr_sender   [xmlrpc $url getDeviceDescription [list string $sender_address  ]]
        array set dev_descr_receiver [xmlrpc $url getDeviceDescription [list string $receiver_address]]
      
      catch { set sender_group $dev_descr_sender(GROUP) }
      if {$sender_group != ""} then {
          array set dev_descr_sender_group [xmlrpc $url getDeviceDescription [list string $sender_group]]
      }

      #F�r die Pr�fung, ob es die Verkn�pfung schon gibt. Schutz vorm �berschreiben der Verkn�pfung---
      set flags 0
         set receiver_links [xmlrpc $url getLinks [list string $receiver_address] [list int $flags] ]
      #-----------------------------------------------------------------------------------------------

    } elseif {$iface != "" && $sender_address != ""} then {
      
      set step 2
      set url $iface_url($iface)
        array set dev_descr_sender [xmlrpc $url getDeviceDescription [list string $sender_address]]

      catch { set sender_group $dev_descr_sender(GROUP) }
      if {$sender_group != ""} then {
          array set dev_descr_sender_group [xmlrpc $url getDeviceDescription [list string $sender_group]]
      }
      
    } elseif {$iface != "" && $receiver_address != ""} then {
      
      set step 2
      set url $iface_url($iface)
        array set dev_descr_receiver [xmlrpc $url getDeviceDescription [list string $receiver_address]]

    } else {
      #step 1 wird nun angezeigt. "set step 1" wurde schon gesetzt
    }
    put_page
  }
}
