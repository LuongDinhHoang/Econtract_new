import 'package:e_contract/data/repository.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/notification_internet_widget.dart';
import 'package:e_contract/view_model/contract/contract_support_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../utils/widgets/dialog_manager.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> with WidgetsBindingObserver {
  List<SupportEntity> listSupport = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<List> initListSupport(BuildContext context) async {
    //final pref = await SharedPreferences.getInstance();
    List<String> list = (await SharedPrefs.instance()).getStringList(SharedPreferencesKey.listSupport) ?? [];
    //HoangLD trong trường hợp ở màn login và loading không lấy được api tức thì get lại list 1 lần nữa
    if(list.isEmpty){
      await context.read<Repository>().getListSupport();
      list = (await SharedPrefs.instance()).getStringList(SharedPreferencesKey.listSupport) ?? [];
    }
    listSupport = [
      SupportEntity(
          name: S.of(context).support_zalo,
          icon: ImageAsset.imageZalo,
          url: list[0]),
      SupportEntity(
          name: S.of(context).support_messenger,
          icon: ImageAsset.imageMessenger,
          url: list[1]),
      SupportEntity(
          name: S.of(context).send_support_email + list[2],
          icon: ImageAsset.imageEmail,
          url: list[2]),
      SupportEntity(
          name: S.of(context).call_service_consultation + list[3],
          icon: ImageAsset.imageTelephone,
          url: list[3]),
      SupportEntity(
          name: S.of(context).call_technical_support + list[4],
          icon: ImageAsset.imageTelephone,
          url: list[4]),
    ];
    return listSupport;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
    else if (state == AppLifecycleState.paused) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show Support Page");
    return Scaffold(
        appBar: BkavAppBar(
          context,
          title: Text(
            S.of(context).support,
            style: StyleBkav.textStyleGray20(),
          ),
          showDefaultBackButton: false,
        ),
        body: Utils.bkavCheckOrientation(
          context, FutureBuilder(
          future: initListSupport(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: NotificationInternet());
            } else {
              return Center(
                  child: Column(
                    children: [
                      const NotificationInternet(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 8),
                          color: AppColor.gray50,
                          child: ListView.builder(
                              itemCount: listSupport.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    child: _contractSupport(
                                        listSupport[index].name,
                                        listSupport[index].icon),
                                    onTap: () => {
                                      DiaLogManager.displayLoadingDialog(context),
                                      Utils.launchInBrowser(
                                          listSupport[index].url)
                                    },
                                  )),
                        ),
                      ),
                    ],
                  ));
            } // snapshot.data  :- get your object which is pass from your downloadData() function

          },
        ),
        ));
  }

  Widget _contractSupport(String name, String icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        //height: 56,
        width: double.infinity,
        child:Table(
          columnWidths: const {
          0: IntrinsicColumnWidth(),
        },
          //defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              children: [
                TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Image.asset(icon),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(name,
                        style: StyleBkav.textStyleBlack14(),),
                    )
                  ]
                )
              ],
            ))
    );
  }
}

class SupportEntity {
  String name;
  String icon;
  String url;

  SupportEntity({required this.name, required this.icon, required this.url});
}
