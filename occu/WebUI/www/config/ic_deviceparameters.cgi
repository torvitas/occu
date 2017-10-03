#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce session.tcl
sourceOnce ic_common.tcl
sourceOnce common.tcl
loadOnce tclrpc.so

#ISE-Daten
array set ise_CHANNELNAMES ""
ise_getChannelNames ise_CHANNELNAMES

proc put_error {iface address} {

  puts "<div id=\"ic_deviceparameters\">"
    puts "<div id=\"id_body\">"
      
      puts "<div class=\"subOffsetDivPopup CLASS22000\">"

      puts "<script type=\"text/javascript\">"
      puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>Programme &amp; Verkn&uuml;pfungen</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>Direkte Verkn&uuml;pfungen</span> &gt; Ger&auml;te- / Kanalparameter einstellen\");"

      puts "  var s = \"\";"
      puts "  s += \"<table cellspacing='8'>\";"
      puts "  s += \"<tr>\";"
      puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='CloseDeviceParameters();'>Abbrechen</div></td>\";"
      puts "  s += \"</tr>\";"
      puts "  s += \"</table>\";"
      puts "  setFooter(s);"
      
      puts "</script>"
      
      puts "Das Ger&auml;t mit der Seriennummer '$address' vom Interface '$iface' konnte nicht abgefragt werden!"

      puts "</div>"

    puts "</div>"
  puts "</div>"
}

proc put_page {} {

  global MODE redirect_url dev_descr

  #cgi_debug -on

  puts "<div id=\"ic_deviceparameters\">"
      
    puts "<div id=\"id_body\">"
      
      puts "<div class=\"subOffsetDivPopup CLASS22000\">"
      
      puts "<script type=\"text/javascript\">"
      if {$redirect_url == "IC_SETPROFILES" || $redirect_url == "IC_LINKPEERLIST"} then { 
        #puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>Programme &amp; Verkn&uuml;pfungen</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>Direkte Verkn&uuml;pfungen</span> &gt; Ger&auml;te- / Kanalparameter einstellen\");"
        puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>\"+translateKey('menuProgramsLinksPage')+\"</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>\"+translateKey('submenuDirectLinks')+\"</span> &gt; \" + translateKey('setDeviceAndChannelParams'));"
      } else {
        #puts "  setPath(\"<span onclick='WebUI.enter(SystemConfigPage);'>Einstellungen</span> &gt; <span onclick='WebUI.enter(DeviceListPage);'>Ger&auml;te</span> &gt; Ger&auml;te- / Kanalparameter einstellen\");"
        puts "  setPath(\"<span onclick='WebUI.enter(SystemConfigPage);'>\"+translateKey('menuSettingsPage')+\"</span> &gt; <span onclick='WebUI.enter(DeviceListPage);'>\"+translateKey('submenuDevices')+\"</span> &gt; \" + translateKey('setDeviceAndChannelParams'));"
      }

      puts "  var s = \"\";"
      puts "  s += \"<table cellspacing='8'>\";"
      puts "  s += \"<tr>\";"
      puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='SaveDeviceParameters();'>\"+translateKey('footerBtnOk')+\"</div></td>\";"
      puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='CloseDeviceParameters();'>\"+translateKey('footerBtnCancel')+\"</div></td>\";"
      puts "  s += \"</tr>\";"
      puts "  s += \"</table>\";"
      puts "  setFooter(s);"
      
      puts "</script>"

      puts "<div id=\"global_values\" style=\"display: none; visibility: hidden;\">"
      put_hidden_values
      puts "</div>"

      puts "<div id=\"head_wrapper\">"
      put_Header
      puts "</div>"
      
      puts "<div id=\"body_wrapper\" class=\"j_translate\">"
      if {$MODE == "DEVICEPARAMETERS"} then {
        put_device_parameters
      }
      put_channel_parameters
      puts "</div>"
      
      #subOffsetDivPopup
      puts "</div>"

    #id_body
    puts "</div>"
      
  #ic_deviceparameters
  puts "</div>"
}

proc put_hidden_values {} {

  global iface address redirect_url sidname sid dev_descr
  global channel_address channel_group

  #cgi_debug -on

  puts "<form action=\"#\">"
  puts "<input id=\"global_sid\"             name=\"$sidname\"        type=\"hidden\" value=\"$sid\"/>"
  puts "<input id=\"global_iface\"           name=\"iface\"           type=\"hidden\" value=\"$iface\"/>"
  puts "<input id=\"global_address\"         name=\"address\"         type=\"hidden\" value=\"$address\"/>"
  puts "<input id=\"global_channel_address\" name=\"channel_address\" type=\"hidden\" value=\"$channel_address\"/>"
  puts "<input id=\"global_channel_group\"   name=\"channel_group\"   type=\"hidden\" value=\"$channel_group\"/>"
  puts "<input id=\"global_redirect_url\"    name=\"redirect_url\"    type=\"hidden\" value=\"$redirect_url\"/>"

  if { [ info exist dev_descr(CHILDREN) ] } then {
    set i 1
    foreach ch_address $dev_descr(CHILDREN) {
      puts "<input id=\"global_channel_address_$i\" name=\"channel_address\" type=\"hidden\" value=\"$ch_address\"/>"
      incr i
    }

    puts "<input id=\"global_channel_count\" name=\"channel_count\" type=\"hidden\" value=\"[llength $dev_descr(CHILDREN)]\"/>"
  }

  puts "</form>"
}

proc put_device_parameters {} {

#cgi_debug -on

  global iface iface_url
  global address dev_paramid dev_ps

  set s ""

  if {$dev_paramid != "" && ![catch {source easymodes/$dev_paramid.tcl} ] } then {
    set_htmlParams $iface $address dev_ps "DEVICE" "" ""
    set s $HTML_PARAMS(separate_1)
    destructor
  } else {
    catch { set s [cmd_link_paramset $iface $address MASTER MASTER DEVICE] }
  }

  if {$s == ""} then {
    #set s "<div class=\"CLASS22001\">Keine Parameter einstellbar.</div>"
    set s "<div class=\"CLASS22001\">\${deviceAndChannelParamsLblNoParamsToSet}</div>"
  }
  
  puts "<div class=\"parameter_area CLASS22002\" id=\"id_device_parameters\" style=\"display:none\" >"
  
  #Hier nur als Tabelle, damit die Formatierung wie die in der Kanalparameter-�bersicht ist
  puts "<table class=\"parameter_header\" cellspacing=\"0\">"
  puts "<thead>"
  puts "<TR>"
  puts "<td>\${deviceAndChannelParamsLblDeviceParam}</td>"
  puts "<td>&nbsp;</td>"
  puts "</tr>"
  puts "</thead>"
  puts "</table>"
  
  puts "<table id=\"id_device_parameters_table\" class=\"parameters_table\" cellspacing=\"0\">"
  
  puts "<THEAD>"
  puts "<TR><TD>\${thParameter}</TD></TR>"
  puts "</THEAD>"
  
  puts "<TBODY>"
  puts "<tr><td class=\"CLASS22003\">$s</td></tr>"
  puts "</TBODY>"
  
  puts "</table>"

  puts "</div>"

  puts "<script type='text/javascript'>"
  puts "translatePage('#id_device_parameters');"
  puts "jQuery('#id_device_parameters').show();"
  puts "</script>"

}

