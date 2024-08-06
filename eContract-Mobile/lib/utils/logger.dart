

import 'package:e_contract/data/entity/log_info.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logger {

  static const String _tag = "eContract";

  static const bool _isDebug = false;


  static const String nameLogErrorFile= "contract_log_error";

  static const String nameLogActivityFile= "econtract_log_activity";

  static const String nameLogOtherFile= "econtract_log_other";

  static const String subtagLogError= "Error";

  static const String subtagLogActivity= "Activity";

  static const String subtagLogOther= "Other";

  static const String pathFileLogError= "$nameLogErrorFile.txt";

  static const String pathFileLogActivity= "${Logger.nameLogActivityFile}.txt";

  static const String pathFileLogOther= "${Logger.nameLogOtherFile}.txt";

  static void loggerDebug(String log){
    if(_isDebug){
      debugPrint("$_tag : $log");
    }
  }
  static DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");


  static void logError(String log){
    loggerInfo(subtagLogError, "$_tag: $subtagLogError: $log", dateFormat.format(DateTime.now()).toString());
  }

  static void logActivity(String log){
    loggerInfo(subtagLogActivity, "$_tag: $subtagLogActivity: $log", dateFormat.format(DateTime.now()).toString());
  }

  static void logOther(String log){
    loggerInfo(subtagLogOther, "$_tag: $subtagLogOther: $log", dateFormat.format(DateTime.now()).toString());
  }
  static Future<void> loggerInfo(String subtag, String message, String timeNow) async{
    //loggerToFile(subtag, message);
    //final prefs = await SharedPreferences.getInstance();
    String? uuid= (await SharedPrefs.instance()).getString(SharedPreferencesKey.keyUUID);
    EContractDb.instance.insertLogApp(LogInfo(logTag:  subtag, logContent: message,
        timeLog: timeNow, uuid: uuid));
  }

}
