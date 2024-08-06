import 'package:app_settings/app_settings.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/account/setting_page.dart';
import 'package:e_contract/view/contract/contract_from/contract_from_manager.dart';
import 'package:e_contract/view/contract/contract_to/contract_to_manager.dart';
import 'package:e_contract/view/contract/notify/notification_page.dart';
import 'package:e_contract/view/contract/support_page.dart';
import 'package:e_contract/view/home/bottom_navigation.dart';
import 'package:e_contract/view/home/tab_item.dart';
// import 'package:e_contract/view/home/tab_navigator.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.fullName,
      required this.showFace,
      required this.showFigure,
      required this.appVersion,
      required this.checkFaceIdIos,
      required this.currentTab})
      : super(key: key);
  final String fullName;
  final bool showFace;
  final bool showFigure;
  final String appVersion;
  final bool checkFaceIdIos;
  final TabItem currentTab;

  static Future<Route> route({TabItem? tab}) async {
    //final prefs = await SharedPreferences.getInstance();
    return Utils.pageRouteBuilder(HomePage(
      fullName: (await SharedPrefs.instance()).getString(SharedPreferencesKey.fullName) ?? "",
      showFigure: await Utils.statusFingerprint(),
      showFace: await Utils.statusFaceID(),
      appVersion: await Utils.getVersionApp(),
      checkFaceIdIos: await Utils.checkBiometricsFaceIdIos(),
      currentTab: tab ?? TabItem.contractFrom,
    ), false);
  }

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // so notification chua doc
  var _notificationCount = 0;
  
  // tab hien tai
  var _currentTab;

  // Bkav HanhNTHe : add
  bool isSignSuccessFrom = false;
  bool isSignSuccessTo = false;
  bool isLargeScreen = false;
  ContractUIModel? contractModelFrom;
  ContractUIModel? contractModelTo;
  int? positionFrom;
  int? positionTo;
  // Bkav HanhNTHe : add end

  var _navigatorKeys = {
    TabItem.contractFrom: GlobalKey<NavigatorState>(),
    TabItem.contractTo: GlobalKey<NavigatorState>(),
    TabItem.notify: GlobalKey<NavigatorState>(),
    TabItem.support: GlobalKey<NavigatorState>(),
    TabItem.setting: GlobalKey<NavigatorState>(),
  };

  // PageController pageController = PageController(viewportFraction: 0.99);
  late PreloadPageController preLoadPageController;

  Future<void> _selectTab(TabItem tabItem) async {
    if (tabItem != _currentTab) {
      preLoadPageController.jumpToPage(tabItem.index);
      setState(() => _currentTab = tabItem);
    }
    if (tabItem == TabItem.notify) {
      //nếu là tab thông báo thì gọi tới api  update thời gian
      context.read<Repository>().updateLastTimeOpenApp();
      //Bkav HoangLD click xem tab notification thì xoá nagnumber ở laucher
      FlutterAppBadger.removeBadge();
      setState(() => _notificationCount = 0);
    }
  }

  Future<void> _firebaseMessagingInApp(RemoteMessage message) async {
    int bagNumber = int.parse(message.data["BagNumberTabNotify"]);
    setState(() => _notificationCount = bagNumber);
  }

  void pageChanged(int index) {
    setState(() {
      _currentTab = TabItem.values[index];
    });
    if (TabItem.values[index] == TabItem.notify) {
      //nếu là tab thông báo thì gọi tới api  update thời gian
      context.read<Repository>().updateLastTimeOpenApp();
      //Bkav HoangLD click xem tab notification thì xoá nagnumber ở laucher
      FlutterAppBadger.removeBadge();
      setState(() => _notificationCount = 0);
    }
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    //Bkav HoangLD lang nghe su kien tu firebase dang trong app
    FirebaseMessaging.onMessage.listen(_firebaseMessagingInApp);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Utils.launchAppFromNotification(message.data);
    });
    //Bkav HoangLD chuyển hàm mở xoay màn hình ra màn home vì đang bị lỗi chưa rõ ở hàm dispose ở login
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);

    _currentTab = widget.currentTab;
    preLoadPageController = PreloadPageController(
        viewportFraction: 1,
        initialPage: TabItem.values.indexOf(_currentTab));
    super.initState();
  }

  @override
  void dispose() {
    // pageController.dispose();
    preLoadPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    isLargeScreen = Utils.checkHorizontal(context);
    //Bkav DucLQ thuc hien request permission notificaiton
    if (!context.read<Repository>().checkPermissionNotification) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      FirebaseMessaging.instance.getInitialMessage();
      messaging.getNotificationSettings().then((setting) {
        if (setting.authorizationStatus != AuthorizationStatus.authorized) {
          DiaLogManager.displayDialog(
              context,
              S.of(context).title_request_permisson_notification,
              S.of(context).content_request_permission_notification, () {
            AppSettings.openNotificationSettings();
            Get.back();
          }, () {
            Get.back();
          }, S.of(context).close_dialog,
              S.of(context).button_enable_permisson_notificaiton);
          context.read<Repository>().checkPermissionNotification = true;
        }
      });
    }
    return WillPopScope(
      onWillPop: () async {
       /* final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();*/
          if (_currentTab ==TabItem.contractFrom) {
            if(Utils.checkHorizontal(context)){
              SystemNavigator.pop();
            }
            return true;
          }else{
            preLoadPageController.jumpToPage(TabItem.contractFrom.index);
            return false;
          }
          /*if (isFirstRouteInCurrentTab) {
            // if not on the 'main' tab
            if (_currentTab != TabItem.contractFrom) {
              // select 'main' tab
              _selectTab(TabItem.contractFrom);
              // back button handled by app
              return false;
            }
          }*/
          // let system handle back button if we're on the first route
      },
      child: Scaffold(
        body: PreloadPageView.builder(
            preloadPagesCount: 4,
            itemCount: 5,
            controller: preLoadPageController,
            physics: const AlwaysScrollableScrollPhysics(),
            // allowImplicitScrolling: true,
            onPageChanged: (index) {
              pageChanged(index);
            },
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
                case 0:
                  {
                    return ContractFromManager.showListContractsFrom(
                        (model, select) async {
                          if (isLargeScreen) {
                            processClickAModel(model, select);
                          }
                        },
                        isSignSuccess: isSignSuccessFrom,
                        selectedValue: contractModelFrom,
                        position: positionFrom,
                        signSuccessCallBack: (bool signSuccess) {
                          setState(() {
                            isSignSuccessFrom = signSuccess;
                            // delay de setup lai trang thai cua signButton -> de k reload lai nh lan
                            Future.delayed(const Duration(milliseconds: 100), () {
                              isSignSuccessFrom = false;
                            });
                          });
                        });
                  }
                case 1:
                  {
                    return ContractToManager.showListContractsTo(
                        (model, select) async {
                          if (isLargeScreen) {
                            processClickAModel(model, select, isFrom: false);
                          }
                          // await _push(context, contractUIModel: model);
                        },
                        isSignSuccess: isSignSuccessTo,
                        selectedValue: contractModelTo,
                        position: positionTo,
                        signSuccessCallBack: (bool signSuccess) {
                          setState(() {
                            isSignSuccessTo = signSuccess;
                            // delay de setup lai trang thai cua signButton -> de k reload lai nh lan
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              isSignSuccessTo = false;
                            });
                          });
                        });
                  }
                case 2:
                  {
                    return NotificationContract.init(onNumberChange: (number) {
                      setState(() => _notificationCount = number);
                    });
                  }
                case 3:
                  {
                    return const SupportPage();
                  }
                case 4:
                  {
                    return SettingPage(
                      userFullName: widget.fullName,
                      showFigure: widget.showFigure,
                      showFace: widget.showFace,
                      contextCurrent: context,
                      appVersion: widget.appVersion,
                      checkFaceIdIos: widget.checkFaceIdIos,
                    );
                  }
                default:
                  {
                    return Container();
                  }
              }
              // return <Widget>[
              //   // _buildOffstageNavigator(TabItem.contractFrom),
              //   // _buildOffstageNavigator(TabItem.contractTo),
              //   // _buildOffstageNavigator(TabItem.notify),
              //   // _buildOffstageNavigator(TabItem.support),
              //   // _buildOffstageNavigator(TabItem.setting),
              //   ContractFromManager.showListContractsFrom((model,select) async{
              //     // await _push(context, contractUIModel: model);
              //   }, isSignSuccess: isSignSuccess),
              //   ContractToManager.showListContractsTo((model,select) async{
              //     // await _push(context, contractUIModel: model);
              //   }, isSignSuccess: isSignSuccess),
              //   NotificationContract.init(onNumberChange: (number) {
              //     setState(() => _notificationCount = number);
              //   }, clickItem: (profileGuid, profileTabId) {
              //     // fake du lieu voi [profileGuid] de cap nha sau
              //     // ContractUIModel model = ContractUIModel(
              //     //     objectGuid: profileGuid,
              //     //     profileName: "",
              //     //     profileTypeName: "HỒ SƠ MẪU TÀI CHÍNH",
              //     //     listSignerStatus: {},
              //     //     status: 2,
              //     //     nameCreate: "Nhungltk",
              //     //     profileCode: "2566HSMTC2022",
              //     //     sourceName: "BES",
              //     //     createdDate: "0001-01-01T00:00:00",
              //     //     fullNameCreate: "Le Thi Nhung",
              //     //     listTextDetail: [],
              //     //     isShowButtonSign: false,
              //     //     timeRefusingSign: '',
              //     //     timeUpdate: '',
              //     //     timeCancel: '',
              //     //     signDeadline: {
              //     //       ConstFDTFString.timeResult: S.of(context).unlimited,
              //     //       ConstFDTFString.isExpired: false,
              //     //       ConstFDTFString.isWarning: null
              //     //     },
              //     //     timeCompleted: '',
              //     //     isShowHistory: false,
              //     //     isShowCopyPageSign: false,
              //     //     typeSign: []);
              //     // _push(context, contractUIModel: model, detailNotification: true);
              //   }),
              //   const SupportPage(),
              //   SettingPage(
              //     userFullName: widget.fullName,
              //     showFigure: widget.showFigure,
              //     showFace: widget.showFace,
              //     contextCurrent: context,
              //     appVersion: widget.appVersion,
              //     checkFaceIdIos: widget.checkFaceIdIos,
              //   )
              // ];
            }),
        bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
            count: _notificationCount),
      ),
    );
  }

  void processClickAModel(ContractUIModel model, int pos,
      {bool isFrom = true}) {
    if (isFrom) {
      setState(() {
        contractModelFrom = model;
        positionFrom = pos;
      });
    } else {
      setState(() {
        contractModelTo = model;
        positionTo = pos;
      });
    }
  }

  // Widget _buildOffstageNavigator(TabItem tabItem) {
  //   return Offstage(
  //     offstage: _currentTab != tabItem,
  //     child: TabNavigator(
  //         navigatorKey: _navigatorKeys[tabItem],
  //         tabItem: tabItem,
  //         showFigure: widget.showFigure,
  //         fullName: widget.fullName,
  //         showFace: widget.showFace,
  //         appVersion: widget.appVersion,
  //         checkFaceIdIos: widget.checkFaceIdIos,
  //         onNumberNotifyChange: (number) {
  //           setState(() => _notificationCount = number);
  //         }),
  //   );
  // }
}
