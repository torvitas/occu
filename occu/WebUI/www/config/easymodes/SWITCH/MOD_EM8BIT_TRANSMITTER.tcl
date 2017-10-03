#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on_off}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)  "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

set PROFILE_1(SHORT_CT_OFFDELAY)  0
set PROFILE_1(SHORT_CT_ONDELAY)    2
set PROFILE_1(SHORT_CT_OFF)      0
set PROFILE_1(SHORT_CT_ON)      2
set PROFILE_1(SHORT_COND_VALUE_LO)  {50 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_HI)  {180 range 0 - 255}
set PROFILE_1(SHORT_ONDELAY_TIME)  0
set PROFILE_1(SHORT_ON_TIME)    {111600 range 0.0 - 111600.0}
set PROFILE_1(SHORT_OFFDELAY_TIME)  0
set PROFILE_1(SHORT_OFF_TIME)    111600
set PROFILE_1(SHORT_ON_TIME_MODE)  0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_ACTION_TYPE)  1
set PROFILE_1(SHORT_JT_OFF)      1
set PROFILE_1(SHORT_JT_ON)       {3 4} ;# bei direkter Verkn. wird 3 eingetragen, bei Zentralenverkn. wird 4 eingetragen 
set PROFILE_1(SHORT_JT_OFFDELAY)  2
set PROFILE_1(SHORT_JT_ONDELAY)    {3 4} ;# siehe SHORT_JT_ON
set PROFILE_1(UI_DEFINITION_1_1)  ""
set PROFILE_1(UI_DEFINITION_1_2)  ""
set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)  
set PROFILE_1(UI_HINT)  1

set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFFDELAY)    2
set SUBSET_1(SHORT_CT_ONDELAY)    0
set SUBSET_1(SHORT_CT_OFF)      2
set SUBSET_1(SHORT_CT_ON)      0

set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFFDELAY)    0
set SUBSET_2(SHORT_CT_ONDELAY)    2
set SUBSET_2(SHORT_CT_OFF)      0
set SUBSET_2(SHORT_CT_ON)      2


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
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

  set min 0
  set max 255
  set minMaxDescr "($min - $max)"

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  set prn 0  
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

  #1
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"

  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIRECTION}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

set comment {
  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "<td>\${thresholdON}</td>"
    set id "separate_${special_input_id}_$prn\_$pref"
    append HTML_PARAMS(separate_$prn) "<td><input type=\"text\" id=\"$id\" name=\"SHORT_COND_VALUE_HI\" value=\"$ps(SHORT_COND_VALUE_HI)\" size=5 onchange=\"ProofFreeValue(\'$id\', $min, $max);\">&nbsp;$minMaxDescr</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
}

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "<td>\${threshold}</td>"
    set id "separate_${special_input_id}_$prn\_$pref"
    append HTML_PARAMS(separate_$prn) "<td><input type=\"text\" id=\"$id\" name=\"SHORT_COND_VALUE_LO\" value=\"$ps(SHORT_COND_VALUE_LO)\" size=5 onchange=\"ProofFreeValue(\'$id\', $min, $max);\">&nbsp;$minMaxDescr</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  
  incr pref ;# 3
  append HTML_PARAMS(separate_$prn)  "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  incr pref ;# 4
  append HTML_PARAMS(separate_$prn)  "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 5
  append HTML_PARAMS(separate_$prn)  "<tr><td>\${OFFDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn)  "</td></tr>"

  incr pref ;# 6
  append HTML_PARAMS(separate_$prn)  "<tr><td>\${OFF_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
  append HTML_PARAMS(separate_$prn)  "</td></tr>"
  
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

}

constructor
