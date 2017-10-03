#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/SWITCH/mapping/WEATHER_map.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on_off}"
set PROFILES_MAP(2)  "\${switch_on}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_CT_OFFDELAY)  0
set PROFILE_1(SHORT_CT_ONDELAY)    2 
set PROFILE_1(SHORT_CT_OFF)      0
set PROFILE_1(SHORT_CT_ON)      2
set PROFILE_1(SHORT_COND_VALUE_LO)  {5 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_HI)  {25 range 0 - 255}
set PROFILE_1(SHORT_ONDELAY_TIME)  0
set PROFILE_1(SHORT_ON_TIME)    {111600 range 0.0 - 111600.0}
set PROFILE_1(SHORT_OFFDELAY_TIME)  0
set PROFILE_1(SHORT_OFF_TIME)    111600
set PROFILE_1(SHORT_ON_TIME_MODE)  0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_ACTION_TYPE)  1
set PROFILE_1(SHORT_JT_OFF)      1
set PROFILE_1(SHORT_JT_ON)      3 
set PROFILE_1(SHORT_JT_OFFDELAY)  2 
set PROFILE_1(SHORT_JT_ONDELAY)    4  
set PROFILE_1(UI_DESCRIPTION)  "Bei starkem Wind wird der Schalter ein- und bei schwachem Wind ausgeschaltet. Die Schaltzuordnung l&auml;sst sich auch umkehren."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_CT_OFFDELAY)  1
set PROFILE_2(SHORT_CT_ONDELAY)   1
set PROFILE_2(SHORT_CT_OFF)       1
set PROFILE_2(SHORT_CT_ON)        1
set PROFILE_2(SHORT_COND_VALUE_LO)  {5 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_HI)  {25 range 0 - 255}
set PROFILE_2(SHORT_ONDELAY_TIME)  0
set PROFILE_2(SHORT_ON_TIME)    {111600 range 0.0 - 111600.0}
set PROFILE_2(SHORT_OFFDELAY_TIME)  0
set PROFILE_2(SHORT_OFF_TIME)    111600
set PROFILE_2(SHORT_ON_TIME_MODE)  0
set PROFILE_2(SHORT_OFF_TIME_MODE)  0
set PROFILE_2(SHORT_ACTION_TYPE)  1
set PROFILE_2(SHORT_JT_OFF)      1
set PROFILE_2(SHORT_JT_ON)      2
set PROFILE_2(SHORT_JT_OFFDELAY)  2
set PROFILE_2(SHORT_JT_ONDELAY)    2
set PROFILE_2(UI_DESCRIPTION)  "Wenn die eingestellte Windgeschwindigkeit erreicht wird, schaltet der Schalter f&uuml;r die eingestellte Zeit ein."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2


#set SUBSET_1(NAME)          "Wind stark - Aus / Wind schwach - Ein"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      2
set SUBSET_1(SHORT_CT_OFFDELAY)    2
set SUBSET_1(SHORT_CT_ON)      1
set SUBSET_1(SHORT_CT_ONDELAY)   1

#set SUBSET_2(NAME)          "Wind stark - Ein / Wind schwach - Aus"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SHORT_CT_OFF)      1
set SUBSET_2(SHORT_CT_OFFDELAY)    1
set SUBSET_2(SHORT_CT_ON)      2
set SUBSET_2(SHORT_CT_ONDELAY)    2

set comment {
  # This is for the new HM-WDS100-C6-O-2
  # This device is using other conditions than the old device
  set SUBSET_3(SUBSET_OPTION_VALUE)  3
  set SUBSET_3(NAME)          "hidden element"
  set SUBSET_3(SHORT_CT_OFF)      1
  set SUBSET_3(SHORT_CT_OFFDELAY)    1
  set SUBSET_3(SHORT_CT_ON)      1
  set SUBSET_3(SHORT_CT_ONDELAY)    1
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }
       
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
  #global SUBSETS
  set name "x"
  set i 1
  while {$name != ""} {
    upvar SUBSET_$i SUBSET_$i
    array set subset [array get SUBSET_$i]
    set name ""
    catch {set name $subset(NAME)}
    array_clear subset
    incr i
  }

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  set prn 0  
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"
#1
  incr prn
  if {$cur_profile == $prn} then {
    # ermittelt die Schaltrichtung und setzt entsprechend die Beschriftung im Sender     
    append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">WEATHER_change_thres('$prn\_1');</script>"
    array set PROFILE_$prn [array get ps]
  }
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\" >"


  set pref 1

    append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIR}</td><td>"
    append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn "onchange=\"WEATHER_change_thres('$prn\_1')\""]
    append HTML_PARAMS(separate_$prn) "</td></tr>"


  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 5
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"


    incr pref ;# 6
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"SHORT_COND_VALUE_LO\"></td></tr>"
    incr pref ;# 7
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"SHORT_COND_VALUE_HI\"></td></tr>"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2  
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

#  set pref 1

set comment {
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td></td><td>"
    append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
    append HTML_PARAMS(separate_$prn) "</td></tr>"
}

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref;# 2

  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"


  incr pref;# 3
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"SHORT_COND_VALUE_LO\"></td></tr>"
  incr pref;# 4
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"SHORT_COND_VALUE_HI\"></td></tr>"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_1) "var stormLowerThresholdElm = jQuery(\"\[name='__STORM_LOWER_THRESHOLD'\]\").first();"
        append HTML_PARAMS(separate_1) "var stormUpperThresholdElm = jQuery(\"\[name='__STORM_UPPER_THRESHOLD'\]\").first();"

        # The Expert Mode is not active
        append HTML_PARAMS(separate_1) "if (stormUpperThresholdElm.length == 0) \{"
          append HTML_PARAMS(separate_1) "var stormUpperThresholdElm = jQuery(\"\[name='STORM_UPPER_THRESHOLD'\]\").first();"
          append HTML_PARAMS(separate_1) "var stormLowerThresholdElm = jQuery(\"\[name='STORM_LOWER_THRESHOLD'\]\").first();"
        append HTML_PARAMS(separate_1) "\}"

        append HTML_PARAMS(separate_1) "var condValLoElm1 = jQuery(\"#separate_receiver_1_6\");"
        append HTML_PARAMS(separate_1) "var condValHiElm1 = jQuery(\"#separate_receiver_1_7\");"
        append HTML_PARAMS(separate_1) "condValLoElm1.val(stormLowerThresholdElm.val());"
        append HTML_PARAMS(separate_1) "condValHiElm1.val(stormUpperThresholdElm.val());"
      append HTML_PARAMS(separate_1) "</script>"

      append HTML_PARAMS(separate_2) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_2) "var stormLowerThresholdElm = jQuery(\"\[name='__STORM_LOWER_THRESHOLD'\]\").first();"
        append HTML_PARAMS(separate_2) "var stormUpperThresholdElm = jQuery(\"\[name='__STORM_UPPER_THRESHOLD'\]\").first();"

      # When The Expert Mode is not active
      append HTML_PARAMS(separate_2) "if (stormUpperThresholdElm.length == 0) \{"
        append HTML_PARAMS(separate_2) "var stormUpperThresholdElm = jQuery(\"\[name='STORM_UPPER_THRESHOLD'\]\").first();"
        append HTML_PARAMS(separate_2) "var stormLowerThresholdElm = jQuery(\"\[name='STORM_LOWER_THRESHOLD'\]\").first();"
      append HTML_PARAMS(separate_2) "\}"

        append HTML_PARAMS(separate_2) "var condValLoElm2 = jQuery(\"#separate_receiver_2_3\");"
        append HTML_PARAMS(separate_2) "var condValHiElm2 = jQuery(\"#separate_receiver_2_4\");"
        append HTML_PARAMS(separate_2) "condValLoElm2.val(stormLowerThresholdElm.val());"
        append HTML_PARAMS(separate_2) "condValHiElm2.val(stormUpperThresholdElm.val());"
      append HTML_PARAMS(separate_2) "</script>"
}

constructor
