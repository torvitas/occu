#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${OpenUp}"
set PROFILES_MAP(2)  "\${CloseDown}"
set PROFILES_MAP(3)  "\${OpenClose_UpDown}"
set PROFILES_MAP(4)  "\${TargetPosition}"


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

set PROFILE_1(SHORT_COND_VALUE_HI) {100 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_OFFDELAY) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_ON) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_ONDELAY) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_RAMPOFF) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_RAMPON) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_REFOFF) {1 range 0 - 5}
set PROFILE_1(SHORT_CT_REFON) {1 range 0 - 5}
set PROFILE_1(SHORT_DRIVING_MODE) {0 1 2 3}
set PROFILE_1(SHORT_JT_OFF) 1
set PROFILE_1(SHORT_JT_OFFDELAY) 1
set PROFILE_1(SHORT_JT_ON) 1
set PROFILE_1(SHORT_JT_ONDELAY) 7
set PROFILE_1(SHORT_JT_RAMPOFF) 6
set PROFILE_1(SHORT_JT_RAMPON) 2
set PROFILE_1(SHORT_JT_REFOFF) 6
set PROFILE_1(SHORT_JT_REFON) 2
set PROFILE_1(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_1(SHORT_MULTIEXECUTE) 0
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_LEVEL) 0.000000
set PROFILE_1(SHORT_OFF_LEVEL_2) 1.010000
set PROFILE_1(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_MODE) 0
set PROFILE_1(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_ON_LEVEL) 1.000000
set PROFILE_1(SHORT_ON_LEVEL_2) 1.010000
set PROFILE_1(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(UI_DESCRIPTION) ""
set PROFILE_1(UI_TEMPLATE)  $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_COND_VALUE_HI) {100 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_2(SHORT_CT_OFF) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_OFFDELAY) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_ON) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_ONDELAY) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_RAMPOFF) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_RAMPON) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_REFOFF) {4 range 0 - 5}
set PROFILE_2(SHORT_CT_REFON) {4 range 0 - 5}
set PROFILE_2(SHORT_DRIVING_MODE) {0 1 2 3}
set PROFILE_2(SHORT_JT_OFF) 4
set PROFILE_2(SHORT_JT_OFFDELAY) 8
set PROFILE_2(SHORT_JT_ON) 4
set PROFILE_2(SHORT_JT_ONDELAY) 4
set PROFILE_2(SHORT_JT_RAMPOFF) 5
set PROFILE_2(SHORT_JT_RAMPON) 3
set PROFILE_2(SHORT_JT_REFOFF) 5
set PROFILE_2(SHORT_JT_REFON) 3
set PROFILE_2(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_2(SHORT_MULTIEXECUTE) 0
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_LEVEL) 0.000000
set PROFILE_2(SHORT_OFF_LEVEL_2) 1.010000
set PROFILE_2(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_MODE) 0
set PROFILE_2(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_ON_LEVEL) 1.000000
set PROFILE_2(SHORT_ON_LEVEL_2) 1.010000
set PROFILE_2(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE) 0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(UI_DESCRIPTION) ""
set PROFILE_2(UI_TEMPLATE)  $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_COND_VALUE_HI) {100 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_OFFDELAY) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_ON) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_ONDELAY) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_RAMPOFF) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_RAMPON) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_REFOFF) {0 range 0 - 5}
set PROFILE_3(SHORT_CT_REFON) {0 range 0 - 5}
set PROFILE_3(SHORT_DRIVING_MODE) {0 1 2 3}
set PROFILE_3(SHORT_JT_OFF) 1
set PROFILE_3(SHORT_JT_OFFDELAY) 8
set PROFILE_3(SHORT_JT_ON) 4
set PROFILE_3(SHORT_JT_ONDELAY) 7
set PROFILE_3(SHORT_JT_RAMPOFF) 6
set PROFILE_3(SHORT_JT_RAMPON) 3
set PROFILE_3(SHORT_JT_REFOFF) 6
set PROFILE_3(SHORT_JT_REFON) 3
set PROFILE_3(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_3(SHORT_MULTIEXECUTE) 0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_LEVEL) 0.000000
set PROFILE_3(SHORT_OFF_LEVEL_2) 1.010000
set PROFILE_3(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_ON_LEVEL) 1.000000
set PROFILE_3(SHORT_ON_LEVEL_2) 1.010000
set PROFILE_3(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE) 0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(UI_DESCRIPTION) ""
set PROFILE_3(UI_TEMPLATE)  $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_COND_VALUE_HI) {200 range 0 - 255}
set PROFILE_4(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_4(SHORT_CT_OFF) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_OFFDELAY) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_ON) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_ONDELAY) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_RAMPOFF) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_RAMPON) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_REFOFF) {0 range 0 - 5}
set PROFILE_4(SHORT_CT_REFON) {0 range 0 - 5}
set PROFILE_4(SHORT_DRIVING_MODE) {0 1 2 3}
set PROFILE_4(SHORT_JT_OFF) {1 5}
set PROFILE_4(SHORT_JT_OFFDELAY) {1 6}
set PROFILE_4(SHORT_JT_ON) {1 5}
set PROFILE_4(SHORT_JT_ONDELAY) {2 5}
set PROFILE_4(SHORT_JT_RAMPOFF) {7 8}
set PROFILE_4(SHORT_JT_RAMPON) {3 4}
set PROFILE_4(SHORT_JT_REFOFF) {7 8}
set PROFILE_4(SHORT_JT_REFON) {3 4}
set PROFILE_4(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_4(SHORT_MULTIEXECUTE) 0
set PROFILE_4(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.01}
set PROFILE_4(SHORT_OFF_LEVEL_2) {1.01 range 0.0 - 1.01}
set PROFILE_4(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(SHORT_OFF_TIME_MODE) 0
set PROFILE_4(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.01}
set PROFILE_4(SHORT_ON_LEVEL_2) {1.01 range 0.0 - 1.01}
set PROFILE_4(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_MODE) 0
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_4(UI_DESCRIPTION) ""
set PROFILE_4(UI_TEMPLATE)  $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

# hier folgen die eventuellen Subsets
#set SUBSET_1(NAME)          "Hochgefahren"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_JT_OFF)      1
set SUBSET_1(SHORT_JT_OFFDELAY)    1
set SUBSET_1(SHORT_JT_ON)      1
set SUBSET_1(SHORT_JT_ONDELAY)    2
set SUBSET_1(SHORT_JT_RAMPOFF)    8
set SUBSET_1(SHORT_JT_RAMPON)    3
set SUBSET_1(SHORT_JT_REFOFF)    8
set SUBSET_1(SHORT_JT_REFON)    3

#set SUBSET_2(NAME)          "Runtergefahren"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_JT_OFF)      5
set SUBSET_2(SHORT_JT_OFFDELAY)    6
set SUBSET_2(SHORT_JT_ON)      5
set SUBSET_2(SHORT_JT_ONDELAY)    5
set SUBSET_2(SHORT_JT_RAMPOFF)    7
set SUBSET_2(SHORT_JT_RAMPON)    4
set SUBSET_2(SHORT_JT_REFOFF)    7
set SUBSET_2(SHORT_JT_REFON)    4

#set SUBSET_3(NAME)          "Hoch-/Runtergefahren im Wechsel"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_JT_OFF)      1
set SUBSET_3(SHORT_JT_OFFDELAY)    6
set SUBSET_3(SHORT_JT_ON)      5
set SUBSET_3(SHORT_JT_ONDELAY)    2
set SUBSET_3(SHORT_JT_RAMPOFF)    8
set SUBSET_3(SHORT_JT_RAMPON)    4
set SUBSET_3(SHORT_JT_REFOFF)    8
set SUBSET_3(SHORT_JT_REFON)    4

##
#set SUBSET_4(NAME)                                          "Offen-Aus/Zu-Ein"
set SUBSET_4(NAME)                                          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE) 4
set SUBSET_4(SHORT_CT_OFF)  2
set SUBSET_4(SHORT_CT_OFFDELAY) 2
set SUBSET_4(SHORT_CT_ON) 0
set SUBSET_4(SHORT_CT_ONDELAY)  0
set SUBSET_4(SHORT_CT_RAMPOFF)  2
set SUBSET_4(SHORT_CT_RAMPON) 0

#set SUBSET_5(NAME)                                          "Offen-Ein/Zu-Aus"
set SUBSET_5(NAME)                                          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE) 5
set SUBSET_5(SHORT_CT_OFF)  0
set SUBSET_5(SHORT_CT_OFFDELAY) 2
set SUBSET_5(SHORT_CT_ON) 2
set SUBSET_5(SHORT_CT_ONDELAY) 0
set SUBSET_5(SHORT_CT_RAMPOFF) 2
set SUBSET_5(SHORT_CT_RAMPON) 0

#set SUBSET_6(NAME)                                          "Schlie�en"
set SUBSET_6(NAME)                                          "\${subset_6}"
set SUBSET_6(SUBSET_OPTION_VALUE) 6
set SUBSET_6(SHORT_CT_OFF)  2
set SUBSET_6(SHORT_CT_OFFDELAY) 2
set SUBSET_6(SHORT_CT_ON) 2
set SUBSET_6(SHORT_CT_ONDELAY)  2
set SUBSET_6(SHORT_CT_RAMPOFF)  2
set SUBSET_6(SHORT_CT_RAMPON) 2

#set SUBSET_7(NAME)                                          "�ffnen"
set SUBSET_7(NAME)                                          "\${subset_7}"
set SUBSET_7(SUBSET_OPTION_VALUE) 7
set SUBSET_7(SHORT_CT_OFF)  0
set SUBSET_7(SHORT_CT_OFFDELAY) 0
set SUBSET_7(SHORT_CT_ON) 0
set SUBSET_7(SHORT_CT_ONDELAY)  0
set SUBSET_7(SHORT_CT_RAMPOFF)  0
set SUBSET_7(SHORT_CT_RAMPON) 0

#set SUBSET_8(NAME)                                          "�ndern"
set SUBSET_8(NAME)                                          "\${subset_8}"
set SUBSET_8(SUBSET_OPTION_VALUE) 8
set SUBSET_8(SHORT_CT_OFF)      0
set SUBSET_8(SHORT_CT_OFFDELAY) 0
set SUBSET_8(SHORT_CT_ON)       0
set SUBSET_8(SHORT_CT_ONDELAY)  0
set SUBSET_8(SHORT_CT_RAMPOFF)  0
set SUBSET_8(SHORT_CT_RAMPON)   0
set SUBSET_8(SHORT_CT_REFOFF)   0
set SUBSET_8(SHORT_CT_REFON)    0

