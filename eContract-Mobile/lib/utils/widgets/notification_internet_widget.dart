import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_preferences_key.dart';

//HoangCV: Quan ly trang thai thong bao khi mat internet
class NotificationInternet extends StatefulWidget{
  const NotificationInternet({Key? key}) : super(key: key);

  @override
  State<NotificationInternet> createState() => _NotificationInternetState();
}

class _NotificationInternetState extends State<NotificationInternet> with WidgetsBindingObserver{
  bool visible = false;
  final FlutterNetworkConnectivity _flutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
    lookUpDuration: const Duration(seconds: 1),
    lookUpUrl: 'google.com',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _flutterNetworkConnectivity
        .getInternetAvailabilityStream()
        .listen((event) async {
      if (!mounted) {
        return;
      }
      if (event) {
        if (visible) {
          setState(() {
            visible = false;
          });
        }
        context.read<Repository>().checkedNetwork = false;
      } else {
        if (!visible) {
          if (!context.read<Repository>().checkedNetwork) {
            showDialogDisconnect();
            context.read<Repository>().checkedNetwork = true;
          }
          else{
            setState((){
              visible = true;
            });
          }
          visible = true;
        }
      }
    });
    registerNetWork();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        registerNetWork();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        unRegisterNetwork();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> registerNetWork() async {
    //final prefs = await SharedPreferences.getInstance();
    bool networkCallback = (await SharedPrefs.instance()).getBool(SharedPreferencesKey.networkCallback)?? false;
    if(!networkCallback) {
      (await SharedPrefs.instance()).setBool(SharedPreferencesKey.networkCallback, true);
      _flutterNetworkConnectivity.registerAvailabilityListener();
    }
  }
  Future<void> unRegisterNetwork() async {
    //final prefs = await SharedPreferences.getInstance();
    bool networkCallback = (await SharedPrefs.instance()).getBool(SharedPreferencesKey.networkCallback)?? true;
    if (networkCallback) {
      (await SharedPrefs.instance()).setBool(SharedPreferencesKey.networkCallback, false);
      _flutterNetworkConnectivity.unregisterAvailabilityListener();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 40,
        color: AppColor.orange30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(IconAsset.icMatWifi),
            ),
            Text(S.of(context).title_no_internet,
                style: GoogleFonts.roboto(
                  textStyle:
                      const TextStyle(color: AppColor.orange, fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unRegisterNetwork();
    super.dispose();
  }

  void showDialogDisconnect() {
    Logger.loggerDebug('Disconnect Internet');
    if (visible == false) {
      DiaLogManager.displayDialog(context, S.of(context).title_no_internet,
          S.of(context).content_dialog_no_internet, () {}, () {
        Get.back();
        setState(() {
          visible = true;
        });
      }, S.of(context).close_dialog, "");
    }
  }
}
