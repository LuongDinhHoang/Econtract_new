// import 'package:e_contract/generated/l10n.dart';
// import 'package:e_contract/utils/utils.dart';
// import 'package:e_contract/view/account/setting_page.dart';
// import 'package:e_contract/view/contract/contract_from/contract_from_manager.dart';
// import 'package:e_contract/view/contract/contract_to/contract_to_manager.dart';
// import 'package:e_contract/view/contract/detail_a_contract_page.dart';
// import 'package:e_contract/view/contract/notify/notification_page.dart';
// import 'package:e_contract/view/contract/support_page.dart';
// import 'package:e_contract/view/home/tab_item.dart';
// import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
// import 'package:flutter/material.dart';
//
// class TabNavigatorRoutes {
//   static const String root = '/';
//   static const String detail = '/detail';
// }
//
// class TabNavigator extends StatefulWidget {
//   const TabNavigator({Key? key,
//     required this.navigatorKey,
//     required this.tabItem,
//     required this.showFace,
//     required this.fullName,
//     required this.showFigure,
//     required this.appVersion,
//     required this.checkFaceIdIos,
//     required this.onNumberNotifyChange})
//       : super(key: key);
//   final GlobalKey<NavigatorState>? navigatorKey;
//   final TabItem tabItem;
//
//   final String fullName;
//   final bool showFace;
//   final bool showFigure;
//   final String appVersion;
//   final bool checkFaceIdIos;
//
//   final void Function(int) onNumberNotifyChange;
//
//   @override
//   State<StatefulWidget> createState() => _TabNavigatorState();
// }
//  class _TabNavigatorState extends State<TabNavigator>{
//   bool isSignSuccess= false;
//   bool isLargeScreen = false;
//   ContractUIModel? contractModel;
//   int? position;
//
//   Future<void> _push(BuildContext context,
//       {ContractUIModel? contractUIModel, int? positionClick, bool detailNotification = false}) async {
//     isLargeScreen = Utils.checkHorizontal(context);
//     if (!isLargeScreen || detailNotification) {
//       var routeBuilders =
//       _routeBuilders(context, contractUIModel: contractUIModel);
//       //Bkav HoangLD chốt lại kịch bản không hiển thị navigator ở màn chi tiết nữa
//       final result= await Navigator.of(context, rootNavigator: true).push(
//         Utils.pageRouteBuilder(
//             routeBuilders[TabNavigatorRoutes.detail]!(context), true),
//       );
//       if(result!= null && result[0]== false){
//         setState(() {
//           isSignSuccess= true;
//         });
//       }
//     }else{
//       setState(() {
//         contractModel = contractUIModel;
//         position = positionClick;
//       });
//     }
//   }
//
//   Map<String, WidgetBuilder> _routeBuilders(BuildContext contextTabNavigator,
//       {ContractUIModel? contractUIModel}) {
//     if(Utils.checkHorizontal(context)){
//       if (widget.tabItem == TabItem.contractFrom) {
//         return {
//           TabNavigatorRoutes.root: (context) =>
//               ContractFromManager.showListContractsFrom((model,select) async{
//                 await _push(context, contractUIModel: model ,positionClick: select);
//               }, isSignSuccess: isSignSuccess,selectedValue: contractModel ,position: position),
//           TabNavigatorRoutes.detail: (context) =>
//               ContractFromManager.showListContractsFrom((model,select) async{
//             await _push(context, contractUIModel: model, positionClick: select);
//           }, isSignSuccess: isSignSuccess, selectedValue: contractModel,position: position),
//         };
//       }
//
//       if (widget.tabItem == TabItem.contractTo) {
//         return {
//           TabNavigatorRoutes.root: (context) =>
//               ContractToManager.showListContractsTo((model,select) async{
//                 await _push(context, contractUIModel: model, positionClick: select);
//               }, isSignSuccess: isSignSuccess, selectedValue: contractModel,position: position),
//           TabNavigatorRoutes.detail: (context) =>
//               ContractToManager.showListContractsTo((model,select) async{
//             await _push(context, contractUIModel: model, positionClick: select);
//           }, isSignSuccess: isSignSuccess, selectedValue: contractModel,position: position),
//         };
//       }
//     }else{
//       if (widget.tabItem == TabItem.contractFrom) {
//         return {
//           TabNavigatorRoutes.root: (context) =>
//               ContractFromManager.showListContractsFrom((model,select) async{
//                 await _push(context, contractUIModel: model);
//               }, isSignSuccess: isSignSuccess),
//           TabNavigatorRoutes.detail: (context) => DetailAContract(
//             contractUIModel: contractUIModel!,
//             isContractFrom: true,
//           ),
//         };
//       }
//
//       if (widget.tabItem == TabItem.contractTo) {
//         return {
//           TabNavigatorRoutes.root: (context) =>
//               ContractToManager.showListContractsTo((model,select) async{
//                 await _push(context, contractUIModel: model);
//               }, isSignSuccess: isSignSuccess),
//           TabNavigatorRoutes.detail: (context) => DetailAContract(
//             contractUIModel: contractUIModel!,
//             isContractFrom: false,
//           ),
//         };
//       }
//     }
//     if (widget.tabItem == TabItem.notify) {
//       return {
//         TabNavigatorRoutes.root: (context) => NotificationContract.init(
//             onNumberChange: widget.onNumberNotifyChange),
//         TabNavigatorRoutes.detail: (context) => DetailAContract(
//           contractUIModel: contractUIModel!,
//           isContractFrom: false,
//           isNotificationFrom: true,
//         ),
//       };
//     }
//     if (widget.tabItem == TabItem.setting) {
//       return {
//         TabNavigatorRoutes.root: (context) => SettingPage(
//           userFullName: widget.fullName,
//           showFigure: widget.showFigure,
//           showFace: widget.showFace,
//           contextCurrent: contextTabNavigator,
//           appVersion: widget.appVersion,
//           checkFaceIdIos: widget.checkFaceIdIos,
//         ),
//         TabNavigatorRoutes.detail: (context) => DetailAContract(
//           contractUIModel: contractUIModel!,
//           isContractFrom: true,
//         ),
//       };
//     }
//     if (widget.tabItem == TabItem.support) {
//       return {
//         TabNavigatorRoutes.root: (context) => const SupportPage(),
//         TabNavigatorRoutes.detail: (context) => DetailAContract(
//           contractUIModel: contractUIModel!,
//           isContractFrom: true,
//         ),
//       };
//     }
//     return {
//       TabNavigatorRoutes.root: (context) => Container(),
//       TabNavigatorRoutes.detail: (context) => Container(),
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final routeBuilders = _routeBuilders(context, contractUIModel: contractModel);
//     return Navigator(
//       key: widget.navigatorKey,
//       initialRoute: TabNavigatorRoutes.root,
//       onGenerateRoute: (routeSettings) {
//         return MaterialPageRoute(
//           builder: (context) => routeBuilders[routeSettings.name!]!(context),
//         );
//       },
//     );
//   }
// }