# OFFEN
set SUBSET_9(NAME)                                          "\${subset_9}"
set SUBSET_9(SUBSET_OPTION_VALUE) 9
set SUBSET_9(SHORT_CT_OFF)      1
set SUBSET_9(SHORT_CT_OFFDELAY) 1
set SUBSET_9(SHORT_CT_ON)       1
set SUBSET_9(SHORT_CT_ONDELAY)  1
set SUBSET_9(SHORT_CT_RAMPOFF)  1
set SUBSET_9(SHORT_CT_RAMPON)   1
set SUBSET_9(SHORT_CT_REFOFF)   1
set SUBSET_9(SHORT_CT_REFON)    1

# ZU
set SUBSET_10(NAME)                                         "\${subset_10}"
set SUBSET_10(SUBSET_OPTION_VALUE) 10
set SUBSET_10(SHORT_CT_OFF)       4
set SUBSET_10(SHORT_CT_OFFDELAY)  4
set SUBSET_10(SHORT_CT_ON)        4
set SUBSET_10(SHORT_CT_ONDELAY)   4
set SUBSET_10(SHORT_CT_RAMPOFF)   4
set SUBSET_10(SHORT_CT_RAMPON)    4
set SUBSET_10(SHORT_CT_REFOFF)    4
set SUBSET_10(SHORT_CT_REFON)     4

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url dev_descr_sender dev_descr_receiver

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set device $dev_descr_sender(TYPE)
  set ch $dev_descr_sender(INDEX)

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

  # Set SHORT_COND_VALUE_HI/LO to the value of the configuration parameters COND_TX_DECISION_ABOVE/BELOW
  array set sender_descrMaster [xmlrpc $iface_url($iface) getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
  set condTXDecisionAbove $sender_descrMaster(COND_TX_DECISION_ABOVE)
  set condTXDecisionBelow $sender_descrMaster(COND_TX_DECISION_BELOW)
  set decisionValues "
   {SHORT_COND_VALUE_HI {int $condTXDecisionAbove}}
   {SHORT_COND_VALUE_LO {int $condTXDecisionBelow}}"
  puts "[xmlrpc $iface_url($iface) putParamset [list string $address] [list string $dev_descr_sender(ADDRESS)] [list struct $decisionValues]]"
  set ps(SHORT_COND_VALUE_HI) $condTXDecisionAbove
  set ps(SHORT_COND_VALUE_LO) $condTXDecisionBelow

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

# die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"



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
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"

  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_9 SUBSET_10 SUBSET_8} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  #OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_9 SUBSET_10 SUBSET_8} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  #ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#3
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  # append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_6 SUBSET_7 SUBSET_8} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_9 SUBSET_10 SUBSET_8} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  #OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#4 jalousie target position
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  # parameter
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  # append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_6 SUBSET_7 SUBSET_8} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_9 SUBSET_10 SUBSET_8} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref;
  append HTML_PARAMS(separate_$prn) "<tr><td>\${JUMPTARGET}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn "onchange=\"BLIND_setPosition('separate_${special_input_id}_$prn\_2');jalousieShowSlatInputElem('separate_${special_input_id}_$prn\_2', $ch);\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DRIVING_MODE}</td><td>"
  array_clear options
  set options(0) "\${driving_mode_0}"
  set options(1) "\${driving_mode_1}"
  set options(2) "\${driving_mode_2}"
  set options(3) "\${driving_mode_3}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_DRIVING_MODE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_DRIVING_MODE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"upLevel_${special_input_id}_$prn\_2\"><td>\${UP_LEVEL}</td>"
  append HTML_PARAMS(separate_$prn) "<td>"
  option BLIND_LEVEL
  #set options(1.005) "\${lastValue}"
  #set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_4 PROFILE_$prn SHORT_ON_LEVEL "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"downLevel_${special_input_id}_$prn\_2\"><td>\${DOWN_LEVEL}</td>"
  append HTML_PARAMS(separate_$prn) "<td>"
  option BLIND_LEVEL
  #set options(1.005) "\${lastValue}"
  #set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_5 PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG id=\"upTime_${special_input_id}_$prn\_2\"]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG id=\"downTime_${special_input_id}_$prn\_2\"]"

  # ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG id=\"upDelayTime_${special_input_id}_$prn\_2\"]"

  # OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG id=\"downDelayTime_${special_input_id}_$prn\_2\"]"


  incr pref ;# 9
  append HTML_PARAMS(separate_$prn) "<tr id='jalousieSlatPosOff_$ch' class='hidden'><td>\${JALOUSIE_SLAT_POS_OFF}</td><td>"
  option BLIND_LEVEL
  #set options(1.005) "\${lastValue}"
  #set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL_2 separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL_2 "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 10
  append HTML_PARAMS(separate_$prn) "<tr id='jalousieSlatPosOn_$ch' class='hidden'><td>\${JALOUSIE_SLAT_POS_ON}</td><td>"
  option BLIND_LEVEL
  #set options(1.005) "\${lastValue}"
  #set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL_2 separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL_2 "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"


  # parameter end

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">window.setTimeout(function() {BLIND_setPosition('separate_${special_input_id}_$prn\_2');jalousieShowSlatInputElem('separate_${special_input_id}_$prn\_2', $ch);},200)</script>"

}

constructor