proc recycle_easymodes {pPROFILES_MAP pHTML_PARAMS special_input_id cur_profile pps} {

#cgi_debug -on
  global ch_descr dev_descr_receiver  
  upvar $pPROFILES_MAP PROFILES_MAP
  upvar $pHTML_PARAMS  HTML_PARAMS
  upvar $pps           ps
  
  set u_subset ""

  if {! [session_is_expert]} {
   unset PROFILES_MAP(0)
  }


  foreach pnr [array names PROFILES_MAP] {

  if {[regexp {^([0-9]+)\.[0-9]+$} $pnr dummy base_pnr]} then {

      #Dies ist ein vom Benutzer angelegtes Profil.
      #HTML-IDs austauschen und als neuen Text �bernehmen:
      set HTML_PARAMS(separate_$pnr) [replace_ids $HTML_PARAMS(separate_$base_pnr) separate_${special_input_id}_$base_pnr separate_${special_input_id}_$pnr]
      set i 1
      set s ""
      upvar PROFILE_$pnr PROFILE

      #HTML-Input-Controls auf richtige Werte setzen:

      foreach pname [array names PROFILE] {
        
        #Nur die Parameter die im Text enthalten sind. Interne Parameter, die mit UI_ anfangen auslassen.
          
        if { [string first $HTML_PARAMS(separate_$pnr) $pname] && [string range $pname 0 2] != "UI_"} { 
        
          if {$pname == "SUBSET_OPTION_VALUE"} {
            set u_subset $PROFILE($pname)
          }

          #Normalerweise die Werte aus den angelegten Profilen nehmen, ausser das Profil ist aktiv. Dann die 
          #Werte des Ger�ts nehmen (aktuelle).
          
          if {$pname != "NAME" && $pname != "SUBSET_OPTION_VALUE"} {
            if {$cur_profile == $pnr} then { append s "recycle_arr\['$pname'\] = $ps($pname);" 
            } else {                   
              append s "recycle_arr\['$pname'\] = $PROFILE($pname);" 
            }
            incr i 
          }
        }
      }

      if {$i > 1} then {
        append HTML_PARAMS(separate_$pnr) "<script type=\"text/javascript\">var recycle_arr = new Array(); $s UpdateSpecialInputs('separate_${special_input_id}_${pnr}', recycle_arr, '$u_subset');</script>"
      }
    }
  }
}

proc isInternalKeySuccessfulSet {url status address} {
  set paramset [xmlrpc $url getParamset [list string $address] [list string MASTER]]
  set state 0
  
  foreach {name val} $paramset {
    if {$name == "INTERNAL_KEYS_VISIBLE"} {
      if {$val == $status} {
        set state 1
        break
      }
    }
  }
  return $state
}

proc setInternalKeysOnOff {status address iface defaultOn isVisible} {
  # 0 = internal keys not visible
  # 1 = internal keys visible
     
  if { ($isVisible == 0) && ($status == 1)} {
    global iface_url
    set url $iface_url($iface)
    set internal_keys_visible "{INTERNAL_KEYS_VISIBLE {bool $status}}"
  
    while {[isInternalKeySuccessfulSet $url $status $address] == 0} {
      xmlrpc $url putParamset [list string $address] [list string MASTER] [list struct $internal_keys_visible]
      after 1500
    }
    # xmlrpc $iface_url($iface) clearConfigCache [list string $address]
  }
}

proc treatSpecialValue {devType param} {
  if {[string first "HM-LC-Dim1T-FM-LF" $devType] != - 1} {
    if {$param == "POWERUP_ON"} {
      set param "\${stringTablePowerOn}"
    }
  }
  return $param
}

proc check_RF_links {device iface address channel ch_type name} {
  if {$device == "HM-MOD-EM-8"} {
    puts "<script type=\"text/javascript\">arModEM8\[parseInt($channel)\] = false;ShowHintIfProgramExists('$name', '$channel')</script>"
    global iface_url
    set links ""
    catch {set links [xmlrpc $iface_url($iface) getLinks [list string $address]]}
    foreach _link $links {
      array set link $_link
      if {(($link(SENDER) == $address) || ($link(RECEIVER) == $address))} {
        # wenn Verknuepfung fuer diesen Kanal besteht
        puts "<script type=\"text/javascript\">RF_existsLink('$device', '$address', '$channel');</script>"
        break;
      }
    }
  }
}

proc check_HMW_links {device iface address channel ch_type} {
  global iface_url
  set links ""
  catch {set links [xmlrpc $iface_url($iface) getLinks [list string $address]]}
  foreach _link $links {
    array set link $_link
    if {(($link(SENDER) == $address) || ($link(RECEIVER) == $address))} { 
      # wenn Verknuepfung fuer diesen Kanal besteht
      puts "<script type=\"text/javascript\">HMW_existsLink('$channel', '$ch_type');</script>"
      break;
    }
  }
}

# Sets the colspan of the parent elem (td) of a selectbox depending of the length of the selectbox text
proc setColSpan {selBoxId} {
  
  puts "<script type=\"text/javascript\">"
    puts "var maxTextLength = 55;" 
    puts "var selBox = document.getElementById($selBoxId);"
    puts "var optionText;"
    
    # IE needs 'colSpan' instead of 'colspan' 
    puts "var colspan = (navigator.appName.search(/Microsoft/) == -1) ? \"colspan\" : \"colSpan\" ";
     
    puts "for (var loop = 0; loop < selBox.options.length; loop++) {"
      #puts "console.log(selBox.options\[loop\].text);"
      puts "optionText =  selBox.options\[loop\].text;"
      #puts "console.log(optionText.length);"
      
      puts "if (optionText.length > maxTextLength) {"
        puts "selBox.parentNode.setAttribute(colspan, '2');"
      puts "}" 
    puts "}"
    
  
  puts "</script>"  
}


