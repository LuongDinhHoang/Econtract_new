import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:e_contract/data/entity/button_show.dart';
import 'package:e_contract/data/entity/contract_doc_to.dart';
import 'package:e_contract/data/entity/contract_docs.dart';
import 'package:e_contract/data/fake_data/fake_repository_impl.dart';
import 'package:e_contract/data/network_data/api_reponse.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/data/repository_impl.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/config_build.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:e_contract/view/contract/detail_a_contract_page.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/entity/contract_doc_from.dart';
import '../data/entity/signer.dart';

class Utils {
  static Future<bool> isBiometrics() async {
    bool isCanCheckBiometric = await LocalAuthentication().canCheckBiometrics;
    return isCanCheckBiometric;
  }
  //Bkav HoangLD check man hinh lon moi su dung chia tab
  static bool checkHorizontal(BuildContext context) {
    bool isLargeScreen = false;
    if(Platform.isIOS){
      if (MediaQuery.of(context).size.width > 600 && MediaQuery.of(context).size.height > 500 && MediaQuery.of(context).textScaleFactor < 2) {
        isLargeScreen = true;
      } else {
        isLargeScreen = false;
      }
    }else{
      if (MediaQuery.of(context).size.width > 600 && MediaQuery.of(context).size.height > 500) {
        isLargeScreen = true;
      } else {
        isLargeScreen = false;
      }
    }
    return isLargeScreen;
  }

  ///Bkav HoangLD : hiệu ứng chuyển giữa các page khác nhau
  static Route pageRouteBuilder(Widget widget, bool transitions) {
    if(transitions) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }else {
      return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget);
    }
  }

  static Future<BiometricType> isBiometricSupport() async {
    bool statusFingerprint = await Utils.statusFingerprint();
    bool statusFaceID = await Utils.statusFaceID();

    List<BiometricType> availableBiometrics =
    await LocalAuthentication().getAvailableBiometrics();
    if (statusFaceID || statusFingerprint) {
      if (Platform.isAndroid) {
        if (availableBiometrics.contains(BiometricType.strong)) {
          return BiometricType.fingerprint;
        }
      } else if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          return BiometricType.face;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          return BiometricType.fingerprint;
        }
      }
    }
    return BiometricType.iris;
  }
  static Future<BiometricType> isBiometricSupportSetting() async {
    List<BiometricType> availableBiometrics =
    await LocalAuthentication().getAvailableBiometrics();
    if (Platform.isAndroid) {
      if (availableBiometrics.contains(BiometricType.strong)) {
        return BiometricType.fingerprint;
      }
    } else if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        return BiometricType.face;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return BiometricType.fingerprint;
      }
    }
    return BiometricType.iris;
  }
  //HoangLD tạo 1 channel để call native ios
  static const channelBkav = MethodChannel('com.bkav.econtract.dev/bkav_channel');
  //Lấy sinh trắc học mà ịhone hỗ trợ
  static Future<bool> checkBiometricsFaceIdIos() async{
    bool faceId = false;
    if (Platform.isIOS) {
      String checkIos = await channelBkav.invokeMethod('getBiometricType');
      //final pref = await SharedPreferences.getInstance();
      if(checkIos !="none"){
        //Bkav HoangLD lưa giá trị biometric hỗ trợ trên iphone lại vì iphone có trường hợp tắt quyền truy cập trên app
        (await SharedPrefs.instance()).setString(SharedPreferencesKey.biometricIOS,checkIos);
        if(checkIos == "faceID"){
          faceId = true;
        }else{
          faceId = false;
        }
      }else{
        var biometricIOS = (await SharedPrefs.instance()).getString(SharedPreferencesKey.biometricIOS)??"";
        if(biometricIOS == "faceID"){
          faceId = true;
        }else{
          faceId = false;
        }
      }
    }
    return faceId;
  }
  static Future<String> callNativeEKYC(String accessToken,String typeId) async{
    String dataCallBack = "";
    var params =  <String, String>{"accessToken":accessToken,"typeId":typeId};
    if (Platform.isAndroid) {
      String dataCallBackAndroid = await channelBkav.invokeMethod('dateCallBackAndroidEKYC', params);
      dataCallBack = dataCallBackAndroid;
    }else if(Platform.isIOS){
      String dataCallBackIOS = await channelBkav.invokeMethod('dateCallBackIOSEKYC',params);
      dataCallBack = dataCallBackIOS;
    }
    return dataCallBack;
  }
  static void logOutApp() async{
    //Bkav HoangLD show dialog đã hết hạn đăng nhập nếu refresh token bị lỗi
    DiaLogManager.showDialogHTTPError(
        status: 200,
        resultStatus: -1,
        resultObject: "");
  }
  // HoangLD lưu Biometric của IOS
  static void checkBiometricsSaveChangeIos() async{
    if (Platform.isIOS) {
      //final prefs = await SharedPreferences.getInstance();
      String statusIOS = await channelBkav.invokeMethod('getStatusBiometric');
      await (await SharedPrefs.instance()).setString(SharedPreferencesKey.saveStatusChangeIOS, statusIOS);
    }
  }
  //Bkav HoangLD call native lấy trạng thái vân tay thay đổi android
  static Future<bool> checkBiometricsSaveChangeAndroid() async{
    var params =  <String, String>{"accessToken":"","typeId":""};
    bool statusAndroid = await channelBkav.invokeMethod('getStatusBiometricAndroid', params);
      return statusAndroid;
  }
  //Bkav HoangLD call native đăng nhập xong reset trạng thái vân tay trên android
  static void resetBiometricAndroid() async{
    var params =  <String, String>{"accessToken":"","typeId":""};
    await channelBkav.invokeMethod('resetBiometricAndroid',params);
  }
  // HoangLD check state Biometric có thay đổi không
  static Future<bool> checkBiometricsChangeIos() async{
    bool changeIos = true;
    if (Platform.isIOS) {
      //final prefs = await SharedPreferences.getInstance();
      String checkIos = await channelBkav.invokeMethod('getStatusBiometric');
      String statusIOS = (await SharedPrefs.instance()).getString(SharedPreferencesKey.saveStatusChangeIOS) ?? "";
      if(checkIos == statusIOS){
        changeIos = false;
      }else{
        changeIos = true;
      }
    }else if(Platform.isAndroid){
      final LocalAuthentication auth = LocalAuthentication();
      final List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();
      if(availableBiometrics.isNotEmpty){
        changeIos = await checkBiometricsSaveChangeAndroid();
      }else{
        changeIos = false;
      }
    }
    return changeIos;
  }

  static Future<bool> statusFingerprint({String? key}) async {
    //final prefs = await SharedPreferences.getInstance();
    String userName = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
    String fingerprintSettingSharePref =
        (await SharedPrefs.instance()).getString((key ?? userName).toLowerCase()) ??
            jsonEncode(SettingSharePref.toJson(false, false));
    // debugPrint("statusFingerprint  $userName -- $fingerprintSettingSharePref");
    return SettingSharePref.fromJson(jsonDecode(fingerprintSettingSharePref))
        .isFingerPrint;
  }

  ///Bkav TungDV check check man hinh ngang doc de fix loi tai tho tren ios
  static Widget bkavCheckOrientation(BuildContext context,Widget child){
    return  MediaQuery.of(context).orientation == Orientation.portrait ? Container(child: child) :  SafeArea(top: false,child: child,);
  }

  static Future<bool> statusFaceID({String? key}) async {
    //final prefs = await SharedPreferences.getInstance();
    String userName = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
    String faceIDSettingSharePref =
        (await SharedPrefs.instance()).getString((key ?? userName).toLowerCase()) ??
            jsonEncode(SettingSharePref.toJson(false, false));
    return SettingSharePref.fromJson(jsonDecode(faceIDSettingSharePref))
        .isFaceId;
  }

  static Future<Object> checkAuthenticateBiometric(String authenticate ) async {
    final canCheckBiometric = await isBiometrics();
    if (!canCheckBiometric) {
      return GetPasswordBiometricStatus.none;
    } else {
      try {
        bool statusAuthenticate = await LocalAuthentication().authenticate(
            localizedReason: Platform.isIOS?S.of(NavigationService.navigatorKey.currentContext!).title_dialog_face_id:S.of(NavigationService.navigatorKey.currentContext!).title_dialog_touch_id,
            authMessages: <AuthMessages>[
              AndroidAuthMessages(
                  signInTitle: S.of(NavigationService.navigatorKey.currentContext!).fingerprint_authentication,
                  biometricHint: "",
                  cancelButton: S.of(NavigationService.navigatorKey.currentContext!).cancel
              ),
            ],
            options: AuthenticationOptions(useErrorDialogs: false ,biometricOnly: false, stickyAuth: Platform.isIOS?true:false));
        if(statusAuthenticate){
          return GetPasswordBiometricStatus.successful;
        }else{
          return GetPasswordBiometricStatus.failure;
        }
      } on PlatformException {
        return GetPasswordBiometricStatus.moreThan3;
      }
    }
  }

  static Future<String> getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Widget bkavTextSignerStyle(
      BuildContext context, int index, String text,
      {int? value, required int length}) {
    // tạo 1 chuỗi mới không trùng lặp
    text = text.replaceAll('', '\u200B');
    //tỉ lệ phông chữ trong cài đặt
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                //Bkav HoangLD fix bug đối tượng ký bị đẩy ra
                length != 1 ?SizedBox(
                  width: 9 * textScaleFactor,
                  child: Text(
                    ("${index + 1}"),
                    style: StyleBkav.textStyleBlack14(),
                    maxLines: 1,
                  ),
                ):const SizedBox(),
                //Bkav HoangCV: fix bug BECM-102
                Flexible(
                  flex: 2,
                  child: Text(
                    length != 1 ? ". $text" : text,
                    style: StyleBkav.textStyleBlack14(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ),
                value != null
                    ? Text(
                  " ${value == ContractConstants.seen ? "(${S.of(context).seen})" : (value == ContractConstants.signed ? "(${S.of(context).signed})" : (value == ContractConstants.notSigned ? "(${S.of(context).refusing_sign})" : ""))}",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      color: Colors.grey[400]),
                )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String showDateTime(
      BuildContext context, ContractUIModel contractUIModel) {
    String result = "";
    switch (contractUIModel.status) {
      case ContractConstants.newlyCreated:
        result = "${S.of(context).date_update}: ${contractUIModel.timeUpdate}";
        break;
      case ContractConstants.refusingSign:
        result =
        "${S.of(context).date_refusing_sign}: ${contractUIModel.timeRefusingSign}";
        break;
      case ContractConstants.cancelled:
        result = "${S.of(context).date_cancel}: ${contractUIModel.timeCancel}";
        break;
      case ContractConstants.completed:
        result =
        "${S.of(context).date_complete}: ${contractUIModel.timeCompleted}";
        break;
    }
    return result;
  }

  static String showTitleName(String profileName, String profileTypeName) {
    if (profileName != "" && profileTypeName != "") {
      return "$profileName - $profileTypeName";
    } else if (profileName != "") {
      return profileName;
    } else if (profileTypeName != "") {
      return profileTypeName;
    }
    return "";
  }

  static String formatTimeSign(String time) {
    String timeDeleteT = time.replaceAll("T", " ");
    String timeSplit = timeDeleteT.split("+")[0];
    final dateTime = DateTime.parse(timeSplit);
    //HoangLD format lại date hiển thị trên Dialog
    String formattedDate = DateFormat('HH:mm:ss dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  static Text showTextContractStatus(BuildContext context, int status,
      {FontWeight? weight}) {
    bool? isComplete;
    bool? isNewCreate;
    bool? isRefusingSign;
    if (status == ContractConstants.completed) {
      isComplete = true;
    } else if (status == ContractConstants.waitingSign) {
      isComplete = false;
    } else if (status == ContractConstants.newlyCreated) {
      isNewCreate = true;
    } else if (status == ContractConstants.cancelled) {
      isNewCreate = false;
    } else {
      isRefusingSign = true;
    }
    if (isComplete != null) {
      return Text(
          isComplete ? S.of(context).complete : S.of(context).waiting_sign,
          style: StyleBkav.textStyleFW400(
              isComplete ? AppColor.green1 : AppColor.orange, 14));
    }
    if (isNewCreate != null) {
      return Text(
          isNewCreate ? S.of(context).newly_created : S.of(context).cancelled,
          style: StyleBkav.textStyleFW400(
              isNewCreate ? AppColor.black22 : Colors.grey, 14));
    }
    if (isRefusingSign != null) {
      return Text(S.of(context).refusing_sign,
          style: StyleBkav.textStyleFW400(AppColor.redE5, 14));
    }
    return const Text("");
  }

  static String convertTimeFDTF({required String time, required String type}) {
    if (time == "??") return time;
    var parsedDate = DateTime.parse(time);
    var timeNow = DateTime.now();

    /// M5, M8 Type
    // start date of week current
    DateTime startTimeOfWeekCurrent =
    timeNow.subtract(Duration(days: timeNow.weekday - 1));
    // end date of week current
    DateTime endTimeOfWeekCurrent = timeNow
        .subtract(Duration(days: DateTime.daysPerWeek - timeNow.weekday));
    // debugPrint(
    //     " startTimeOfWeekCurrent = $startTimeOfWeekCurrent, endTimeOfWeekCurrent = $endTimeOfWeekCurrent");

    /// M6, M8 Type
    // start date of month current
    DateTime startTimeOfMonthCurrent =
    DateTime.utc(timeNow.year, timeNow.month);
    // end date of month current
    DateTime endTimeOfMonthCurrent =
    DateTime.utc(timeNow.year, timeNow.month + 1, 0);
    // debugPrint(
    //     " startTimeOfMonthCurrent = $startTimeOfMonthCurrent, endTimeOfMonthCurrent = $endTimeOfMonthCurrent");

    String weekDayString =
        "Thứ ${parsedDate.weekday == 7 ? "Chủ nhật" : parsedDate.weekday + 1}";

    /// M1 Type
    String m1a = "${resultConvertString(parsedDate.hour)}h";
    String m1b = "$m1a${resultConvertString(parsedDate.minute)}'";
    String m1c = "$m1b${resultConvertString(parsedDate.second)}";

    /// M2 Type
    String m2a = "${parsedDate.year}";
    String m2b = "${resultConvertString(parsedDate.month)}/$m2a";
    String m2c =
        "${resultConvertString(parsedDate.day)}/${resultConvertString(parsedDate.month)}";
    String m2d = "$m2c/$m2a";
    String m2e = (parsedDate.year == timeNow.year) ? m2c : m2d;

    /// M3 Type
    String m3a = "$m1b $m2e";
    String m3b = "$m1c $m2e";

    /// check Type
    String result = "";
    var listType = type.split("&");
    for (int i = 0; i < listType.length; i++) {
      switch (listType[i]) {
        case ConstFDTFString.m1a:
          result += result != "" ? " $m1a" : m1a;
          break;
        case ConstFDTFString.m1b:
          result += result != "" ? " $m1b" : m1b;
          break;
        case ConstFDTFString.m1c:
          result += result != "" ? " $m1c" : m1c;
          break;
        case ConstFDTFString.m2a:
          result += result != "" ? " $m2a" : m2a;
          break;
        case ConstFDTFString.m2b:
          result += result != "" ? " $m2b" : m2b;
          break;
        case ConstFDTFString.m2c:
          result += result != "" ? " $m2c" : m2c;
          break;
        case ConstFDTFString.m2d:
          result += result != "" ? " $m2d" : m2d;
          break;
        case ConstFDTFString.m2e:
          result += result != "" ? " $m2e" : m2e;
          break;
        case ConstFDTFString.m3a:
          result += result != "" ? " $m3a" : m3a;
          break;
        case ConstFDTFString.m3b:
          result += result != "" ? " $m3b" : m3b;
          break;
        case ConstFDTFString.m4:
          //fixbug BECM-328
          String m4 = "";
          final difference = daysBetween(timeNow, parsedDate);
          if (difference == -3) {
            m4 = "Hôm kìa";
          } else if (difference == -2) {
            m4 = "Hôm kia";
          } else if (difference == -1) {
            m4 = "Hôm qua";
          } else if (difference == 0) {
            m4 = "Hôm nay";
          } else if (difference == 1) {
            m4 = "Ngày mai";
          } else if (difference == 2) {
            m4 = "Ngày kia";
          } else if (difference == 3) {
            m4 = "Ngày kìa";
          }
          result += result != "" ? " $m4" : m4;
          break;
        case ConstFDTFString.m5:
          String m5 = "";
          if (parsedDate.isBefore(startTimeOfWeekCurrent)) {
            m5 = "Tuần trước";
          } else if (parsedDate.isAfter(startTimeOfWeekCurrent) &&
              parsedDate.isBefore(endTimeOfWeekCurrent)) {
            m5 = "Tuần này";
          } else if (parsedDate.isAfter(endTimeOfWeekCurrent)) {
            m5 = "Tuần sau";
          }
          result += result != "" ? " $m5" : m5;
          break;
        case ConstFDTFString.m6:
          String m6 = "";
          if (parsedDate.isBefore(startTimeOfMonthCurrent)) {
            m6 = "Tháng trước";
          } else if (parsedDate.isAfter(startTimeOfMonthCurrent) &&
              parsedDate.isBefore(endTimeOfMonthCurrent)) {
            m6 = "Tháng này";
          } else if (parsedDate.isAfter(endTimeOfMonthCurrent)) {
            m6 = "Tháng sau";
          }
          result += result != "" ? " $m6" : m6;
          break;
        case ConstFDTFString.m7:
          String m7 =
              "$weekDayString, ngày ${resultConvertString(parsedDate.day)} tháng ${resultConvertString(parsedDate.month)} năm ${parsedDate.year}";
          result += result != "" ? " $m7" : m7;
          break;
        case ConstFDTFString.m8:

        /// M8 Type
        // start date of year current
          DateTime startTimeOfYearCurrent = DateTime.utc(timeNow.year);
          // end date of year current
          DateTime endTimeOfYearCurrent = DateTime.utc(timeNow.year + 1, 0);
          // 0h mung 1 cua thang hien tai -1
          DateTime startTimeOfBeforeMonth =
          DateTime.utc(timeNow.year, timeNow.month - 1);
          // ngay ket thuc cua thang hien tai + 1
          DateTime endTimeOfAfterMonth =
          DateTime.utc(timeNow.year, timeNow.month + 2, 0);
          // 0h t2 cua tuan hien tai -1
          DateTime startTimeOfBeforeWeek = timeNow.subtract(Duration(
              days: timeNow.subtract(const Duration(days: 7)).weekday - 1));
          // chu nhat cua tuan hien tai + 1
          DateTime endTimeOfAfterWeek = timeNow.subtract(Duration(
              days: DateTime.daysPerWeek -
                  timeNow.add(const Duration(days: 7)).weekday));
          // debugPrint(
          //     " startTimeOfYearCurrent = $startTimeOfYearCurrent, endTimeOfYearCurrent = $endTimeOfYearCurrent");
          String m8 = "";
          if (parsedDate.isBefore(startTimeOfYearCurrent)) {
            m8 = "$m2d ($weekDayString)";
          } else if (parsedDate.isAfter(startTimeOfYearCurrent) &&
              parsedDate.isBefore(startTimeOfBeforeMonth)) {
            m8 = "$m2c ($weekDayString)";
          } else if (parsedDate.isAfter(startTimeOfBeforeMonth) &&
              parsedDate.isBefore(startTimeOfMonthCurrent) &&
              parsedDate.isBefore(startTimeOfBeforeWeek) &&
              parsedDate.day != timeNow.day - 1 &&
              parsedDate.day != timeNow.day - 2 &&
              parsedDate.day != timeNow.day - 3) {
            m8 = parsedDate.day < 11
                ? "Ngày mùng ${parsedDate.day} tháng trước ($m2c)"
                : "Ngày ${parsedDate.day} Tháng trước ($m2c)";
          } else if (parsedDate.isAfter(startTimeOfMonthCurrent) &&
              parsedDate.isBefore(startTimeOfBeforeWeek) &&
              parsedDate.day != timeNow.day - 1 &&
              parsedDate.day != timeNow.day - 2 &&
              parsedDate.day != timeNow.day - 3) {
            m8 = parsedDate.day < 11
                ? "Ngày mùng ${parsedDate.day} tháng này ($m2c)"
                : "Ngày ${parsedDate.day} Tháng này ($m2c)";
          } else if (parsedDate.isAfter(startTimeOfBeforeWeek) &&
              parsedDate.isBefore(startTimeOfWeekCurrent) &&
              parsedDate.day != timeNow.day - 1 &&
              parsedDate.day != timeNow.day - 2 &&
              parsedDate.day != timeNow.day - 3) {
            m8 = "$weekDayString Tuần trước ($m2c)";
          } else if (parsedDate.isAfter(startTimeOfWeekCurrent) &&
              parsedDate.isBefore(
                  DateTime(timeNow.year, timeNow.month, timeNow.day - 3))) {
            m8 = "$weekDayString Tuần này ($m2c)";
          } else if (parsedDate.day == timeNow.day - 3) {
            m8 = "Hôm kìa ($m2c)";
          } else if (parsedDate.day == timeNow.day - 2) {
            m8 = "Hôm kia ($m2c)";
          } else if (parsedDate.day == timeNow.day - 1) {
            m8 = "Hôm qua ($m2c)";
          } else if (parsedDate.day == timeNow.day) {
            m8 = "Hôm nay ($m2c)";
          } else if (parsedDate.day == timeNow.day + 1) {
            m8 = "Ngày mai ($m2c)";
          } else if (parsedDate.day == timeNow.day + 2) {
            m8 = "Ngày kia ($m2c)";
          } else if (parsedDate.day == timeNow.day + 3) {
            m8 = "Ngày kìa ($m2c)";
          } else if (parsedDate.isAfter(DateTime(
              timeNow.year, timeNow.month, timeNow.day + 3, 23, 59, 59)) &&
              parsedDate.isBefore(endTimeOfWeekCurrent)) {
            m8 = "$weekDayString Tuần này ($m2c)";
          } else if (parsedDate.isAfter(endTimeOfWeekCurrent) &&
              parsedDate.isBefore(endTimeOfAfterWeek) &&
              parsedDate.day != timeNow.day + 1 &&
              parsedDate.day != timeNow.day + 2 &&
              parsedDate.day != timeNow.day + 3) {
            m8 = "$weekDayString Tuần sau ($m2c)";
          } else if (parsedDate.isAfter(endTimeOfAfterWeek) &&
              parsedDate.isBefore(endTimeOfMonthCurrent) &&
              parsedDate.day != timeNow.day + 1 &&
              parsedDate.day != timeNow.day + 2 &&
              parsedDate.day != timeNow.day + 3) {
            m8 = parsedDate.day < 11
                ? "Ngày mùng ${parsedDate.day} tháng này ($m2c)"
                : "Ngày ${parsedDate.day} Tháng này ($m2c)";
          } else if (parsedDate.isAfter(endTimeOfMonthCurrent) &&
              parsedDate.isBefore(endTimeOfAfterMonth) &&
              parsedDate.isAfter(endTimeOfAfterWeek) &&
              parsedDate.day != timeNow.day + 1 &&
              parsedDate.day != timeNow.day + 2 &&
              parsedDate.day != timeNow.day + 3) {
            m8 = parsedDate.day < 11
                ? "Ngày mùng ${parsedDate.day} tháng sau ($m2c)"
                : "Ngày ${parsedDate.day} Tháng sau ($m2c)";
          } else if (parsedDate.isAfter(endTimeOfAfterMonth) &&
              parsedDate.isBefore(endTimeOfYearCurrent)) {
            m8 = "$m2c ($weekDayString)";
          } else if (parsedDate.isAfter(endTimeOfYearCurrent)) {
            m8 = "$m2d ($weekDayString)";
          }
          result += result != "" ? " $m8" : m8;
          break;
      }
    }
    return result;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static Map<String, dynamic> convertDeadlineSignTime(
      String time) {
    if (time == "??") {
      return {
        ConstFDTFString.timeResult: "",
        ConstFDTFString.isExpired: false,
        ConstFDTFString.isWarning: null
      };
    }
    var parsedDate = DateTime.parse(time);
    var timeNow = DateTime.now();
    String result = "";
    bool isExp = false;
    bool? isWarning;
    String timeExpired = "";
    if (parsedDate.difference(timeNow).inDays >= 1 &&
        parsedDate.isAfter(timeNow)) {
      result = "Còn ${parsedDate.difference(timeNow).inDays} ngày";
      isExp = false;
      isWarning = null;
    } else if (parsedDate.difference(timeNow).inHours < 1 &&
        parsedDate.isAfter(timeNow)) {
      result = "Đến hạn trong ${parsedDate.difference(timeNow).inMinutes} phút";
      isExp = false;
      isWarning = true;
    } else if (parsedDate.difference(timeNow).inHours >= 1 &&
        parsedDate.difference(timeNow).inHours <= 23 &&
        parsedDate.isAfter(timeNow)) {
      result = "Đến hạn trong ${parsedDate.difference(timeNow).inHours} giờ";
      isExp = false;
      isWarning = true;
    } else if (parsedDate.difference(timeNow).inDays <= -1 &&
        parsedDate.isBefore(timeNow)) {
      result = "Hết hạn ký ${timeNow.difference(parsedDate).inDays} ngày";
      isExp = true;
      isWarning = false;
      timeExpired = "";
    } else if (parsedDate.difference(timeNow).inHours > -1 &&
        parsedDate.isBefore(timeNow)) {
      result = "Hết hạn ký ${timeNow.difference(parsedDate).inMinutes} phút";
      isExp = true;
      isWarning = false;
    } else if (parsedDate.difference(timeNow).inHours <= -1 &&
        parsedDate.difference(timeNow).inHours >= -23 &&
        parsedDate.isBefore(timeNow)) {
      result = "Hết hạn ký ${timeNow.difference(parsedDate).inHours} giờ";
      isExp = true;
      isWarning = false;
    }
    timeExpired = convertTimeInNotification(time);
    return {
      ConstFDTFString.timeResult: result,
      ConstFDTFString.isExpired: isExp,
      ConstFDTFString.isWarning: isWarning,
      ConstFDTFString.m3a: timeExpired
    };
  }

  static String resultConvertString(int result) {
    return result < 10 ? "0$result" : "$result";
  }

  //Bkav Nhungltk: de day de dung chung o nhieu noi
  static List<ContractUIModel> getResultSearch(
      List<ContractDocFrom> list, BuildContext blocContext) {
    List<ContractUIModel> listFrom = [];
    for (var element in list) {
      listFrom.add(Utils.convertToContractUIModel(element));
    }
    return listFrom;
  }

  ///Bkav Nhungltk: de day de dung o nhieu noi
  static List<ContractUIModel> getResultSearchTo(
      List<ContractDocTo> list, BuildContext blocContext) {
    List<ContractUIModel> listFrom = [];
    for (var element in list) {
      listFrom.add(Utils.convertToContractUIModel(element));
    }
    return listFrom;
  }

  ///Bkav Nhungltk: thong bao mat mang
  static Widget notificationInternet(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(
        padding: const EdgeInsets.only(top: 10, right: 10),
        width: double.infinity,
        height: 40,
        color: AppColor.orange30,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                IconAsset.icMatWifi,
              ),
            ),
            Text(S.of(context).title_no_internet,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      color: AppColor.orange, fontSize: 15, height: 20),
                ))
          ],
        ),
      ),
    ); //TODO tam thoi de la false, set true khi mat mang
  }

  static int convertTimeToMilliseconds(String time) {
    final dt = DateTime.parse(time);
    return dt.microsecond;
  }
  ///Bkav HoangLD check số ngaỳ ghi log
  static int checkTimeDeleteLog(String timeStart) {
    final format = DateFormat("dd-MM-yyyy HH:mm:ss");
    final date2 = DateTime.now();
    final timeDifference = format.parse(timeStart);
    final difference = date2.difference(timeDifference).inDays;
    return difference;
  }
  ///Bkav Nhungltk: duong ke ngang
  static Widget horizontalLine() {
    return Container(
      height: 1,
      color: AppColor.gray300,
      width: double.infinity,
    );
  }

  //Bkav Nhungltk: check dieu kien mang
  static Future<bool> checkInternetConnection() async {
    return await FlutterNetworkConnectivity().isInternetConnectionAvailable();
  }

  static int convertColor(String color) {
    return int.parse(color.replaceAll("#", "0xFF"));
  }

  static String convertTimeInNotification(String time) {
    String m1bM4 =
    Utils.convertTimeFDTF(time: time, type: ConstFDTFString.m1bM4).trim();
    String m1b =
    Utils.convertTimeFDTF(time: time, type: ConstFDTFString.m1b).trim();
    String m3a =
    Utils.convertTimeFDTF(time: time, type: ConstFDTFString.m3a).trim();

    if (m1bM4 != m1b) {
      return m1bM4;
    } else {
      return m3a;
    }
  }

  static void callApiNotifyReceive(Map<String, dynamic> data) async {
    Repository repository =
    ConfigBuild.isFakeUserRepo ? FakeDataSource() : RepositoryImpl();
    // day status len server
    String notifyGuid = data["NotifyGuid"];
    Logger.logActivity("callApiNotifyReceive notification ($notifyGuid)");
    await repository.updateNotificationStatusReceived(notifyGuid);
  }

  static void launchAppFromNotification(Map<String, dynamic> data) async {
    Repository repository =
    ConfigBuild.isFakeUserRepo ? FakeDataSource() : RepositoryImpl();
    // day status len server
    String profileGuid = data["ProfileGuid"];
    String notifyGuid = data["NotifyGuid"];
    /*String isBackground = data["isBackground"];
    if(isBackground == "null"){
      // await Future.delayed(const Duration(seconds: 15));
      return;
    }*/
    // debugPrint(
    //     "launchAppFromNotification profileGuid  --------------------- $profileGuid notify $notifyGuid -- $isBackground");
    await repository.updateNotificationStatusViewed(notifyGuid: notifyGuid);
    ContractDocFrom contractDocFrom =
    await repository.getDetailContractApp(profileGuid);


    ContractUIModel contractUIModel = convertToContractUIModel(
        contractDocFrom);

    Navigator.of(NavigationService.navigatorKey.currentContext!).push(
        DetailAContract.route(contractUIModel, true,
            NavigationService.navigatorKey.currentContext!,
            isNotifyFrom: true, isNotifyForeground: true));

  }

  static ContractUIModel convertToContractUIModel(
      ContractDocs element) {
    List<Signer> signers = element.signers ?? [];
    Map<String, int> signerStatus = {};
    BuildContext context = NavigationService.navigatorKey.currentContext!;
    if (signers.isNotEmpty) {
      for (var element in signers) {
        if (element.signerName != null) {
          signerStatus.putIfAbsent(
              element.signerName!,
                  () => (element.statusSign == ContractConstants.signed ||
                  element.statusSign == ContractConstants.refusingSign
                  ? element.statusSign
                  : element.statusView));
        }
      }
    }
    element.buttonShow ??= ButtonShow(
        copyPageSign: false,
        edit: false,
        restore: false,
        sign: false,
        download: false,
        viewHistory: false,
        cancelTranferSign: false);
    return ContractUIModel(
        objectGuid: element.contractGuid ?? "",
        profileName: element.contractName ?? "",
        listSignerStatus: signerStatus,
        status: element.contractStatus ?? ContractConstants.newlyCreated,
        profileTypeName: element.profileTypeName ?? "",
        sourceName: element.sourceName ?? "",
        createdDate: element.createdDate == null
            ? S.of(context).unlimited
            : Utils.convertTimeInNotification(element.createdDate ?? "??"),
        nameCreate: element.creator!.userName ?? "",
        fullNameCreate: element.creator!.fullName ?? "",
        profileCode: element.code ?? "",
        signDeadline: Utils.convertDeadlineSignTime(
            element.signDeadline ?? "??"),
        listTextDetail: element.listextDetail ?? [],
        isShowButtonSign: element.buttonShow!.sign &&
            element.contractStatus == ContractConstants.waitingSign ,
        timeCancel: element.timeCancelled == null
            ? S.of(context).unlimited
            : Utils.convertTimeInNotification(element.timeCancelled ?? "??"),
        timeRefusingSign: element.timeRefusingSign == null
            ? S.of(context).unlimited
            : Utils.convertTimeInNotification(
          element.timeRefusingSign ?? "??",
        ),
        timeCompleted: element.timeCompleted == null
            ? S.of(context).unlimited
            : Utils.convertTimeInNotification(element.timeCompleted ?? "??"),
        timeUpdate: element.lastUpdate == null
            ? S.of(context).unlimited
            : Utils.convertTimeInNotification(element.lastUpdate ?? "??"),
        isShowHistory: element.buttonShow!.viewHistory,
        isShowCopyPageSign: element.buttonShow!.copyPageSign,
        typeSign: ContractDocs.parseListTypeSign(element.typeSign ?? ""));
  }

  static Future<void> launchInBrowser(String url) async {
    Uri uri;
    if(url.contains('https')) {
      uri = Uri.parse(url);
    }else {
      if(url.contains('bkav.com')){
        uri = Uri(
          scheme: 'mailto',
          path: url,
        );
      }else{
        uri= Uri(
          scheme: 'tel',
          path: url,
        );
      }
    }
    if (await canLaunchUrl(uri)) {
      bool resultLaunch = await launchUrl(uri, mode: LaunchMode.externalApplication);
      Logger.logActivity("Result LaunchUrl: $uri , result: $resultLaunch");
      if(!resultLaunch){
        if(Get.isDialogOpen == true){
          Get.back();
        }
      }
    } else {
      if(Get.isDialogOpen == true){
        Get.back();
      }
      Logger.logActivity("Can't LaunchUrl: $uri");
    }
  }
}

class SettingSharePref {
  bool isFingerPrint;
  bool isFaceId;

  SettingSharePref({required this.isFingerPrint, required this.isFaceId});

  factory SettingSharePref.fromJson(Map<String, dynamic> json) {
    return SettingSharePref(
        isFingerPrint: json[SharedPreferencesKey.statusFingerprint],
        isFaceId: json[SharedPreferencesKey.statusFaceID]);
  }

  static Map<String, dynamic> toJson(bool isFingerPrint, bool isFaceId) {
    return {
      SharedPreferencesKey.statusFingerprint: isFingerPrint,
      SharedPreferencesKey.statusFaceID: isFaceId
    };
  }
}

class ConstFDTFString {
  static const String m1a = "M1a";
  static const String m1b = "M1b";
  static const String m1c = "M1c";
  static const String m2a = "M2a";
  static const String m2b = "M2b";
  static const String m2c = "M2c";
  static const String m2d = "M2d";
  static const String m2e = "M2e";
  static const String m3a = "M3a";
  static const String m3b = "M3b";
  static const String m4 = "M4";
  static const String m5 = "M5";
  static const String m6 = "M6";
  static const String m7 = "M7";
  static const String m8 = "M8";
  static const String m9 = "$m1b&$m8";
  static const String m4M3a = "$m4&$m3a";
  static const String m1bM2d = "$m1b&$m2d";
  static const String m1bM4 = "$m1b&$m4";

  static const String timeResult = "time_result";
  static const String isExpired = "is_exp"; // het han hay chua
  static const String isWarning =
      "is_warning"; // xem warning hay error hay null
}

/// Bkav HanhNTHe: remove scroll glow
class BkavBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// space color gray
class BkavColorSpace extends StatelessWidget {
  const BkavColorSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }
}
