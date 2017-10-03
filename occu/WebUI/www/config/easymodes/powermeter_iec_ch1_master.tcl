#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

proc getDefaultValue {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set default $param_descr(DEFAULT)
  return "$default"
}

proc getUnit {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)
  return "$unit"
}

proc getMinMaxValueDescr {psDescr param} {
	upvar psDescr descr
  array_clear param_descr
	array set param_descr $descr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }
  return "($min - $max)"
}

proc getTextField {psDescr type param value inputId} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)

  set elemId '$inputId'

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur=\"ProofAndSetValue($elemId, $elemId,$param_descr(MIN), $param_descr(MAX), parseFloat(1))\"/>"
  return $s
}

proc getTextFieldIdentityString {psDescr type param value inputId defaultVal} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)

  set elemId '$inputId'

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur=\"checkIdentityString($elemId,'$defaultVal')\"/>"
  return $s
}

proc getComboBox {param prn special_input_id} {
	  global psDescr
	  upvar ps ps
	  set CHANNEL "CHANNEL"

	  array_clear options
    set options(0) "\${PowerMeterIGLSensorGAS}"
    set options(1) "\${PowerMeterIGLSensorIR}"
    set options(2) "\${PowerMeterIGLSensorLED}"
    set options(3) "\${PowerMeterIECSensor}"
    set options(4) "\${PowerMeterIGLSensorUnknown}"

    append s "<td>"
    append s "[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]"
    append s "</td>"
    return $s
}

catch {unset internalKey}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global env iface_url psDescr

	#upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	#upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
	upvar $pps_descr    ps_descr

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_TX_WM.js')</script>"
  set chn [lindex [split $special_input_id _] 1]
  set CHANNEL "CHANNEL"

  set hlpBoxWidth 450
  set hlpBoxHeight 160

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      set comment {
        set prn 1
        # This parameter will be removed
        set param TX_MINDELAY
        append HTML_PARAMS(separate_1) "<tr>"
          append HTML_PARAMS(separate_1) "<td>\${stringTableTxMinDelay}</td>"
          append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
        append HTML_PARAMS(separate_1) "</tr>"
      }

      set prn 1
      set param TX_THRESHOLD_POWER

      append HTML_PARAMS(separate_1) "<tr name='sensor_3' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${stringTablePowerMeterTxThresholdPower}</td>"
        append HTML_PARAMS(separate_1) "<td>"
          if {$ps($param) != "0.00"} {
            set thresholdVal [format %.2f $ps($param)]
            set notUsed ""
            set used "selected=\"selected\""
          } else {
            set thresholdVal "0.00"
            set notUsed "selected=\"selected\""
            set used ""
          }
          append HTML_PARAMS(separate_1) "<select onchange=\"var showThres = (this.selectedIndex < 1)?false:true;if(showThres) {jQuery(this).next().show();} else {jQuery(this).next().hide();} jQuery('#separate_CHANNEL_$chn\_$prn').val(this.options\[this.selectedIndex\].value);setDefaultThresholdPowerReceiver($ps($param), this.selectedIndex, $prn, [getDefaultValue psDescr $param]);\">"
            append HTML_PARAMS(separate_1) "<option value=\"0\" $notUsed>\${stringTableNotUsed}</option>"
            append HTML_PARAMS(separate_1) "<option value=\"$thresholdVal\" $used>\${optionEnterValue}</option>"
          append HTML_PARAMS(separate_1) "</select>"
          append HTML_PARAMS(separate_1) "<span id=\"spanPowerThreshold_$chn\">[getTextField psDescr $CHANNEL $param [format "%.2f" $ps($param)] separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</span>"
        append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"
      if {$ps($param) == "0.00"} {
        append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
          append HTML_PARAMS(separate_1) jQuery(\"#spanPowerThreshold_$chn\").hide();
        append HTML_PARAMS(separate_1) "</script>"
      }

      incr prn
      set param METER_TYPE
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td id=\"selectMeterType_$chn\">\${PowerMeterIGLMeterType}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $param $prn $special_input_id]
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_CONSTANT_GAS
      append HTML_PARAMS(separate_1) "<tr name='sensor_0' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLConstantGas}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param [format "%.3f" $ps($param)] separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_CONSTANT_IR
    	append HTML_PARAMS(separate_1) "<tr name='sensor_1' class='hidden'>"
    	  append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLConstantIR}</td>"
	      append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
	    append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_SENSIBILITY_IR
    	append HTML_PARAMS(separate_1) "<tr name='sensor_1' class='hidden'>"
    	  append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLSensibilityIR}</td>"
	      append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
	    append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_CONSTANT_LED
      append HTML_PARAMS(separate_1) "<tr name='sensor_2' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLConstantLed}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param POWER_STRING
      set defaultVal "1-0:1.7"
      append HTML_PARAMS(separate_1) "<tr name='sensor_3' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${PowerMeterPowerString}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextFieldIdentityString psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn $defaultVal][getHelpIcon "POWER_STRING_CH1" $hlpBoxWidth [expr $hlpBoxHeight * 1.6]]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param ENERGY_COUNTER_STRING
      set defaultVal "1-0:1.8"
      append HTML_PARAMS(separate_1) "<tr name='sensor_3' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${PowerMeterEnergyCounterString}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextFieldIdentityString psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn $defaultVal][getHelpIcon ENERGY_COUNTER_STRING_CH1 $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setDefaultThresholdPowerReceiver = function(curValue, selectedIndex, prn, defaultVal) \{"
      append HTML_PARAMS(separate_1) "if ((selectedIndex == 1) && (curValue == \"0.00\")) \{"
        append HTML_PARAMS(separate_1) "jQuery('#separate_${special_input_id}_' +prn).val(defaultVal);"
      append HTML_PARAMS(separate_1) "\}"
    append HTML_PARAMS(separate_1) "\};"

    append HTML_PARAMS(separate_1) "function showParameter() \{"
      append HTML_PARAMS(separate_1) "var meterType = jQuery(jQuery('#selectMeterType_$chn').next().children(0)).val();"

      append HTML_PARAMS(separate_1) "jQuery('tr.hidden').hide();"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='sensor_\" + meterType+ \"'\]\").show();"
      append HTML_PARAMS(separate_1) "if (meterType < 3) \{"
        append HTML_PARAMS(separate_1) "jQuery(\"#ch2ParamTbl\").hide();"
      append HTML_PARAMS(separate_1) "\}"

      append HTML_PARAMS(separate_1) "if (meterType == 3) \{"
        append HTML_PARAMS(separate_1) "jQuery(\".j_IECSensor\").show(); "
        append HTML_PARAMS(separate_1) "jQuery(\"#ch2ParamTbl\").show();"
      append HTML_PARAMS(separate_1) "\}"

      append HTML_PARAMS(separate_1) "if(meterType == 4) \{"
        append HTML_PARAMS(separate_1) " jQuery('tr.hidden').show();"
        append HTML_PARAMS(separate_1) "jQuery(\"#ch2ParamTbl\").show();"
      append HTML_PARAMS(separate_1) "\}"
    append HTML_PARAMS(separate_1) "\};"

    append HTML_PARAMS(separate_1) "showParameter();"
    append HTML_PARAMS(separate_1) "jQuery(jQuery('#selectMeterType_$chn').next().children(0)).bind('change',function() \{"

      append HTML_PARAMS(separate_1) "var meterTypeCH2 = jQuery(jQuery('#selectMeterType_2').next().children(0));"
      append HTML_PARAMS(separate_1) "jQuery(meterTypeCH2).val(jQuery(this).val());"
      append HTML_PARAMS(separate_1) "showParameter();"

    append HTML_PARAMS(separate_1) "\});"

    append HTML_PARAMS(separate_1) "checkIdentityString = function(elemID, defaultVal) \{"
      append HTML_PARAMS(separate_1) "var elem = jQuery('\#' + elemID);"
      append HTML_PARAMS(separate_1) "if (elem.val() == '') \{elem.val(defaultVal);\}"
    append HTML_PARAMS(separate_1) "\}"

  append HTML_PARAMS(separate_1) "</script>"
}

constructor


