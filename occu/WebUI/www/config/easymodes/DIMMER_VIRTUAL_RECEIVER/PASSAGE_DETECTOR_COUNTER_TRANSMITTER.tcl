#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1) "\${dimmer_toggle}"
set PROFILES_MAP(2)  "\${dimmer_on_off}"
set PROFILES_MAP(3) "\${dimmer_on}"
set PROFILES_MAP(4) "\${dimmer_off}"
set PROFILES_MAP(5)  "\${no_action}"


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_COND_VALUE_HI)  {100 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO)  {50 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF)      {0 range 0 - 5}
set PROFILE_1(SHORT_CT_OFFDELAY)  {0 range 0 - 5}
set PROFILE_1(SHORT_CT_ON)      {0 range 0 - 5}
set PROFILE_1(SHORT_CT_ONDELAY)    {0 range 0 - 5}
set PROFILE_1(SHORT_CT_RAMPOFF)   {0 range 0 - 5}
set PROFILE_1(SHORT_CT_RAMPON)    {0 range 0 - 5}
set PROFILE_1(SHORT_JT_OFF)       1
set PROFILE_1(SHORT_JT_OFFDELAY)  5
set PROFILE_1(SHORT_JT_ON)        4
set PROFILE_1(SHORT_JT_ONDELAY)   2
set PROFILE_1(SHORT_JT_RAMPOFF)   6
set PROFILE_1(SHORT_JT_RAMPON)    3
set PROFILE_1(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_1(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE)             0
set PROFILE_1(SHORT_OFF_TIME_MODE)            0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_1(UI_DESCRIPTION)  "Bei Empfang des Entscheidungswert wird der Dimmer in den entgegengesetzten Zustand versetzt."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_COND_VALUE_HI)          149 ;# match with profile 4
set PROFILE_2(SHORT_COND_VALUE_HI)          {99 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_LO)          {50 range 0 - 255}
set PROFILE_2(SHORT_CT_OFF)                 {0 range 0 - 5}
set PROFILE_2(SHORT_CT_OFFDELAY)            {0 range 0 - 5}
set PROFILE_2(SHORT_CT_ON)                  {0 range 0 - 5}
set PROFILE_2(SHORT_CT_ONDELAY)             {0 range 0 - 5}
set PROFILE_2(SHORT_CT_RAMPOFF)             {0 range 0 - 5}
set PROFILE_2(SHORT_CT_RAMPON)              {0 range 0 - 5}
set PROFILE_2(SHORT_JT_OFF)                 {1 range 0 - 6}
set PROFILE_2(SHORT_JT_OFFDELAY)            {3 range 0 - 6}
set PROFILE_2(SHORT_JT_ON)                  {4 range 1 - 6}
set PROFILE_2(SHORT_JT_ONDELAY)             {6 range 1 - 6}
set PROFILE_2(SHORT_JT_RAMPOFF)             {3 range 0 - 6}
set PROFILE_2(SHORT_JT_RAMPON)              {6 range 0 - 6}
set PROFILE_2(SHORT_ON_LEVEL)               {1.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_OFF_LEVEL)              {0.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE)     {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR)   {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_BASE)          {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR)        {31 range 0 - 31}
set PROFILE_2(SHORT_ONDELAY_TIME_BASE)      {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR)    {0 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_BASE)           {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR)         {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE)           0
set PROFILE_2(SHORT_OFF_TIME_MODE)          0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE)    1
set PROFILE_2(UI_DESCRIPTION)  "Bei Empfang des Entscheidungswert wird der Dimmer ein-/ausgeschaltet."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_COND_VALUE_HI)          {100 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO)          {50 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF)                   {0 range 0 - 5}
set PROFILE_3(SHORT_CT_OFFDELAY)              {0 range 0 - 5}
set PROFILE_3(SHORT_CT_ON)                    {0 range 0 - 5}
set PROFILE_3(SHORT_CT_ONDELAY)               {0 range 0 - 5}
set PROFILE_3(SHORT_CT_RAMPOFF)               {0 range 0 - 5}
set PROFILE_3(SHORT_CT_RAMPON)                {0 range 0 - 5}
set PROFILE_3(SHORT_JT_OFF)                   1
set PROFILE_3(SHORT_JT_OFFDELAY)              3
set PROFILE_3(SHORT_JT_ON)                    3
set PROFILE_3(SHORT_JT_ONDELAY)               3
set PROFILE_3(SHORT_JT_RAMPOFF)               3
set PROFILE_3(SHORT_JT_RAMPON)                3
set PROFILE_3(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_MULTIEXECUTE)             0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE)       0
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR)     0
set PROFILE_3(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE)            0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE)             0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_3(UI_DESCRIPTION)  "Bei Empfang des Entscheidungswert wird der Dimmer f&uuml;r eine bestimmte Zeit eingeschaltet."
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(LONG_COND_VALUE_HI)           150 ;# match with profile 2
set PROFILE_4(SHORT_COND_VALUE_HI)          {100 range 0 - 255}
set PROFILE_4(SHORT_COND_VALUE_LO)          {50 range 0 - 255}
set PROFILE_4(SHORT_CT_OFF)                   {0 range 0 - 5}
set PROFILE_4(SHORT_CT_OFFDELAY)              {0 range 0 - 5}
set PROFILE_4(SHORT_CT_ON)                    {0 range 0 - 5}
set PROFILE_4(SHORT_CT_ONDELAY)               {0 range 0 - 5}
set PROFILE_4(SHORT_CT_RAMPOFF)               {0 range 0 - 5}
set PROFILE_4(SHORT_CT_RAMPON)                {0 range 0 - 5}
set PROFILE_4(SHORT_JT_OFF)                   6
set PROFILE_4(SHORT_JT_OFFDELAY)              6
set PROFILE_4(SHORT_JT_ON)                    4
set PROFILE_4(SHORT_JT_ONDELAY)               6
set PROFILE_4(SHORT_JT_RAMPON)                6
set PROFILE_4(SHORT_JT_RAMPOFF)               6
set PROFILE_4(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_4(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_4(SHORT_MULTIEXECUTE)             0
set PROFILE_4(SHORT_OFFDELAY_TIME_BASE)       0
set PROFILE_4(SHORT_OFFDELAY_TIME_FACTOR)     0
set PROFILE_4(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_4(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_4(SHORT_OFF_TIME_MODE)            0
set PROFILE_4(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_4(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_MODE)             0
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_4(UI_DESCRIPTION)  "Bei Erkennung des &Auml;nderungssignals wird der Dimmer f&uuml;r eine bestimmte Zeit ausgeschaltet."
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

set PROFILE_5(SHORT_JT_OFF)      0
set PROFILE_5(SHORT_JT_ON)      0
set PROFILE_5(SHORT_JT_OFFDELAY)  0
set PROFILE_5(SHORT_JT_ONDELAY)    0
set PROFILE_5(SHORT_JT_RAMPOFF)    0
set PROFILE_5(SHORT_JT_RAMPON)    0
set PROFILE_5(SHORT_JT_REFOFF)    0
set PROFILE_5(SHORT_JT_REFON)    0
set PROFILE_5(UI_DESCRIPTION)  "Der Durchgangssensor ist au&szlig;er Betrieb."
set PROFILE_5(UI_TEMPLATE)  $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)  5

#set SUBSET_1(NAME)          "Offen-Ein/Zu-Aus"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      1
set SUBSET_1(SHORT_CT_OFFDELAY)    1
set SUBSET_1(SHORT_CT_ON)      4
set SUBSET_1(SHORT_CT_ONDELAY)    4
set SUBSET_1(SHORT_CT_RAMPOFF)    1
set SUBSET_1(SHORT_CT_RAMPON)    1

#set SUBSET_2(NAME)          "Offen-Aus/Zu-Ein"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      4
set SUBSET_2(SHORT_CT_OFFDELAY)    4
set SUBSET_2(SHORT_CT_ON)      1
set SUBSET_2(SHORT_CT_ONDELAY)    1
set SUBSET_2(SHORT_CT_RAMPOFF)    1
set SUBSET_2(SHORT_CT_RAMPON)    1

#set SUBSET_3(NAME)          "r - l"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_CT_OFF)      1
set SUBSET_3(SHORT_CT_OFFDELAY)    1
set SUBSET_3(SHORT_CT_ON)      1
set SUBSET_3(SHORT_CT_ONDELAY)    1
set SUBSET_3(SHORT_CT_RAMPOFF)    1
set SUBSET_3(SHORT_CT_RAMPON)    1

#set SUBSET_4(NAME)          "l - r"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)  4
set SUBSET_4(SHORT_CT_OFF)      4
set SUBSET_4(SHORT_CT_OFFDELAY)    4
set SUBSET_4(SHORT_CT_ON)      4
set SUBSET_4(SHORT_CT_ONDELAY)    4
set SUBSET_4(SHORT_CT_RAMPOFF)    4
set SUBSET_4(SHORT_CT_RAMPON)    4


#set SUBSET_5(NAME)          "l - r || r - l"
set SUBSET_5(NAME)          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE)  5
set SUBSET_5(SHORT_CT_OFF)        0
set SUBSET_5(SHORT_CT_OFFDELAY)   0
set SUBSET_5(SHORT_CT_ON)         0
set SUBSET_5(SHORT_CT_ONDELAY)    0
set SUBSET_5(SHORT_CT_RAMPOFF)    0
set SUBSET_5(SHORT_CT_RAMPON)     0

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url receiver_address dev_descr_sender dev_descr_receiver
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


#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionVal}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE_PASSAGE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
  option DIM_OFFLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"



#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionVal}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE_PASSAGE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
  option DIM_OFFLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionVal}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE_PASSAGE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionVal}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE_PASSAGE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
  option DIM_OFFLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor

