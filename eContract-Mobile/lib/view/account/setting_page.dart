import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/form_submission_status.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/utils/widgets/notification_internet_widget.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:e_contract/view/contract/change_password_page.dart';
import 'package:e_contract/view/contract/log_app_page.dart';
import 'package:e_contract/view_model/account/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resource/assets.dart';

/// Bkav HanhNTHe: hien thi chi tiet noi dung cua 1 Ho So
class SettingPage extends StatelessWidget {
  const SettingPage(
      {Key? key,
      required this.userFullName,
      required this.showFace,
      required this.showFigure,
      required this.contextCurrent,
      required this.appVersion,
      required this.checkFaceIdIos})
      : super(key: key);
  final String userFullName;
  final bool showFace;
  final bool showFigure;
  final String appVersion;
  final bool checkFaceIdIos;
  final BuildContext
      contextCurrent; // Nhan context tu root vi context hien tai cua man hinh co state null

  //late int  count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SettingBloc(
              showFace: showFace,
              showFigure: showFigure,
              repository: context.read<Repository>(),
            ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BkavAppBar(
            context,
            backwardsCompatibility: false,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(right: 16, top: 11, bottom: 13),
              child: Text(S.of(context).setting,
                  style: StyleBkav.textStyleGray20()),
            ),
            actions: [
              BlocBuilder<SettingBloc, SettingState>(
                  builder: (blocContext, state) {
                return Padding(
                    padding: const EdgeInsets.only(top: 1, left: 2, right: 20),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: SvgPicture.asset(IconAsset.icPower),
                        onPressed: () {
                          // logout
                          blocContext.read<SettingBloc>().add(LogoutEvent());
                        },
                      ),
                    ));
              })
            ],
            showDefaultBackButton: false,
          ),
          body: Utils.bkavCheckOrientation(
            context,
            ScrollConfiguration(
              behavior: BkavBehavior(),
              child: SingleChildScrollView(
                  child: BlocListener<SettingBloc, SettingState>(
                      listener: (context, state) async {
                        final formStatus = state.formStatus;
                        if (formStatus is SubmissionSuccess) {
                          // Bkav HanhNTHe: if logout true => hien thi giao dien login
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil<void>(
                                  await LoginPage.route(true), (route) => false);
                          final snackBar = SnackBar(
                            content: Text(S.of(context).logout_message),
                            duration: const Duration(milliseconds: 2000),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (formStatus is SubmissionFailed) {
                          final snackBar =
                              SnackBar(content: Text(formStatus.exception));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const NotificationInternet(),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(IconAsset.icAvatar),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).hi,
                                            style: StyleBkav.textStyleFW400(
                                                Colors.black, 14),
                                          ),
                                          Text(
                                            userFullName,
                                            style: StyleBkav.textStyleFW700(
                                                Colors.black, 14,
                                                height: 1.5, overflow: TextOverflow.clip),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              containerLine(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Text(
                                  S.of(context).login_settings,
                                  style: StyleBkav.textStyleBlack16(),
                                ),
                              ),
                              FutureBuilder(
                                  future: Utils.isBiometricSupportSetting(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<BiometricType> snapshot) {
                                    if (snapshot.data == BiometricType.face) {
                                      return BlocBuilder<SettingBloc,
                                              SettingState>(
                                          builder: (context, state) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          child: Column(
                                            children: [
                                              itemInSetting(
                                                  IconAsset.icFadeIdSetting,
                                                  S.of(context).face_login,
                                                  false,
                                                  iconRight: state.isFaceIDLogin
                                                      ? IconAsset.icSwitchOn
                                                      : IconAsset.icSwitchOff),
                                              containerLine(isMargin: true),
                                            ],
                                          ),
                                          onTap: () async {
                                            setFaceIDLogin(context);
                                          },
                                        );
                                      });
                                    } else if (snapshot.data ==
                                        BiometricType.fingerprint) {
                                      return BlocBuilder<SettingBloc,
                                              SettingState>(
                                          builder: (context, state) {
                                        //showFigure=state.isFingerprintLogin,
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          child: Column(
                                            children: [
                                              itemInSetting(
                                                  IconAsset.icVanTaySetting,
                                                  S
                                                      .of(context)
                                                      .fingerprint_login,
                                                  false,
                                                  iconRight: state
                                                          .isFingerprintLogin
                                                      ? IconAsset.icSwitchOn
                                                      : IconAsset.icSwitchOff),
                                              containerLine(isMargin: true),
                                            ],
                                          ),
                                          onTap: () async {
                                            setFingerprintLogin(context);
                                          },
                                        );
                                      });
                                } else {
                                  return Column(
                                    children: [
                                      Platform.isIOS? checkFaceIdIos?GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        child: Column(
                                          children: [
                                            itemInSetting(
                                                IconAsset.icFadeIdSetting,
                                                S.of(context).face_login,
                                                false,
                                                iconRight: IconAsset.icSwitchOff),
                                            containerLine(isMargin: true),
                                          ],
                                        ),
                                        onTap: () async {
                                          DiaLogManager.displayDialog(
                                              context,
                                              S.of(context).title_dialog_face_Id,
                                              S.of(context).text_dialog_face_Id,
                                                  () {
                                                    AppSettings.openDeviceSettings();
                                                    Get.back();
                                              }, () {
                                            Get.back();
                                          }, S.of(context).close_dialog,
                                              S.of(context).setting);
                                        },
                                      ):const SizedBox()
                                          :const SizedBox(),
                                      checkFaceIdIos?const SizedBox()
                                          :GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        child: Column(
                                          children: [
                                            itemInSetting(
                                                IconAsset.icVanTaySetting,
                                                S.of(context).fingerprint_login,
                                                false,
                                                iconRight: IconAsset.icSwitchOff),
                                            containerLine(isMargin: true),
                                          ],
                                        ),
                                        onTap: () async {
                                          DiaLogManager.displayDialog(
                                              context,
                                              S
                                                  .of(context)
                                                  .title_dialog_fingerprint,
                                              S
                                                  .of(context)
                                                  .text_dialog_fingerprint, () {
                                            AppSettings.openDeviceSettings();
                                            Get.back();
                                          }, () {
                                            Get.back();
                                          }, S.of(context).close_dialog,
                                              S.of(context).setting);
                                        },
                                      ),
                                    ],
                                  );
                                }
                              }),
                          GestureDetector(onTap: (){
                              Navigator.of(context,rootNavigator: true).push(ChangePassWordPage.route());
                            },
                            behavior: HitTestBehavior.opaque,child: itemInSetting(IconAsset.icDoiMatKhau,
                              S.of(context).change_password, true,
                              iconRight: null),),
                          containerLine(isMargin: true),
                              GestureDetector(onTap: (){
                                Navigator.of(context, rootNavigator: true ).push(LogAppPage.route());
                              },
                                behavior: HitTestBehavior.opaque,child: itemInSetting(IconAsset.icSendLog,
                                    S.of(context).send_log_setting, true,
                                    iconRight: null),),
                              containerLine(isMargin: true),
                          //HoangLD bo co chu khoi giao dien
/*                        Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16),
                            child: Text(
                              S.of(context).font_size_setting,
                              style: StyleBkav.textStyleBlack16(),
                            ),
                          ),
                          itemInSetting(
                              IconAsset.icChooseOff, S.of(context).small_size),
                          containerLine(isMargin: true),
                          itemInSetting(
                              IconAsset.icChooseOn, S.of(context).regular_size),
                          containerLine(isMargin: true),
                          itemInSetting(
                              IconAsset.icChooseOff, S.of(context).big_size),
                          containerLine(),*/
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 24),
                                    child: Text(
                                      "${S.of(context).version} $appVersion",
                                      style: StyleBkav.textStyleFW400(
                                          AppColor.gray500, 12),
                                    )),
                                onTap: () async {
                                  // if (count >=1) {
                                  //   Navigator.of(context).push(LogAppPage.route());
                                  //   count=0;
                                  // }else{
                                  //   count++;
                                  // }
                                },
                              ),

                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 3, bottom: 16),
                                  child: Text(
                                    S.of(context).copy_right,
                                    style: StyleBkav.textStyleFW400(
                                        AppColor.gray500, 12, height: 1.5, overflow: TextOverflow.clip),
                                  )),
                            ]),
                      ))),
            ),
          ),
        ));
  }

  Widget itemInSetting(String icon, String title, bool changSetting,
      {String? iconRight}) {
    return Padding(
      padding:
           const EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 24, height: 24, child: SvgPicture.asset(icon,color: Colors.black)),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: StyleBkav.textStyleBlack14(),
            ),
          ),
          iconRight != null ? SvgPicture.asset(iconRight) : Container()
        ],
      ),
    );
  }

  Widget containerLine({bool? isMargin}) {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColor.gray300,
      margin: EdgeInsets.symmetric(horizontal: isMargin != null ? 16 : 0),
    );
  }

  //HoangLD click button dong y cua dialog
  Future<void> setFaceIDLogin(BuildContext context) async {
    //final prefs = await SharedPreferences.getInstance();
    bool isFingerPrint = await Utils.statusFingerprint();
    if (await Utils.statusFaceID()) {
      context.read<SettingBloc>().add(FaceIDLoginChanged(false));
      String uid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
      (await SharedPrefs.instance()).setString(uid.toLowerCase(),
          jsonEncode(SettingSharePref.toJson(isFingerPrint, false)));
    } else {
      DiaLogManager.displayDialog(context, S.of(context).title_dialog_face_Id_transfer,
          S.of(context).text_dialog_face_Id_transfer, () async {
        //context.read<SettingBloc>().add(FaceIDLoginChanged(true));
        //final prefs = await SharedPreferences.getInstance();
        String uid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
        (await SharedPrefs.instance()).setString(uid.toLowerCase(),
            jsonEncode(SettingSharePref.toJson(isFingerPrint, true)));
        context.read<SettingBloc>().add(FaceIDLoginChanged(true));
        //HoangLD fix bug BECM-563
        if(Platform.isAndroid){
          Utils.resetBiometricAndroid();
        }
        //HoangLD nếu FaceID thì sẽ lưu state lại
        Utils.checkBiometricsSaveChangeIos();
        Get.back();
      }, () {
        Get.back();
      }, S.of(context).cancel, S.of(context).agree);
    }
  }

  Future<void> setFingerprintLogin(BuildContext context) async {
    //final prefs = await SharedPreferences.getInstance();
    bool isFaceId = await Utils.statusFaceID();
    if (await Utils.statusFingerprint()) {
      context.read<SettingBloc>().add(FingerprintLoginChanged(false));
      String uid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
      (await SharedPrefs.instance()).setString(uid.toLowerCase(),
          jsonEncode(SettingSharePref.toJson(false, isFaceId)));
    } else {
      DiaLogManager.displayDialog(
          context,
          S.of(context).title_dialog_fingerprint_transfer,
          S.of(context).text_dialog_fingerprint_transfer, () async {
        //final prefs = await SharedPreferences.getInstance();
        String uid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
        (await SharedPrefs.instance()).setString(uid.toLowerCase(),
            jsonEncode(SettingSharePref.toJson(true, isFaceId)));
        context.read<SettingBloc>().add(FingerprintLoginChanged(true));
        //HoangLD nếu Vantay ios thì sẽ lưu state lại
        Utils.checkBiometricsSaveChangeIos();
        //HoangLD fix bug BECM-563
        if(Platform.isAndroid){
          Utils.resetBiometricAndroid();
        }
        Get.back();
      }, () {
        Get.back();
      }, S.of(context).cancel, S.of(context).agree);
    }
  }
}
