#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
# source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_md.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_alarmsiren.tcl]


set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on}"
set PROFILES_MAP(2)  "\${no_action}"


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)  "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)    "Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(LONG_ACTION_TYPE_SIRPAN)  1
set PROFILE_1(LONG_COND_VALUE_HI_SIRPAN)  180
set PROFILE_1(LONG_COND_VALUE_LO_SIRPAN)  1
set PROFILE_1(LONG_CT_OFF_SIRPAN)  0
set PROFILE_1(LONG_CT_OFFDELAY_SIRPAN)  0
set PROFILE_1(LONG_CT_ON_SIRPAN)  0
set PROFILE_1(LONG_CT_ONDELAY_SIRPAN)  0
set PROFILE_1(LONG_JT_OFF_SIRPAN)  1
set PROFILE_1(LONG_JT_OFFDELAY_SIRPAN)  2
set PROFILE_1(LONG_JT_ON_SIRPAN)  2
set PROFILE_1(LONG_JT_ONDELAY_SIRPAN)  2
set PROFILE_1(LONG_OFF_TIME_SIRPAN)  111600
set PROFILE_1(LONG_OFF_TIME_MODE_SIRPAN)  0
set PROFILE_1(LONG_OFFDELAY_TIME_SIRPAN)  0
set PROFILE_1(LONG_ON_TIME_SIRPAN)  120
set PROFILE_1(LONG_ON_TIME_MODE_SIRPAN)  0
set PROFILE_1(LONG_ON_LEVEL_SIRPAN)  50
set PROFILE_1(LONG_ONDELAY_TIME_SIRPAN)  0
set PROFILE_1(LONG_MULTIEXECUTE_SIRPAN)  1

set PROFILE_1(SHORT_ACTION_TYPE_SIRPAN)  1
set PROFILE_1(SHORT_COND_VALUE_HI_SIRPAN)  180
set PROFILE_1(SHORT_COND_VALUE_LO_SIRPAN)  255
set PROFILE_1(SHORT_CT_OFF_SIRPAN)  2
set PROFILE_1(SHORT_CT_OFFDELAY_SIRPAN)  2
set PROFILE_1(SHORT_CT_ON_SIRPAN)  2
set PROFILE_1(SHORT_CT_ONDELAY_SIRPAN)  2
set PROFILE_1(SHORT_JT_OFF_SIRPAN)  1
set PROFILE_1(SHORT_JT_OFFDELAY_SIRPAN)  2
set PROFILE_1(SHORT_JT_ON_SIRPAN)  2
set PROFILE_1(SHORT_JT_ONDELAY_SIRPAN)  2
set PROFILE_1(SHORT_OFF_TIME_SIRPAN)  111600
set PROFILE_1(SHORT_OFF_TIME_MODE_SIRPAN)  0
set PROFILE_1(SHORT_OFFDELAY_TIME_SIRPAN)  0
set PROFILE_1(SHORT_ON_TIME_SIRPAN)  120
set PROFILE_1(SHORT_ON_TIME_MODE_SIRPAN)  0
set PROFILE_1(SHORT_ON_LEVEL_SIRPAN)  200
set PROFILE_1(SHORT_ONDELAY_TIME_SIRPAN)  0
set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1


set PROFILE_2(SHORT_ACTION_TYPE_SIRPAN) 0
set PROFILE_2(SHORT_JT_OFF_SIRPAN)      0
set PROFILE_2(SHORT_JT_ON_SIRPAN)      0
set PROFILE_2(SHORT_JT_OFFDELAY_SIRPAN)  0
set PROFILE_2(SHORT_JT_ONDELAY_SIRPAN)    0
set PROFILE_2(UI_DESCRIPTION)  "Der Bewegungsmelder ist au&szlig;er Betrieb."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

# hier folgen die eventuellen Subsets


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global url receiver_address sender_address  dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr
  
  
  set sender_addr $sender_address
  puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$sender_addr\">"   

  array set dev_ps [xmlrpc $url getParamset $sender_address MASTER]
  
  set  min_interval 4

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

#1  Alarm Ein
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME_MODE}</td><td>"
  array_clear options 
  set options(0) "\${absolute}"
  set options(1) "\${minimal}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_MODE_SIRPAN separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME_MODE_SIRPAN "onchange=\"MD_checkPNAME('separate_${special_input_id}_1_1','md_verweildauer_1_2', 'separate_${special_input_id}_1_2');\""]
  append HTML_PARAMS(separate_$prn) "&nbsp<input type=\"button\"  value=\${help} onclick=\"MD_link_help();\">"

  # absolut_minimal enthaelt den derzeitigen Modus der Verweildauer
  # 0 entspricht 'absolut', 1 entspricht 'minimal'
  set absolut_minimal  $ps(SHORT_ON_TIME_MODE_SIRPAN)
  # Mindestsendeabstand min_interval = Wert 0, 1, 2, 3, 4 >>> 0 = 15s, 1 = 30s, 2 = 60s, 3 = 120s, 4 = 240s
  set min_interval $dev_ps(MIN_INTERVAL)
  puts "<input type=\"hidden\" id=\"md_min_interval_$prn\_1\" value=\"$min_interval,$absolut_minimal\">"
  append HTML_PARAMS(separate_$prn) "<tr><td><span class=\"translated\" id=\"md_verweildauer_$prn\_2\">&nbsp;</span></td><td>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">MD_checkPNAME('separate_${special_input_id}_$prn\_1','md_verweildauer_$prn\_2', 'separate_${special_input_id}_$prn\_2');</script>"
  incr pref ;# 2
  # if {$min_interval == 4} then {option LENGTH_OF_STAY_classic} else {option LENGTH_OF_STAY_dynamic_$min_interval}
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_SIRPAN separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME_SIRPAN "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME_SIRPAN
  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\"><span class=\"CLASS20100\" id=\"separate_${special_input_id}_$prn\_2_hint0\">&nbsp</span></td></tr>"  
  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\"><span class=\"CLASS20100\" id=\"separate_${special_input_id}_$prn\_2_hint1\">&nbsp</span></td></tr>"  
  
  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME_SIRPAN separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME_SIRPAN "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME_SIRPAN
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
  
  # Brightness
  incr pref ;# 4
  catch {EnterBrightness $prn $pref ${special_input_id} ps ps_descr SHORT_COND_VALUE_LO_SIRPAN}


#2
  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor
