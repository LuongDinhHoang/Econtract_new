import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_contract/data/entity/unit_user_info.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:e_contract/view/contract/sign_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Bkav TungDV Class chứa các dialog dùng chung cho app
class DiaLogManager {
  static Future<void> displayDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onTap,
    VoidCallback cancelCallback,
    String cancel,
    String access, {
    bool dialogBiometric = false,
    bool biometricFaceID = false,
    bool dialogComplete = false,
  }) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: dialogBiometric ?
                    biometricFaceID
                        ? SvgPicture.asset(
                      IconAsset.icFaceID,
                      width: 48,
                      height: 48,
                    )
                        : SvgPicture.asset(
                      IconAsset.icTouchID,
                      width: 48,
                      height: 48,
                    )
              : dialogComplete
                  ? SvgPicture.asset(
                      IconAsset.icComplete,
                      width: 48,
                      height: 48,
                    )
                  : SvgPicture.asset(
                      IconAsset.icEllipse,
                      width: 48,
                      height: 48,
                    ),
            ),
            title == ""
                ? Container()
                : Padding(
                    padding:
                        const EdgeInsets.only(bottom: 2, right: 18, left: 18),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: dialogBiometric ?StyleBkav.textBlack700Size14():StyleBkav.textStyleBlack16NotOverflow(),
                    ),
                  ),
            Padding(
                padding: dialogBiometric ?const EdgeInsets.only(bottom: 10, right: 14, left: 14):const EdgeInsets.only(bottom: 16, right: 18, left: 18),
                child: dialogBiometric ?
                Html(
                  data:content,
                  style: {
                    "body": Style(
                        textAlign: TextAlign.center,
                        fontSize: FontSize(14),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400)
                  },
                ): Text(
                  content,
                  textAlign: TextAlign.center,
                  style: StyleBkav.textStyleBlack14NotOverflow(),
                )),
            const Divider(
              color: AppColor.gray300,
              height: 1.0,
            ),
            InkWell(
              child: SizedBox(
                height: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        cancel != ""
                            ? Expanded(
                                flex: 1,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: cancelCallback,
                                  child: Text(cancel,
                                      textAlign: TextAlign.center,
                                      style: StyleBkav.textStyleFW700(
                                          AppColor.gray500, 15)),
                                ),
                              )
                            : Container(),
                        access != ""
                            ? Expanded(
                                flex: 1,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: onTap,
                                  child: Text(access,
                                      textAlign: TextAlign.center,
                                      style: StyleBkav.textStyleFW700(
                                          AppColor.cyan, 15)),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  //Bkav HoangLD giao diện dialog chọn đơn vị
  static Future displaySelectUnit(
      String username,
      BuildContext context,
      List<ListUnit> list
      ) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? objectGuid = (await SharedPrefs.instance()).getString("${username}${SharedPreferencesKey.locationUnitUser}") ?? list.first.objectGuid;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return showDialog(
        context: context,
    builder: (_){
      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, "");
          return true;
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: RichText(text: TextSpan(text: S.of(context).list_unit,
                      style: StyleBkav.textStyleFW700(AppColor.black22, 14)),textAlign: TextAlign.center,)
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 16, left: 16),
                  child: RichText(text: TextSpan(text: S.of(context).login_unit,
                    style: StyleBkav.textStyleBlack14NotOverflow()),textAlign: TextAlign.center,)
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 70 ,
                      maxHeight: 70 * textScaleFactor,
                      maxWidth: double.infinity,
                      minWidth: double.infinity
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(15),
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: RichText(text: TextSpan(text: S.of(context).unit,
                                  style: StyleBkav.textStyleFW400(AppColor.gray1, 16))),
                            ),
                            Flexible(
                              child: RichText(text: TextSpan(text: " *",
                                  style: StyleBkav.textStyleFW400(AppColor.redDD, 16))),
                            )
                          ],
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1.0)),
                        border: const OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: Color(0xFFBDBDBD) /*Bkav Nhungltk*/,
                                width: 1.0)),
                      ),
                      /*buttonWidth: double.infinity,
                      buttonHeight: 40 * textScaleFactor,
                      dropdownMaxHeight: 400,
                      itemHeight: 40 * textScaleFactor,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      offset: const Offset(-15, -15),*/
                      isExpanded: true,
                      items: list.map((itemone){
                        return DropdownMenuItem(
                          value: itemone.objectGuid,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: RichText(
                              text: TextSpan(text:"${itemone.code} - ${itemone.name}",style: StyleBkav.textStyleFW400NotOverflow(
                                  AppColor.black22, 14, height: 1.1)),
                            ),
                          ),
                        );
                      }).toList(),
                      value: objectGuid,
                      onChanged: (value) {
                        objectGuid = value.toString();
                      },
                    ),
                  )
                ),
                const Divider(
                  color: AppColor.gray300,
                  height: 1.0,
                ),
                InkWell(
                  child: SizedBox(
                    height: 52,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,"");
                                },
                                child: RichText(text: TextSpan(text: S.of(context).close_dialog,
                                    style: StyleBkav.textStyleFW700(
                                        AppColor.gray500, 15)),textAlign: TextAlign.center,)
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,objectGuid);
                                },
                                child: RichText(text: TextSpan(text: S.of(context).button_login,
                                    style: StyleBkav.textStyleFW700(
                                        AppColor.cyan, 15)),textAlign: TextAlign.center,)
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
  //Bkav HoangLD dialog hiển thị hoàn thành trên giao diện
  static Future<void> displayCompleteDialog(BuildContext context) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: SvgPicture.asset(
                IconAsset.icComplete,
                width: 48,
                height: 48,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32, right: 18, left: 18),
              child: Text(
                S.of(context).complete_dialog,
                textAlign: TextAlign.center,
                style: StyleBkav.textStyleBlack14NotOverflow(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  //HoangLD dialog hiển thị loading van tay trên giao diện
  static Future<void> displayLoadingFiDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 1), () {
            Get.back();
            displayCompleteDialog(context);
          });
          return const AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Padding(
              padding: EdgeInsets.only(top: 48, bottom: 48),
              child: DashedCircle(size: 48, stringIcon: IconAsset.icLoadingFi),
            ),
          );
        });
  }

  //HoangLD dialog hiển thị error van tay trên giao diện
  static Future<void> displayErrorFiDialog(BuildContext context) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: SvgPicture.asset(
                IconAsset.icEllipse,
                width: 48,
                height: 48,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32, right: 18, left: 18),
              child: Text(
                S.of(context).error_dialog_fingerprint,
                textAlign: TextAlign.center,
                style: StyleBkav.textStyleBlack14NotOverflow(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  static Future<void> displayLoadingDialog(BuildContext context) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(const AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      contentPadding: EdgeInsets.all(0),
      content: Padding(
        padding: EdgeInsets.only(top: 24, bottom: 24),
        child: DashedCircle(size: 48, stringIcon: IconAsset.icLoadingFi),
      ),
    ));
  }

  //Bkav Nhungltk: hien thi dialog ky thanh cong
  static Future<void> showDialogSignSucces(
      BuildContext context, String codeContract, String signPart, String time,
      {bool delayDialog = false}) async {
    if (delayDialog) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: SvgPicture.asset(
                      IconAsset.icEclipseGreen,
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 24),
                    child: Text(
                      S.of(context).sign_success,
                      style: StyleBkav.textStyleFW700(AppColor.black22, 14,
                          overflow: TextOverflow.visible),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        codeContract != "" ? Row(
                          children: [
                            Text("${S.of(context).contract_code} ",
                                style: StyleBkav.textStyleFW400(
                                    AppColor.black22, 14,
                                    overflow: TextOverflow.visible)),
                            Expanded(
                              child: Text(codeContract,
                                  style: StyleBkav.textStyleFW700(
                                      AppColor.black22, 14,
                                      overflow: TextOverflow.ellipsis)),
                            ),
                          ],
                        ) : Container(),
                        signPart !="" ? Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: Row(
                            children: [
                              Text("${S.of(context).sign_party}: ",
                                  style: StyleBkav.textStyleFW400(
                                      AppColor.black22, 14,
                                      overflow: TextOverflow.visible)),
                              Expanded(
                                child: Text(signPart,
                                    style: StyleBkav.textStyleFW700(
                                        AppColor.black22, 14,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),
                        ) : Container(),
                        time != "" ? Container(
                          margin: const EdgeInsets.only(top: 7, bottom: 16),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text("${S.of(context).time_sign}: ",
                                  style: StyleBkav.textStyleFW400(
                                      AppColor.black22, 14,
                                      overflow: TextOverflow.visible)),
                              Expanded(
                                child: Text(time,
                                    style: StyleBkav.textStyleFW700(
                                        AppColor.black22, 14,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),
                        ) : Container()
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColor.gray300,
                    height: 1.0,
                  ),
                  InkWell (
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        child: Text(S.of(context).close_dialog,
                            textAlign: TextAlign.center,
                            style:
                            StyleBkav.textStyleFW700(AppColor.gray500, 15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // HanhNTHe: show dialog error khi cos loi http code
  static void showDialogHTTPError(
      {required int status,
      required int resultStatus,
      required String resultObject}) {
    Logger.loggerDebug(" showDialogError "
        "1 - ${NavigationService.navigatorKey.currentContext}  - ok $status resultStatus $resultStatus resultObject $resultObject ");
    Logger.loggerDebug("Loi khi thuc hien mang status $resultStatus, object: $resultObject ");
    if (status >= 500) {
      displayDialog(
          NavigationService.navigatorKey.currentContext!,
          "",
          S
              .of(NavigationService.navigatorKey.currentContext!)
              .error_500_message,
          () {}, () {
        Get.back();
      }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog, "");
    } else if (status == 1) {
      Future.delayed(const Duration(seconds: 3), () {
        displayDialog(
            NavigationService.navigatorKey.currentContext!,
            S
                .of(NavigationService.navigatorKey.currentContext!)
                .title_dialog_loss_internet,
            S
                .of(NavigationService.navigatorKey.currentContext!)
                .content_dialog_loss_internet,
            () {}, () {
          Get.back();
        }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog,
            "");
      });
    } else if (status != 200) {
      displayDialog(
          NavigationService.navigatorKey.currentContext!,
          "",
          "${S.of(NavigationService.navigatorKey.currentContext!).error_200_message} (SC$status)",
          () {}, () {
        Get.back();
      }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog, "");
    } else if (resultStatus == -1) {
      displayDialog(
          NavigationService.navigatorKey.currentContext!,
          "",
          S
              .of(NavigationService.navigatorKey.currentContext!)
              .exp_session_message, () async {
        Navigator.of(NavigationService.navigatorKey.currentContext!)
            .pushAndRemoveUntil(await LoginPage.route(true), (route) => false);
        //Bkav HoangLD logout thì xoá tokenHSM
        //final pref = await SharedPreferences.getInstance();
        var tokenHSM = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenHSM);
        if(tokenHSM != null){
          (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenHSM,"");
        }
      }, () {
        Get.back();
      }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog,
          S.of(NavigationService.navigatorKey.currentContext!).re_login);
    } else if (resultStatus == 1 || resultStatus == 99) {
      displayDialog(NavigationService.navigatorKey.currentContext!, "",
          resultObject, () {}, () {
        Get.back();
      }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog, "");
    }
  }

  static Future<void> displayCancelRemoteSigningDialog(BuildContext context, bool isCancel,VoidCallback onReSign, {bool? isError, String? msg}) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  isError != null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 24),
                          child: SvgPicture.asset(
                            IconAsset.icErrorIcon,
                            width: 48,
                            height: 48,
                          ),
                        ),
                  isError != null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Text(
                            isCancel
                                ? S.of(context).remote_sign_cancel
                                : S.of(context).remote_sign_exp,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    color: AppColor.redE5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, right: 18, left: 18),
                    child: Html(
                      data: isError != null
                          ? msg
                          : S.of(context).remote_sign_content,
                      style: {
                        "#": Style(
                            textAlign: TextAlign.center,
                            fontSize: FontSize(14),
                            fontFamily: "Roboto",
                            lineHeight: const LineHeight(1.5))
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColor.gray300,
                    height: 1.0,
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 52,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    NavigationService.navigatorKey.currentState!.pop();
                                  },
                                  child: Text(S.of(context).close_dialog,
                                      textAlign: TextAlign.center,
                                      style: StyleBkav.textStyleFW700(
                                          AppColor.gray500, 15)),
                                ),
                              ),
                              isError != null
                                  ? Container()
                                  : Expanded(
                                      flex: 1,
                                      child: TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: onReSign,
                                      child: Text(S.of(context).resign,
                                          textAlign: TextAlign.center,
                                          style: StyleBkav.textStyleFW700(
                                              AppColor.cyan, 15)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> showDialogRemoteSigningSignError(String content) async {
    showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only( top: 20,
                          bottom: 16, right: 18, left: 18),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: StyleBkav.textStyleBlack14NotOverflow(),
                      )),
                  const Divider(
                    color: AppColor.gray300,
                    height: 1.0,
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 52,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    NavigationService.navigatorKey.currentState!.pop();                                  },
                                  child: Text(S.of(context).cancel,
                                      textAlign: TextAlign.center,
                                      style: StyleBkav.textStyleFW700(
                                          AppColor.gray500, 15)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