proc put_orig_channel_parameter {address ch} { 
## -----------Standard-Kanalparameter -----------
  global ch_ps ch_ps_descr iface dev_descr_sender 
  
  set printed "false" 
  set s1 "<table class=\"ProfileTbl\">"
  append s1 "<input value=\"$address\" style=\"display:none\"/>"
  set i 1
  
  foreach param [lsort [array names ch_ps_descr]] {
  
  array_clear param_descr
  array set param_descr $ch_ps_descr($param)

  
    # introduced with the virtual channels of the dimmer
    # this will show some values as option although they are not marked as option in the xml
    # this should currently only work for the dimmer with virtual channels 
    set showOption 0      
    if {[catch {set spec $param_descr(SPECIAL)}] == 0} {
      
      set hasVirtualChannels [catch {set hasVirtualChannels $ch_ps_descr(LOGIC_COMBINATION)}]
      if {$hasVirtualChannels == 0} {
        set showOption 1
      } 
    }

    # param_descr(FLAGS) & 2 = interne Parameter, nach aussen nicht sichtbar 
    if {($ch_ps($param) >= $param_descr(MIN) || $showOption == 1) && ($ch_ps($param) <= $param_descr(MAX)) &&  ! ($param_descr(FLAGS) & 2)} {
      set printed "true"
      
      if {[string first "." $param_descr(MIN) 0] != -1} {set fmin "%.2f"} else {set fmin "%s"}
      if {[string first "." $param_descr(MAX) 0] != -1} {set fmax "%.2f"} else {set fmax "%s"}
      if {[string first "." $ch_ps($param) 0] != -1} {set fvalue "%.2f"}  else {set fvalue "%s"}
      
      set unit $param_descr(UNIT)
      set min [format $fmin $param_descr(MIN)]
      set max [format $fmax $param_descr(MAX)]
      set value [format $fvalue $ch_ps($param)]
      set value_tmp $value
      set factor 1
  
      if {$unit == "100\%"} {
        set unit "\%"
        set factor 0.01
        set f "%.0f"

        set min [format $f [expr $min * 100]]
        set max [format $f [expr $max * 100]]
        set value [format $f [expr $value * 100]]
      }

      set PROFILE_PNAME(DESCRIPTION) $param
      if {$param_descr(TYPE) != "ENUM" && $showOption == 0} {
        append s1 "<tr><td><span class=\"stringtable_value\">$dev_descr_sender(TYPE)|$PROFILE_PNAME(DESCRIPTION)</span></td>"
        append s1 "<td><input type=\"text\" size=\"10\" value=\"$value\" id=\"separate_CHANNEL_$ch\_$i\_tmp\" name='__$param' onkeyup=\"ProofAndSetValue('separate_CHANNEL_$ch\_$i\_tmp', 'separate_CHANNEL_$ch\_$i', $min, $max, $factor, event)\"></td>"
        append s1 "<td>$unit&nbsp;($min-$max)</td>"
        append s1 "<td><input type=\"text\"  value=\"$value_tmp\" id=\"separate_CHANNEL_$ch\_$i\" name='$param' style=\"display:none\";\"></td>"
      } elseif {$showOption == 1} { 
        # this should only be available for a dimmer with virtual channels
        append s1 "<script type=\"text/javascript\">"
        append s1 "self.setMinDelayVis = function(ch, i) {"

            # append s1 "console.log(\"channel: \" + ch + \" i: \" + i);"

            append s1 "var inputField = document.getElementById(\"separate_CHANNEL_\"+ch+\"\_\"+i+\"\");"
            append s1 "var inputField_tmp = document.getElementById(\"separate_CHANNEL_\"+ch+\"\_\"+i+\"\_tmp\");"
            append s1 "var option = document.getElementById(\"option_\"+ch+\"\_\"+i+\"\");"
            append s1 "var randomInput = inputField_tmp.parentNode.parentNode.nextSibling;"

            append s1 "if (option.selectedIndex == 0) {"
              append s1 "inputField.value = \'0\';"
              append s1 "inputField_tmp.style.display = \"none\";"
              append s1 "randomInput.style.display = \"none\";"
            append s1 "} else {"
              append s1 "inputField_tmp.style.display = \"inline\";"
              append s1 "randomInput.style.display = \"table-row\";"
            append s1 "}"
        
        append s1 "}" 

        append s1 "</script>"       
        
        append s1 "<tr><td><span class=\"stringtable_value\">$dev_descr_sender(TYPE)|$PROFILE_PNAME(DESCRIPTION)</span></td>"
          append s1 "<td><select id=\"option_$ch\_$i\" onchange=\"setMinDelayVis($ch, $i);\">"
            append s1 "<option>\${stringTableNotUsed}</option>"
            append s1 "<option>\${stringTableEnterValue}</option>"
          append s1 "</select>"
          
          append s1 "<input type=\"text\" value=\"$value\" id=\"separate_CHANNEL_$ch\_$i\_tmp\" name='__$param' onkeyup=\"ProofAndSetValue('separate_CHANNEL_$ch\_$i\_tmp', 'separate_CHANNEL_$ch\_$i', $min, $max, $factor, event)\">"
          append s1 "<td>$unit&nbsp;($min-$max)</td>"
          append s1 "<input type=\"text\"  value=\"$value_tmp\" id=\"separate_CHANNEL_$ch\_$i\" name='$param' style=\"display:none\";\">"
          append s1 "</td>"
      
          append s1 "<script type=\"text/javascript\">"
            append s1 "var inputField_tmp = document.getElementById(\"separate_CHANNEL_$ch\_$i\_tmp\");"
            append s1 "var option = document.getElementById(\"option_$ch\_$i\");"
            append s1 "var randomInput = inputField_tmp.parentNode.parentNode.nextSibling;"

            append s1 "if (inputField_tmp.value > 0) {"
            append s1 "inputField_tmp.style.display =\"inline\";"
            append s1 "randomInput.style.display =\"table-row\";"
            append s1 "option.selectedIndex = 1;"
            append s1 "} else {"
            append s1 "inputField_tmp.style.display =\"none\";"
            append s1 "randomInput.style.display =\"none\";"
            append s1 "option.selectedIndex = 0;"
            append s1 "}" 
          append s1 "</script>"     
  
        append s1 "</td>"

      } else  {
        
        ## Logic combination and powerup action is only visible when expert mode = on
        if {(($param != "LOGIC_COMBINATION") && ($param != "POWERUP_ACTION")) || [session_is_expert]} {
        
          append s1 "<tr><td><span class=\"stringtable_value\">$dev_descr_sender(TYPE)|$PROFILE_PNAME(DESCRIPTION)</span></td>"
        
          ######## option box
          append s1 "<td colspan=\"4\">"
          append s1 "<select id=\"separate_CHANNEL_$ch\_$i\" name=\"$param\" >"
        
          set loop 0  
          foreach val $param_descr(VALUE_LIST) {

            set val [treatSpecialValue $dev_descr_sender(PARENT_TYPE) $val]

            if {$loop == $value} {
              append s1 "<option selected class=\"stringtable_value\" value=\"$loop\">$val</option>"
            } else {
              append s1 "<option class=\"stringtable_value\" value=\"$loop\">$val</option>"
            }
            incr loop
          }
      
          append s1 "</select>"
          
          # Because of sometimes very long texts the next element of the selectbox  can be slip out of place
          # Example: when the text of the selectbox is > 60 chars the button "Automatisch ermitteln" of a dimmer actor slips out of place (screenwith 1024 px) 
          setColSpan "\"separate_CHANNEL_$ch\_$i\"" 
          
          # this should only be available for a dimmer with virtual channels
          if {($param == "LOGIC_COMBINATION")} {
            append s1 "&nbsp<input id=\"virtual_help_button_$ch\" class=\"j_helpBtn\" type=\"button\" value=\"Hilfe\" onclick=\"Virtual_DimmerChannel_help($ch);\">"
          }
        } else {incr i -1} 
        append s1 "</td>" 
        ########
        #append s1 "<td><input type=\"text\"  value=\"$value_tmp\" id=\"separate_CHANNEL_$ch\_$i\" name='$param' style=\"display:none\";\"></td>"
      }

      if {$param_descr(OPERATIONS) & 8} {
        #append s1 "<td><span class=\"CLASS21000\" \" onclick=\"DetermineParameterValue('$iface', '$address', 'MASTER', '$param', 'separate_CHANNEL_$ch\_$i')\" >Automatisch ermitteln</span></td>"
        append s1 "<td><span class=\"CLASS21000\" \" onclick=\"DetermineParameterValue('$iface', '$address', 'MASTER', '$param', 'separate_CHANNEL_$ch\_$i')\" >\${btnAutoDetect}</span></td>"
      }
      append s1 "</tr>"
      incr i
    }
  }
  append s1 "</table>"

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"

  append s1 "<table class=\"ProfileTbl\" id=\"virtual_ch_help_$ch\" style=\"display:none\">"
  #set help_txt "<span class=\"CLASS22015\"><b>Die Hilfe steht leider nicht zur Verf&uuml;gung!<b></span>"
  #catch {source virtualHelp.tcl}
  #append s1 "<tr><td>$help_txt</td></tr>"

  append s1 "<tr><td>\${virtualHelpTxt}</td></tr>"

  append s1 "</table>"  


  if {$printed} { append s1 "<hr>" }

  return $s1
}

# Some internal keys are not allowed
proc isInternalLinkValid {type chAddress} {
  set result 1

  if {([string first "HM-ES-PM" $type] != -1) && ([expr $chAddress] >= 2)} {
    set result 0
  }

  return $result
}

proc getInternalLinks {url address parentAddress parentType} {
  set arrLinks [xmlrpc $url getLinks [list string $address]]
  set intLinks {}

  foreach link $arrLinks {
    array set linkDescr $link 
    set splitAddress [split $linkDescr(SENDER) ":"]
    set peerParentAddress [lindex $splitAddress 0]
    set peerChannelAddress [lindex $splitAddress 1]

    if {($parentAddress == $peerParentAddress) && ([isInternalLinkValid $parentType $peerChannelAddress] == 1)} {
      lappend intLinks $link 
    }
  }

  if {[llength $intLinks] == 0} {
    set intLinks "{RECEIVER $address SENDER $address}"
  }
  
  return $intLinks
}

