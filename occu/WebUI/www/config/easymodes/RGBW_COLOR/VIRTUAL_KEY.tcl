#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${choose_Mode}"
set PROFILES_MAP(2)	"\${jumpToColor}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)		"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)			"Expertenprofil"

set PROFILE_1(SHORT_ACT_HSV_COLOR_VALUE)	{253 254 255}
set PROFILE_1(LONG_ACT_HSV_COLOR_VALUE)		{253 254 255}
set PROFILE_1(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird ....."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)	
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACT_HSV_COLOR_VALUE)	{0 range 0 - 200}
set PROFILE_2(LONG_ACT_HSV_COLOR_VALUE)		{0 range 0 - 200}
set PROFILE_2(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird ....."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global env receiver_address dev_descr_sender dev_descr_receiver
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

	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/RGBW_Controller.js')</script>"

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

	append HTML_PARAMS(separate_$prn) "<tr><td class=\"attention\">\${lblMode}</td><td>"
  set options(253)	"\${optionIncColor}"
  set options(254)	"\${optionDecColor}"
  set options(255)	"\${optionToggleColor}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ACT_HSV_COLOR_VALUE|LONG_ACT_HSV_COLOR_VALUE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ACT_HSV_COLOR_VALUE "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}

	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${lblShortKeyPress}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_HSV_COLOR_VALUE separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_HSV_COLOR_VALUE]</td>"
	append HTML_PARAMS(separate_$prn) "<td class='hidden'><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
	append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "var shortVal = ($ps(SHORT_ACT_HSV_COLOR_VALUE) <= 200) ? $ps(SHORT_ACT_HSV_COLOR_VALUE) : 0;"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax(shortVal, separate_${special_input_id}_$prn\_$pref, true);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblLongKeyPress}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_HSV_COLOR_VALUE separate_${special_input_id}_$prn\_$pref ps LONG_ACT_HSV_COLOR_VALUE]</td>"
	append HTML_PARAMS(separate_$prn) "<td class='hidden'><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "var longVal = ($ps(LONG_ACT_HSV_COLOR_VALUE) <= 200) ? $ps(LONG_ACT_HSV_COLOR_VALUE) : 0;"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax(longVal, separate_${special_input_id}_$prn\_$pref, true);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

}

constructor