proc getInternalPeers {url address parentAddress} {
  set intPeers {}
  set arrLinkPeers [xmlrpc $url getLinkPeers [list string $address]]

  foreach peer $arrLinkPeers {
    set peerParentAddress [lindex [split $peer ":"] 0]
    
    if {$peerParentAddress == $parentAddress} {
      lappend intPeers $peer
    }         
  }
  if {[llength $intPeers] == 0} {
    lappend intPeers $address
  }
  return $intPeers
}

proc isVirtual {paramId} {
  set virtualDevices [list "switch_virt_ch_master" "dimmer_virt_ch_master" "blind_virt_ch_master" "dw_controller_brightness_virt_ch_master" "dw_controller_color_virt_ch_master"]
  lappend virtualDevices "hmip-ps_2_master" "hmip-ps_4_master" "hmip-ps_5_master"
  lappend virtualDevices "hmip-psm_2_master" "hmip-psm_4_master" "hmip-psm_5_master"
  lappend virtualDevices "hmip-bdt_3_master" "hmip-bdt_5_master" "hmip-bdt_6_master"
  lappend virtualDevices "hmip-fsm_1_master" "hmip-fsm_3_master" "hmip-fsm_4_master"
  lappend virtualDevices "hmip-miob_1_master" "hmip-miob_2_master" "hmip-miob_4_master" "hmip-miob_5_master" "hmip-miob_6_master" "hmip-miob_8_master"
  lappend virtualDevices "hmip-pdt_2_master" "hmip-pdt_4_master" "hmip-pdt_5_master"
  lappend virtualDevices "hmip-fdt_1_master" "hmip-fdt_3_master" "hmip-fdt_4_master"
  lappend virtualDevices "hmip-bbl_5_master" "hmip-bbl_6_master"
  lappend virtualDevices "hmip-fbl_5_master" "hmip-fbl_6_master"
  lappend virtualDevices "hmip-broll_5_master" "hmip-broll_6_master"
  lappend virtualDevices "hmip-froll_5_master" "hmip-froll_6_master"

  lappend virtualDevices "hmip-mod-oc8_11_master" "hmip-mod-oc8_12_master" "hmip-mod-oc8_15_master" "hmip-mod-oc8_16_master"
  lappend virtualDevices "hmip-mod-oc8_19_master" "hmip-mod-oc8_20_master" "hmip-mod-oc8_23_master" "hmip-mod-oc8_24_master"
  lappend virtualDevices "hmip-mod-oc8_27_master" "hmip-mod-oc8_28_master" "hmip-mod-oc8_31_master" "hmip-mod-oc8_32_master"
  lappend virtualDevices "hmip-mod-oc8_35_master" "hmip-mod-oc8_36_master" "hmip-mod-oc8_39_master" "hmip-mod-oc8_40_master"

  set virtual "false"

  foreach val $virtualDevices {
    if {$val == $paramId} {
      set virtual "true"
      break
    }
  } 

 return $virtual
}

proc isHmIP {} {
  global iface
  set hmIPIdentifier "HmIP-RF"
  if {$iface == $hmIPIdentifier} {
    return "true"
  }
  return "false"
}

proc setInternalDeviceKey {ch_paramid} {
  upvar s s
  upvar counter counter
  upvar ch_descr ch_descr

  global dev_descr _ch_descr iface iface_url env
  global receiver_address sender_address dev_descr_sender

  # Fetch internal links only
  set intLinks [getInternalLinks $iface_url($iface) $ch_descr(ADDRESS) $ch_descr(PARENT) $ch_descr(PARENT_TYPE)]

  incr counter

  set intPeers [getInternalPeers $iface_url($iface) $ch_descr(ADDRESS) $ch_descr(PARENT)]

  set chn [lindex [split $ch_descr(ADDRESS) ":"] 1]

  # don't delete this
  append s "<div id=\"chType_$chn\" style=\"display:none\">$ch_descr(TYPE)</div>"
  append s "<div id=\"chParamID_$chn\" style=\"display:none\">$ch_paramid</div>"
  append s "<div id=\"chInternalPeers_$chn\" style=\"display:none\">$intPeers</div>"

  # Iterate through each internal link
  set loop 1
  foreach _link $intLinks {

    array set link $_link
    set sender $link(SENDER)
    set receiver $link(RECEIVER)

    set chn [lindex [split $receiver ":"] 1]

    # wichtig f. freie Werteingabe
    array set dev_descr_sender [array get ch_descr]

    catch {source $env(DOCUMENT_ROOT)/config/easymodes/$ch_paramid\_intkey.tcl}

    array set receiver_ps [xmlrpc $iface_url($iface) getParamset [list string $receiver] [list string $sender]]
    array set ps_descr_receiver [xmlrpc $iface_url($iface) getParamsetDescription [list string $receiver] [list string $sender]]

    ## EASYMODE_WRAPPER
    append s "<div class=\"easymode_wrapper\">"

    #set special_input_id "receiver_$counter\_$ch_descr(INDEX)"
    set special_input_id "receiver_$chn\_$loop"

    set receiver_ps(UI_HINT) ""
    set cur_profile [get_cur_profile2 receiver_ps PROFILES_MAP PROFILE_TMP  "KEY"]
    set_htmlParams $iface $receiver receiver_ps ps_descr_receiver $special_input_id "KEY"
    recycle_easymodes PROFILES_MAP HTML_PARAMS $special_input_id $cur_profile receiver_ps

    if {[llength $intLinks] == 1} {
      set keyNo ""
    } else {
      set keyNo "$loop."
    }

    #append s "<br/><span class=\"CLASS22015\">Programmierung der $loop. internen Ger&auml;tetaste - $sender</span>"
    append s "<br/><span class=\"CLASS22015_\">\${lblProgrammingOfInternalDeviceKeyA} $keyNo \${lblProgrammingOfInternalDeviceKeyB} - $receiver</span>"
    append s "<br/><br/>"

    # die ComboBox der Profilauswahl
    append s "<div id=\"maps_div_$chn\_$loop\"><textarea id=\"maps_textarea_$chn\_$loop\" style=\"display:none\">"
    append s [get_ComboBox2 PROFILES_MAP "receiver_$chn\_$loop\_profiles" "receiver_$chn\_$loop\_profiles" $cur_profile  "onchange=\"ShowInternalKeyProfile(this, $loop, $chn);Disable_SimKey($loop, this.selectedIndex, '${special_input_id}')\""]
    append s "</textarea></div>"
    append s "<script type=\"text/javascript\">translate_map('maps_div_$chn\_$loop', 'maps_textarea_$chn\_$loop');</script>"

    append s "<table id=\"internalKey_$chn\_$loop\" class=\"ProfileTbl\">"

    foreach pnr [lsort [array names PROFILES_MAP]] {
      append s "<script type=\"text/javascript\">translate('$pnr', '$special_input_id');</script>"
      append s  "<tr class=\"$special_input_id\_$pnr\" [expr {$cur_profile == $pnr?" ":" style=\"visibility:hidden; display:none;\""} ]><td>"
      append s $HTML_PARAMS(separate_$pnr)

      append s "<br/><input type=\"button\" id=\"SimKey_$chn\_$loop\_$pnr\" name=\"btnSimKeyPress\" onclick=\"SendInternalKeyPress('$iface', '$sender', '$receiver')\" value=\"Simuliere Tastendruck\">"
      if {[info exists simulateLongKeyPress] == 1} {
        if {$simulateLongKeyPress == 1} {
          append s "<script type=\"text/javascript\">jQuery(\"#SimKey_$chn\_$loop\_$pnr\").attr(\"name\",\"btnSimShortKeyPress\");</script>"
          append s "<input type=\"button\" id=\"SimLongKey_$chn\_$loop\_$pnr\" name=\"btnSimLongKeyPress\" onclick=\"SendInternalKeyPress('$iface', '$sender', '$receiver', true)\" value=\"Simuliere langen Tastendruck\">"
        }
      }
      append s  "<br/><div id=\"SimKeyHint_$chn\_$loop\_$pnr\" class=\"attention\" style=\"display:none\">&nbsp;&nbsp;\${lblHintSimulateKeyPress}</div></td>"

      append s  "</tr>"
    }
    append s "</table></div>"
    ## E N D   EASYMODE_WRAPPER


    #Ausgew�hlten Eintrag sichtbar schalten: // pr�fen, ob n�tig
    #append s "<div>\$('receiver_$counter\_$loop\_profiles')</div>"
    #append s   "<script type=\"text/javascript\">ShowInternalKeyProfile(\$('receiver_$counter\_$loop\_profiles'), '$loop', '$counter');</script>"

    incr loop
  }
  catch {unset internalKey}
}

proc put_channel_parameters {} {
  global dev_descr ch_descr iface iface_url env
  global ise_CHANNELNAMES MODE channel_address channel_group
  set state_intKey -1
  set wired ""
  set s ""

  if { ! [ info exist dev_descr(CHILDREN) ] } then {
    #Keine Channels vorhanden == Keine Parameter einstellbar.
    set dev_descr(CHILDREN) ""
  }
    
  puts "<div class=\"parameter_area\" id=\"id_channel_parameters\" style=\"display:none\">"
  
  puts "<table class=\"parameter_header\" cellspacing=\"0\">"
  puts "<thead>"
  puts "<tr>"
  puts "<td class=\"CLASS22014\">\${deviceAndChannelParamsLblChannelParam}</td>"
  if {$MODE == "DEVICEPARAMETERS"} then {
    puts "<td class=\"CLASS22014\" onclick=\"ToggleChannelView();\"><div id=\"ToggleButtonChannelView\" class=\"CLASS21000\">\${deviceAndChannelParamsBtnCloseParamList}</div></td>"
  } else {
    puts "<td>&nbsp;</td>"
  }
  puts "<td>&nbsp;</td>"
  puts "</tr>"
  puts "</thead>"
  puts "</table>"

  puts "<table id=\"id_channel_parameters_table\" class=\"parameters_table\" cellspacing=\"0\">"
  
  puts "<colgroup>"
  puts "  <col width=\"20%\" />"
  puts "  <col width=\"5%\" />"
  puts "  <col width=\"75%\" />"
  puts "</colgroup>"

  puts "<THEAD>"

  puts "<TR>"
  puts "<TD>\${thName}</TD>"
  puts "<TD>\${thChannel}</TD>"
  puts "<TD>\${thParameter}</TD>"
  puts "</TR>"
  
  puts "</THEAD>"

  puts "<TBODY>"

  set tr_count 0
  set counter 0
  set chNumber "[expr  [llength $dev_descr(CHILDREN)] - 1 ]"
  foreach ch_address $dev_descr(CHILDREN) {
    #An welchen Kan�len sind wir nicht interessiert?-----
    set hide_channel 0
    
    if {$MODE == "CHANNELPARAMETERS"} then {
      
      if {$channel_address != $ch_address} then {
        set hide_channel 1
      }
      
    } elseif {$MODE == "CHANNELGROUPPARAMETERS"} then {

      #channel_address UND channel_group sollen angezeigt werden!
      if {$channel_address != $ch_address && $channel_group != $ch_address} then {
        set hide_channel 1
      }
    }
    #else: MODE==DEVICEPARAMETERS (alles wird angezeigt)
    #---------------------------------------------

    if { [catch { array set ch_descr [xmlrpc $iface_url($iface) getDeviceDescription [list string $ch_address]] } ] } then {
      continue
    }
    
    array set ch_descr_orig [array get ch_descr]

    # F�r HmIP Kanal 0 aktivieren
    if {($ch_descr(INDEX) == 0) && ($iface != "HmIP-RF")} then { continue }

    # Hier kann der Kanal f�r das Wochenprogramm der HmIP-Ger�te unsichtbar geschaltet werden.
    # Ausserdem werden alle Kan�le mit dem FLAG Visible 0 ausgeblendet
    if {([isHmIP] == "true") && ($ch_descr(TYPE) == "WEEK_PROGRAM") || ! ($ch_descr(FLAGS) & 1)} then {
        set hide_channel 1
    }

    if { [catch { set ch_name $ise_CHANNELNAMES($iface;$ch_descr(ADDRESS)) } ] } then {
        set ch_name "${iface}.$ch_descr(ADDRESS)"
    }

#
    #Kanal-Paramids bestimmen:
    set ch_paramid ""
    catch { 
      set paramids [xmlrpc $iface_url($iface) getParamsetId $ch_address MASTER]
      set ch_paramid [getExistingParamId $paramids]
      set ch_PARAMIDS $paramids
      global ch_ps ch_ps_descr
      array_clear ch_ps
      array set ch_ps [xmlrpc $iface_url($iface) getParamset [list string $ch_address] [list string MASTER]]
      array_clear ch_ps_descr
      array set ch_ps_descr [xmlrpc $iface_url($iface) getParamsetDescription [list string $ch_address] [list string MASTER]]
    }
    #=====

    set sourcePath "$env(DOCUMENT_ROOT)config/easymodes/$ch_paramid.tcl"

    if {[isHmIP] == "true"} {
      if {[file exist $env(DOCUMENT_ROOT)config/easymodes/hmip/$ch_paramid.tcl]} {
        set sourcePath "$env(DOCUMENT_ROOT)config/easymodes/hmip/$ch_paramid.tcl"
      } elseif {[file exists $env(DOCUMENT_ROOT)config/easymodes/hmip/$ch_descr(TYPE).tcl]} {
        set ch_paramid "$ch_descr(TYPE)"
        set sourcePath "$env(DOCUMENT_ROOT)config/easymodes/hmip/$ch_descr(TYPE).tcl"
      }
    }

    global internalKey simulateLongKeyPress
    # if {$ch_paramid != "" && ![catch {source $env(DOCUMENT_ROOT)/config/easymodes/$ch_paramid.tcl} ] } then
    if {$ch_paramid != "" && ![catch {source $sourcePath} ] } then {
      # if {! [info exists internalKey] || $ch_paramid == "dimmer_virt_ch_master" } then
      if {! [info exists internalKey] } then {
        set_htmlParams $iface $ch_address ch_ps ch_ps_descr CHANNEL_$ch_descr(INDEX) ""
        set s $HTML_PARAMS(separate_1)

        # Internal keys for user specific config pages

        if {
           ([string equal $ch_paramid "dw_controller_color_ch_master"] == 1)
        || ([string equal $ch_paramid "dw_controller_color_virt_ch_master"] == 1)
        || ([string equal $ch_paramid "dw_controller_brightness_ch_master"] == 1)
        || ([string equal $ch_paramid "dw_controller_brightness_virt_ch_master"] == 1)
        } {
         setInternalDeviceKey $ch_paramid
        }
      } else {
        # Internal keys for generic config pages
        set s "" 
        if {[isVirtual $ch_paramid] == "true"} {
          set file "$ch_paramid\Params.tcl"
          catch {source $env(DOCUMENT_ROOT)/config/easymodes/$file}
          # catch { set s [cmd_link_paramset $iface $ch_descr(ADDRESS) MASTER MASTER CHANNEL_$ch_descr(INDEX)] }
          catch { set_htmlParams $iface $ch_address ch_ps ch_ps_descr CHANNEL_$ch_descr(INDEX) "" }
          append s $HTML_PARAMS(separate_1)
        }

        global receiver_address sender_address dev_descr_sender 
        set sender_address $ch_address
        set receiver_address $ch_address
        incr counter
        
        # internal key unlocked in xml-file?
        if {![catch {array set intKey [xmlrpc $iface_url($iface) getParamset [list string $dev_descr(ADDRESS)] [list string MASTER]]}]} {
          catch {set state_intKey $intKey(INTERNAL_KEYS_VISIBLE)}
        }
         
        if {($state_intKey == 0) || ($state_intKey == 1)} {  
          # current state of the internal key
          
          set isInternalKeyVisible $intKey(INTERNAL_KEYS_VISIBLE) 
          
          array set masterParamsetDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $dev_descr(ADDRESS)] [list string MASTER] ]        
       
          # Ermitteln, ob die interne Taste per default freigeschaltet ist.   
          array set internalKeyDescr $masterParamsetDescr(INTERNAL_KEYS_VISIBLE) 
          set defaultInternalKey $internalKeyDescr(DEFAULT)
          # defaultInternalKey ist jetzt 0 oder 1
          
          cgi_debug -on 
          set error [catch {array set valueset [xmlrpc $iface_url($iface) getParamset [list string $ch_descr(ADDRESS)] [list string VALUES]]}]
          if {$error == 0} {
            setInternalKeysOnOff 1 $ch_descr(PARENT) $iface $defaultInternalKey $isInternalKeyVisible
            # Fetch internal links only
            set intLinks [getInternalLinks $iface_url($iface) $ch_descr(ADDRESS) $ch_descr(PARENT) $ch_descr(PARENT_TYPE)]
            
            # nicht ausf�hren
            set comment {
              if {[llength $intLinks] == 0} {
               xmlrpc $iface_url($iface) clearConfigCache $ch_descr(ADDRESS)
               set intLinks [getInternalLinks $iface_url($iface) $ch_descr(ADDRESS) $ch_descr(PARENT)]
              }
            } 
            set intPeers [getInternalPeers $iface_url($iface) $ch_descr(ADDRESS) $ch_descr(PARENT)]
                
            # don't delete this
            append s "<div id=\"chType_$counter\" style=\"display:none\">$ch_descr(TYPE)</div>"
            append s "<div id=\"chParamID_$counter\" style=\"display:none\">$ch_paramid</div>"
            append s "<div id=\"chInternalPeers_$counter\" style=\"display:none\">$intPeers</div>" 
           
            # Iterate through each internal link
            set loop 1 
            foreach _link $intLinks {

              array set link $_link 
              set sender $link(SENDER)
              set receiver $link(RECEIVER)
             
              # wichtig f. freie Werteingabe
              array set dev_descr_sender [array get ch_descr] 
              
              # original channelparam
              if {$loop == 1 && ([isVirtual $ch_paramid] == "false")} {  
                append s [put_orig_channel_parameter $ch_address $ch_descr(INDEX)] 
              }
              # end original channelparam

              if {([isVirtual $ch_paramid] == "false")} {
                if { [catch { array set ch_descr [xmlrpc $iface_url($iface) getDeviceDescription [list string $sender]] } ] } then { 
                  #continue
                } 
                catch {source $env(DOCUMENT_ROOT)/config/easymodes/$ch_paramid.tcl}
              } 
        
              if {[isVirtual $ch_paramid] == "true"} { 
                if { [catch { array set ch_descr [xmlrpc $iface_url($iface) getDeviceDescription [list string $sender]] } ] } then { 
                  continue
                }
                catch {source $env(DOCUMENT_ROOT)/config/easymodes/$ch_paramid.tcl} 
              }

              array_clear receiver_ps
              array set receiver_ps [xmlrpc $iface_url($iface) getParamset [list string $receiver] [list string $sender]]
              array set ps_descr_receiver [xmlrpc $iface_url($iface) getParamsetDescription [list string $receiver] [list string $sender]]

              ## EASYMODE_WRAPPER              
              append s "<div class=\"easymode_wrapper\">"

              #set special_input_id "receiver_$counter\_$ch_descr(INDEX)"
              set special_input_id "receiver_$counter\_$loop"
              
              set receiver_ps(UI_HINT) ""
              set cur_profile [get_cur_profile2 receiver_ps PROFILES_MAP PROFILE_TMP  "KEY"]
              
              set_htmlParams $iface $receiver receiver_ps ps_descr_receiver $special_input_id "KEY"
              recycle_easymodes PROFILES_MAP HTML_PARAMS $special_input_id $cur_profile receiver_ps

              if {[llength $intLinks] == 1} {
                set keyNo ""
              } else {
                set keyNo "$loop."
              }

              #append s "<br/><span class=\"CLASS22015\">Programmierung der $loop. internen Ger&auml;tetaste - $sender</span>"
              append s "<br/><span class=\"CLASS22015_\">\${lblProgrammingOfInternalDeviceKeyA} $keyNo \${lblProgrammingOfInternalDeviceKeyB} - $sender</span>"
              append s "<br/><br/>"
              # die ComboBox der Profilauswahl
              append s "<div id=\"maps_div_$counter\_$loop\"><textarea id=\"maps_textarea_$counter\_$loop\" style=\"display:none\">"
              append s [get_ComboBox2 PROFILES_MAP "receiver_$counter\_$loop\_profiles" "receiver_$counter\_$loop\_profiles" $cur_profile  "onchange=\"ShowInternalKeyProfile(this, $loop, $counter);Disable_SimKey($loop, this.selectedIndex, '${special_input_id}')\""]

              # Folgendes Element kann f�r einen Hilfetooltip innerhalb des Easymodes verwendet werden. Siehe BLIND
              append s "<span id=\"profileHelp\_$counter\_$loop\" class=\"hidden\">&nbsp;&nbsp;<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:22px; height:22px; position:relative; top:2px\"></span>"

              append s "</textarea></div>"
              append s "<script type=\"text/javascript\">translate_map('maps_div_$counter\_$loop', 'maps_textarea_$counter\_$loop');</script>"
            
              append s "<table id=\"internalKey_$counter\_$loop\" class=\"ProfileTbl\">"
            
              foreach pnr [lsort [array names PROFILES_MAP]] {
                append s "<script type=\"text/javascript\">translate('$pnr', '$special_input_id');</script>"
                append s  "<tr class=\"$special_input_id\_$pnr\" [expr {$cur_profile == $pnr?" ":" style=\"visibility:hidden; display:none;\""} ]><td>"
                append s $HTML_PARAMS(separate_$pnr)
              
                if {[isVirtual $ch_paramid] == "false"} {
                  append s "<br/><input type=\"button\" id=\"SimKey_$counter\_$loop\_$pnr\" name=\"btnSimKeyPress\" onclick=\"SendInternalKeyPress('$iface', '$sender', '$receiver')\" value=\"Simuliere Tastendruck\">"
                  if {[info exists simulateLongKeyPress] == 1} {
                    if {$simulateLongKeyPress == 1} {
                      append s "<script type=\"text/javascript\">jQuery(\"#SimKey_$counter\_$loop\_$pnr\").attr(\"name\",\"btnSimShortKeyPress\");</script>"
                      append s "<input type=\"button\" id=\"SimLongKey_$counter\_$loop\_$pnr\" name=\"btnSimLongKeyPress\" onclick=\"SendInternalKeyPress('$iface', '$sender', '$receiver', true)\" value=\"Simuliere langen Tastendruck\">"
                    }
                  }
                  append s  "<br/><div id=\"SimKeyHint_$counter\_$loop\_$pnr\" class=\"attention\" style=\"display:none\">&nbsp;&nbsp;\${lblHintSimulateKeyPress}</div></td>"
                }
                append s  "</tr>"
              }
              append s "</table></div>"
              ## E N D   EASYMODE_WRAPPER


              #Ausgew�hlten Eintrag sichtbar schalten: // pr�fen, ob n�tig
              #append s "<div>\$('receiver_$counter\_$loop\_profiles')</div>"
              #append s   "<script type=\"text/javascript\">ShowInternalKeyProfile(\$('receiver_$counter\_$loop\_profiles'), '$loop', '$counter');</script>"

              incr loop
            } 
          } else { set s " \${deviceAndChannelParamsLblHintTrouble}"}

        } else {
          #if {$internalKey != 1} 
            array set dev_descr_sender [array get ch_descr] 
          
            # original channelparam
            append s [put_orig_channel_parameter $ch_address $ch_descr(INDEX)] 
            append s "<script type=\"text/javascript\">st_setStringTableValues();</script>"
            # end original channelparam
          #end if internalKey 
        }
      } 
      check_RF_links $dev_descr(TYPE) $iface $ch_descr(ADDRESS) $ch_descr(INDEX) $ch_descr(TYPE) $ise_CHANNELNAMES($iface;$ch_descr(ADDRESS))
      array_clear ch_ps
      destructor

    } else {
      catch { set s [cmd_link_paramset $iface $ch_descr(ADDRESS) MASTER MASTER CHANNEL_$ch_descr(INDEX)] }
      set wired [string range $dev_descr(TYPE) 0 [expr [string first "-" $dev_descr(TYPE)] -1]]
      if {$wired == "HMW"} {
        # prueft, ob Verkn�pfungen vorhanden sind und sperrt ggf. entsprechende Einstellm�glichkeiten
        check_HMW_links $dev_descr(TYPE) $iface $ch_descr(ADDRESS) $ch_descr(INDEX) $ch_descr(TYPE) 
      }
    }
    
    array set ch_descr [array get ch_descr_orig]
 
    #if {$s == ""} then { set s "<div class=\"CLASS22004\">Keine Parameter einstellbar.</div>" }
    if {$s == ""} then { set s "<div class=\"CLASS22004\">\${deviceAndChannelParamsLblNoParamsToSet}</div>" }

    # virtuelle Kan�le nur anzeigen, wenn im Expertenmodus
    #if {([isVirtual $ch_paramid] == "true") && ([session_is_expert] == 0) }

    catch {
      if {([isVirtual [xmlrpc $iface_url($iface) getParamsetId [list string $ch_descr(ADDRESS)] MASTER]] == "true") && ([session_is_expert] == 0) } {
        set hide_channel 1
      }
    }

    puts "<tr [expr {$hide_channel==1?"style=\"visibility: hidden; display: none\"":""} ] >"
    puts "<td class=\"alignCenter\"><span onmouseover=\"picDivShow(jg_250, '$ch_descr(PARENT_TYPE)', 250, $ch_descr(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $ch_name]</span><span id=\"chDescr_$ch_descr(INDEX)\"></span></td>"
    puts "<td class=\"alignCenter\">Ch.: $ch_descr(INDEX)</td>"
    puts "<td class=\"CLASS22003\">$s</td>"
    puts "</tr>"

    incr tr_count

    puts "<script type='text/javascript'>"
      puts "var ext = getExtendedDescription(\{\"deviceType\" : \"$ch_descr(PARENT_TYPE)\", \"channelType\" : \"$ch_descr(TYPE)\" ,\"channelIndex\" : \"$ch_descr(INDEX)\", \"channelAddress\" : \"$ch_descr(ADDRESS)\" \});"
      puts "jQuery(\"#chDescr_$ch_descr(INDEX)\").html(\"<br/><br/>\" + ext);"
    puts "</script>"
  }

  if {$tr_count == 0} then {
    puts "<tr>"
    #puts "<td colspan=\"3\"><div class=\"CLASS22004\">Keine Parameter einstellbar.</div></td>"
    puts "<td colspan=\"3\"><div class=\"CLASS22004\">\${deviceAndChannelParamsLblNoParamsToSet}</div></td>"
    puts "</tr>"
  }
  
  puts "</TBODY>"

  puts "</table>"

  puts "</div>"
  puts "<script type='text/javascript'>"
  puts "translatePage('#id_channel_parameters');"
  if {[info exists simulateLongKeyPress] == 1} {
    if {$simulateLongKeyPress == 1} {
      puts "translateButtons('btnSimShortKeyPress');"
      puts "translateButtons('btnSimLongKeyPress');"
    } else {
      puts "translateButtons('btnSimKeyPress');"
    }
  } else {
    puts "translateButtons('btnSimKeyPress');"
  }
  puts "jQuery('#id_channel_parameters').show();"
  puts "</script>"
}

proc put_Header {} {

  #cgi_debug -on

  global iface iface_url address iface_descr
  global ise_CHANNELNAMES 
  global dev_descr
  global MODE

  set HmIPIdentifier "HmIP-RF"
  set type $dev_descr(TYPE)

  array set SENTRY ""
  set SENTRY(NAME)        "&nbsp;"
  set SENTRY(TYPE)        $dev_descr(TYPE)
  set SENTRY(IMAGE)       "&nbsp;"
  set SENTRY(DESCRIPTION) $dev_descr(TYPE)
  set SENTRY(ADDRESS)     $address
  set SENTRY(IFACE)       $iface_descr($iface)
  set SENTRY(FIRMWARE)    "&nbsp;"

  if { [catch { set SENTRY(NAME) $ise_CHANNELNAMES($iface;$address)} ] } then {
      set SENTRY(NAME) "$iface"
      append SENTRY(NAME) ".$address"
  }

  set SENTRY(IMAGE) "<div id=\"picDiv_thumb\" class=\"CLASS22005\" onmouseover=\"picDivShow(jg_250, '$dev_descr(TYPE)', 250, '-1', this);\" onmouseout=\"picDivHide(jg_250);\"></div>"
  append SENTRY(IMAGE) "<script type=\"text/javascript\">"
  append SENTRY(IMAGE) "var jg_thumb = new jsGraphics(\"picDiv_thumb\");"
  append SENTRY(IMAGE) "InitGD(jg_thumb, 50);"
  append SENTRY(IMAGE) "Draw(jg_thumb, '$dev_descr(TYPE)', 50, '-1' );"
  append SENTRY(IMAGE) "</script>"

  set SENTRY(FIRMWARE) "<table id=\"id_firmware_table\" cellspacing=\"0\">"
  #append SENTRY(FIRMWARE) "<tr><td>Version:</td><td class=\"CLASS22006\">$dev_descr(FIRMWARE)</td></tr>"
  append SENTRY(FIRMWARE) "<tr><td>\${lblFirmwareVersion}</td><td class=\"CLASS22006\">$dev_descr(FIRMWARE)</td></tr>"
  if {$MODE == "DEVICEPARAMETERS"} then {
    set fw_update_rows ""
    if {$iface != $HmIPIdentifier} {
      catch {
        if {$dev_descr(AVAILABLE_FIRMWARE) != $dev_descr(FIRMWARE)} then {
          #set    fw_update_rows "<tr><td>Verf&uuml;gbare Version:</td><td class=\"CLASS22006\">$dev_descr(AVAILABLE_FIRMWARE)</td></tr>"
          set    fw_update_rows "<tr><td>\${lblAvailableFirmwareVersion}</td><td class=\"CLASS22006\">$dev_descr(AVAILABLE_FIRMWARE)</td></tr>"
          #append fw_update_rows "<tr><td colspan=\"2\" class=\"CLASS22007\"><span onclick=\"FirmwareUpdate();\" class=\"CLASS21000\">Update</span></td></tr>"
          append fw_update_rows "<tr><td colspan=\"2\" class=\"CLASS22007\"><span onclick=\"FirmwareUpdate();\" class=\"CLASS21000\">\${lblUpdate}</span></td></tr>"
        } else {
          #set fw_update_rows "<tr><td colspan=\"2\" class=\"CLASS22008\">(Aktuelle Firmwareversion)</td></tr>"
          set fw_update_rows "<tr><td colspan=\"2\" class=\"CLASS22008\">\${lblActualFirmwareVersion}</td></tr>"
        }
      }
    } else {
      # This is a HmIP device
      if {[catch {set firmwareUpdateState $dev_descr(FIRMWARE_UPDATE_STATE)}] == 0} {

        switch $firmwareUpdateState {
          "PERFORMING_UPDATE" {
            set fw_update_rows "<tr><td class=\"CLASS22006\">\${lblDeviceFwPerformUpdate}</td></tr>"
          }

          "DELIVER_FIRMWARE_IMAGE" {
            set fw_update_rows "<tr><td class=\"CLASS22008\"><div>\${lblDeviceFwDeliverFwImage}</div><div class=\"StdTableBtnHelp\"><img id=\"hmIPDeliverFirmwareHelp\" height=\"24\" width=\"24\"src=\"/ise/img/help.png\"></div></td></tr>"
          }

          "READY_FOR_UPDATE" {
            set fw_update_rows "<tr><td>\${lblAvailableFirmwareVersion}</td><td class=\"CLASS22006\">$dev_descr(AVAILABLE_FIRMWARE)</td></tr>"
            append fw_update_rows "<tr><td colspan=\"2\" class=\"CLASS22007\"><span onclick=\"FirmwareUpdate();\" class=\"CLASS21000\">\${lblUpdate}</span></td></tr>"
          }
        }
      } else {
        # This should never be reached....
        puts "<script type=\"text/javascript\">conInfo(\"HmIP - FIRMWARE_UPDATE_STATE unknown error\");</script>"
      }
    }
    append SENTRY(FIRMWARE) $fw_update_rows

        puts {
          <script type="text/javascript">
            var tooltipHTML = "<div>"+translateKey("tooltipHmIPDeliverFirmwareImage");+"</div>",
            tooltipElem = jQuery("#hmIPDeliverFirmwareHelp") ;
            tooltipElem.data('powertip', tooltipHTML);
            tooltipElem.powerTip({placement: 'sw', followMouse: false});
          </script>
        }

  }
  append SENTRY(FIRMWARE) "</table>"

  puts "<table class=\"CLASS22009 j_translate\" id=\"DeviceInformation\" cellspacing=\"0\">"

  puts "<colgroup>"
  #Name
  puts "  <col width=\"29%\" />"
  #Typenbezeichnung
  puts "  <col width=\"10%\" />"
  #Bild
  puts "  <col width=\"1%\"/>"
  #Bezeichnung
  puts "  <col width=\"30%\" />"
  #SN
  puts "  <col width=\"5%\" />"
  #Interface
  puts "  <col width=\"5%\" />"
  #Firmware
  puts "  <col width=\"15%\" />"
  puts "</colgroup>"
  
  puts "<THEAD>"

  puts "<TR class=\"CLASS22010\">"
  puts "<TD>\${thName}</TD>"
  puts "<TD>\${thTypeDescriptor}</TD>"
  puts "<TD>\${thPicture}</TD>"
  puts "<TD>\${thDescriptor}</TD>"
  puts "<TD>\${thSerialNumber}</TD>"
  puts "<TD>\${thInterface}</TD>"
  puts "<TD>\${thFirmware}</TD>"
  puts "</TR>"
  
  puts "</THEAD>"

  puts "<TBODY>"
      
  puts "<tr>"
  puts "<td>[cgi_quote_html $SENTRY(NAME)]</td>"
  puts "<td>$SENTRY(TYPE)</td>"
  puts "<td id=\"DeviceImage\">$SENTRY(IMAGE)</td>"
  puts "<td id=\"DeviceDescription\">$SENTRY(DESCRIPTION)</td>"
  puts "<td>$SENTRY(ADDRESS)</td>"
  puts "<td>$SENTRY(IFACE)</td>"
  puts "<td>$SENTRY(FIRMWARE)</td>"
  puts "</tr>"

  puts "</TBODY>"

  puts "</table>"

  puts "<script type=\"text/javascript\">"
  puts "\$('DeviceDescription').innerHTML = translateKey(DEV_getDescription('$dev_descr(TYPE)')) + \"&nbsp;\";"
  puts "translatePage('#DeviceInformation');"
  puts "</script>"
}

proc put_NaviButtons {} {

  #cgi_debug -on

  puts "<div class=\"popupControls\">"
  puts "<table id=\"navibuttons\" class=\"CLASS22011\">"
  puts "<tbody>"
  
  puts "<TR>"
  puts "<td class=\"CLASS22012\" onclick=\"SaveDeviceParameters();\"><div class=\"CLASS21000\">OK</div></td>"
  puts "<td class=\"CLASS22012\" onclick=\"CloseDeviceParameters();\"><div class=\"CLASS21000\">Abbrechen</div></td>"
  puts "<td class=\"CLASS22013\">&nbsp;</td>"
  puts "</TR>"

  puts "</tbody>"

  puts "</table>"
  puts "</div>"
}

cgi_eval {

  cgi_input
  #cgi_debug -on

    http_head
    
  if {[session_requestisvalid 0] > 0} then {

    #URL-Parameter----------------------------
    set iface        ""
    set address      ""
    set redirect_url ""
    set with_group   0

    catch {import iface}
    catch {import address}
    catch {import redirect_url}
    catch {import with_group}
    #-----------------------------------------

    #Globale Parameter------------------------
    array set dev_descr ""
    array set dev_ps ""

    #MODE: DEVICEPARAMETERS       - Es werden Ger�teparameter angezeigt und alle Kanalparameter
    #      CHANNELPARAMETERS      - Es werden nur die Kanalparameter eines Kanals angezeigt
    #      CHANNELGROUPPARAMETERS - Wie CHANNELPARAMETERS, aber jetzt auch mit Tastenpaar-Partner
    set MODE ""

    set channel_address ""
    set channel_group   ""

    set dev_paramid  ""
    set dev_PARAMIDS ""
    #-----------------------------------------
      
    if { [catch {array set dev_descr [xmlrpc $iface_url($iface) getDeviceDescription [list string $address]] } ] } then {
      put_error $iface $address
      return
    }

    if {$dev_descr(PARENT) == ""} then {
      
      #address ist Ger�teadresse
      set MODE "DEVICEPARAMETERS"

      #Ger�te-Paramid bestimmen:
      set paramids [xmlrpc $iface_url($iface) getParamsetId $address MASTER]
      set dev_paramid [getExistingParamId $paramids]
      set dev_PARAMIDS $paramids
      catch {array set dev_ps [xmlrpc $iface_url($iface) getParamset [list string $address] [list string MASTER]]}
      #==========
      
    } else {
      
      #address ist Kanaladresse
      set MODE "CHANNELPARAMETERS"
      set channel_address $address
      set address $dev_descr(PARENT)
      
      if { [catch {array set dev_descr [xmlrpc $iface_url($iface) getDeviceDescription [list string $address] ] } ] } then {
        put_error $iface $address
        return
      }

      #Ger�te-Paramid bestimmen:
      set paramids [xmlrpc $iface_url($iface) getParamsetId $address MASTER]
      set dev_paramid [getExistingParamId $paramids]
      set dev_PARAMIDS $paramids
      array set dev_ps [xmlrpc $iface_url($iface) getParamset [list string $address] [list string MASTER]]
      #=====

      if {$with_group == 1} then {
        
        #Informationen �ber den Sender_Group (falls vorhanden)----------
        if { ! [catch { set channel_group $dev_descr(GROUP) } ] } then {
      
          #Es gibt ein Tastenpaar und es soll mit angezeigt werden!
          set MODE "CHANNELGROUPPARAMETERS"
        }
      }
    }

    put_page
  }
}
