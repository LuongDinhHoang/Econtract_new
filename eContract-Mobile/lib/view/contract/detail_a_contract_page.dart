import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/blink_animation.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/contract/copy_address_sign_page.dart';
import 'package:e_contract/view/contract/show_document_page.dart';
import 'package:e_contract/view/contract/show_history_page.dart';
import 'package:e_contract/view/contract/sign_contract_page.dart';
import 'package:e_contract/view/home/home_page.dart';
import 'package:e_contract/view/home/tab_item.dart';
import 'package:e_contract/view_model/contract/detail_a_contract_bloc.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../resource/assets.dart';
import '../../utils/widgets/notification_internet_widget.dart';

/// Bkav HanhNTHe: hien thi chi tiet noi dung cua 1 Ho So
class DetailAContract extends StatefulWidget {
  static const String pageName = "detail_page";

  static Route route(
      ContractUIModel contractModel, bool isContractFrom, BuildContext context,
      {bool? isNotifyFrom, bool? isNotifyForeground}) {
    return Utils.pageRouteBuilder(
        DetailAContract(
          contractUIModel: contractModel,
          isContractFrom: isContractFrom,
          isNotificationFrom: isNotifyFrom, // check xem khac null
          isNotifyForeground: isNotifyForeground,
        ),
        true);
  }

  final ContractUIModel contractUIModel;
  final bool isContractFrom;
  final bool? isNotificationFrom;
  final bool? isNotifyForeground;
  final bool? isHorizontal;

  // final VoidCallback callbackPress;

  const DetailAContract(
      {Key? key,
      required this.contractUIModel,
      required this.isContractFrom,
      this.isNotificationFrom,
      this.isNotifyForeground,
      this.isHorizontal
      /*required this.callbackPress*/
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailAContractState();
}

class _DetailAContractState extends State<DetailAContract> {
  late ContractUIModel contractUIModel;
  late bool isContractFrom;
  bool isNotificationFrom = false;
  bool isNotifyForeground = true;
  bool isShowButtonSign = true;
  bool isHorizontal = false;

  @override
  Widget build(BuildContext context) {
    // check block
    contractUIModel = widget.contractUIModel;
    isContractFrom = widget.isContractFrom;
    isNotificationFrom = widget.isNotificationFrom ?? false;
    isNotifyForeground = widget.isNotifyForeground ?? false;
    isHorizontal = widget.isHorizontal ?? false;
    Logger.logActivity("Show DetailPage");
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(
        child: BlocProvider(
            create: (context) => DetailAContractBloc(context,
                repository: context.read<Repository>(),
                contractUIModel: contractUIModel,
                isNotification: isNotificationFrom),
            child: Scaffold(
                backgroundColor: isHorizontal ? Colors.white : AppColor.gray50,
                appBar: isHorizontal
                    ? null
                    : BkavAppBar(
                        context,
                        title: Text(
                          S.of(context).contract_detail,
                          style: StyleBkav.textStyleGray20(),
                        ),
                        actions: [
                          BlocBuilder<DetailAContractBloc,
                              DetailAContractState>(builder: (context, state) {
                            return ((state.contractUIModel ?? contractUIModel)
                                                .status ==
                                            ContractConstants.waitingSign ||
                                        (state.contractUIModel ??
                                                    contractUIModel)
                                                .status ==
                                            ContractConstants.completed ||
                                        (state.contractUIModel ??
                                                    contractUIModel)
                                                .status ==
                                            ContractConstants.refusingSign) &&
                                    (state.contractUIModel ?? contractUIModel)
                                        .isShowCopyPageSign
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 1, left: 2, right: 20),
                                    child: SizedBox(
                                      width: 18,
                                      height: 20,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        icon: SvgPicture.asset(
                                            IconAsset.icShareWhite),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(CopyAddressSignPage.route(
                                                  (state.contractUIModel ??
                                                          contractUIModel)
                                                      .objectGuid));
                                        },
                                      ),
                                    ))
                                : Container();
                          }),
                          isContractFrom && contractUIModel.isShowHistory
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 1, right: 18),
                                  child: SizedBox(
                                    width: 21,
                                    height: 18,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      icon:
                                          SvgPicture.asset(IconAsset.icHistory),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(HistoryContract.route(
                                                contractUIModel.objectGuid));
                                      },
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                        showDefaultBackButton: false,
                        leading: Container(
                          padding: const EdgeInsets.only(left: 6),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              IconAsset.icArrowLeft,
                              height: 24,
                              // color: Colors.,
                            ),
                            onPressed: () async {
                              if (isNotifyForeground) {
                                Navigator.of(context).pushAndRemoveUntil<void>(
                                    await HomePage.route(tab: TabItem.notify),
                                    (route) => false);
                              } else if (isNotificationFrom) {
                                Navigator.of(context).pop([isShowButtonSign]);
                              } else {
                                Navigator.of(context).pop([isShowButtonSign]);
                              }
                            },
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                body: Utils.bkavCheckOrientation(context,
                    BlocBuilder<DetailAContractBloc, DetailAContractState>(
                        builder: (context, state) {
                  if (isHorizontal) {
                    isNotificationFrom
                        ? context.read<DetailAContractBloc>().add(
                            GetDetailAContractApp(contractUIModel.objectGuid))
                        : context
                            .read<DetailAContractBloc>()
                            .add(ShowResult(contractUIModel));
                  }
                  return state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : isHorizontal && textScaleFactor < 2
                          ? scrollViewList()
                          : SingleChildScrollView(
                              physics: isHorizontal && textScaleFactor < 2
                                  ? NeverScrollableScrollPhysics()
                                  : AlwaysScrollableScrollPhysics(),
                              child: scrollViewList(),
                            );
                })),
                floatingActionButton:
                    BlocBuilder<DetailAContractBloc, DetailAContractState>(
                        builder: (context, state) {
                  return isHorizontal
                      ? Container()
                      : (state.contractUIModel ?? contractUIModel)
                                  .isShowButtonSign &&
                              (state.contractUIModel ?? contractUIModel)
                                      .status ==
                                  ContractConstants.waitingSign &&
                              !(state.contractUIModel ?? contractUIModel)
                                      .signDeadline[
                                  ConstFDTFString
                                      .isExpired] /*&&
                          (state.contractUIModel ?? contractUIModel)
                              .typeSign
                              .contains(ContractConstants.optSign.toString())*/
                              &&
                              isShowButtonSign
                          ? SizedBox(
                              height: 48,
                              width: 48,
                              child: Center(
                                child: FloatingActionButton(
                                    backgroundColor: AppColor.cyan,
                                    child: SvgPicture.asset(
                                      IconAsset.icKy,
                                      height: 24,
                                      width: 24,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      final result = await Navigator.of(context,
                                              rootNavigator: true)
                                          .push(SignContractPage.route(
                                              (state.contractUIModel ?? contractUIModel)
                                                  .objectGuid,
                                              (state.contractUIModel ?? contractUIModel)
                                                  .listTextDetail[0]
                                                  .objectGuid,
                                              0,
                                              ContractConstants
                                                  .signFromHomePage,
                                              (state.contractUIModel ?? contractUIModel)
                                                  .listTextDetail,
                                              (state.contractUIModel ??
                                                      contractUIModel)
                                                  .profileName,
                                              false,
                                              isContractFrom,
                                              (state.contractUIModel ??
                                                      contractUIModel)
                                                  .typeSign,
                                              (state.contractUIModel ??
                                                          contractUIModel)
                                                      .signDeadline[
                                                  ConstFDTFString.isExpired],
                                              (state.contractUIModel ??
                                                          contractUIModel)
                                                      .signDeadline[ConstFDTFString.m3a] ??
                                                  ""));
                                      if (result != null &&
                                          result[0] == false) {
                                        setState(() {
                                          isShowButtonSign = false;
                                        });
                                      }
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    }),
                              ),
                            )
                          : (state.contractUIModel ?? contractUIModel)
                                      .isShowButtonSign &&
                                  (state.contractUIModel ?? contractUIModel)
                                          .status ==
                                      ContractConstants.waitingSign &&
                                  (state.contractUIModel ?? contractUIModel)
                                          .signDeadline[
                                      ConstFDTFString.isExpired] &&
                                  isShowButtonSign
                              ? SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: Center(
                                    child: FloatingActionButton(
                                        backgroundColor: AppColor.gray200,
                                        child: SvgPicture.asset(
                                          IconAsset.disableSign,
                                          height: 24,
                                          width: 24,
                                          color: AppColor.gray300,
                                        ),
                                        onPressed: () {
                                          DiaLogManager.displayDialog(
                                              context,
                                              "",
                                              S.of(context).status_expired +
                                                  (state.contractUIModel ?? contractUIModel).signDeadline[
                                          ConstFDTFString.m3a],
                                              () {}, () {
                                            Get.back();
                                          }, S.of(context).close_dialog, "");
                                        }),
                                  ),
                                )
                              : Container();
                }))),
        onWillPop: () async {
          if (isNotifyForeground) {
            Navigator.of(context).pushAndRemoveUntil<void>(
                await HomePage.route(tab: TabItem.notify), (route) => false);
          } else if (isNotificationFrom) {
            Navigator.of(context).pop([isShowButtonSign]);
          } else {
            Navigator.of(context).pop([isShowButtonSign]);
          }
          //Navigator.of(context).pop([isShowButtonSign]);
          return false;
        });
  }

  Widget scrollViewList() {
    return BlocBuilder<DetailAContractBloc, DetailAContractState>(
        builder: (context, state) {
      return Container(
        color: isHorizontal ? Colors.white : AppColor.gray50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            isHorizontal ? Container() : const NotificationInternet(),
            Container(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  isHorizontal
                      ? Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  S.of(context).contract_detail,
                                  style:
                                      StyleBkav.textStyleFW700(AppColor.cyan, 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BlocBuilder<DetailAContractBloc,
                                          DetailAContractState>(
                                      builder: (context, state) {
                                    return ((state.contractUIModel ??
                                                            contractUIModel)
                                                        .status ==
                                                    ContractConstants
                                                        .waitingSign ||
                                                (state.contractUIModel ??
                                                            contractUIModel)
                                                        .status ==
                                                    ContractConstants
                                                        .completed ||
                                                (state.contractUIModel ??
                                                            contractUIModel)
                                                        .status ==
                                                    ContractConstants
                                                        .refusingSign) &&
                                            (state.contractUIModel ??
                                                    contractUIModel)
                                                .isShowCopyPageSign
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 1, left: 2),
                                            child: SizedBox(
                                              width: 25,
                                              height: 25,
                                              child: IconButton(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                icon: SvgPicture.asset(
                                                    IconAsset.icShareWhite,
                                                    color: AppColor.gray500, allowDrawingOutsideViewBox: true),
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .push(CopyAddressSignPage.route(
                                                          (state.contractUIModel ??
                                                                  contractUIModel)
                                                              .objectGuid));
                                                },
                                              ),
                                            ))
                                        : Container();
                                  }),
                                  isContractFrom &&
                                          contractUIModel.isShowHistory
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3, left: 1),
                                          child: IconButton(
                                            padding:
                                                const EdgeInsets.all(0.0),
                                            icon: SvgPicture.asset(
                                                IconAsset.icHistory,
                                                color: AppColor.gray500, allowDrawingOutsideViewBox: true,),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(HistoryContract.route(
                                                      contractUIModel
                                                          .objectGuid));
                                            },
                                          ),
                                        )
                                      : Container()
                                ],
                              ))
                            ],
                          ),
                        )
                      : Container(),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 18),
                      child: Text(
                        Utils.showTitleName(
                            (state.contractUIModel ?? contractUIModel)
                                .profileName,
                            (state.contractUIModel ?? contractUIModel)
                                .profileTypeName),
                        style: StyleBkav.textStyleBlack16NotOverflow(),
                      )),
                  Table(
                    columnWidths: const {
                      //Bkav HoangCV: resize kích thước cột theo chiều rộng của text
                      0: IntrinsicColumnWidth(),
                      //1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(children: [
                        bkavTextStyle(S.of(context).contract_code),
                        bkavTextStyle(
                            (state.contractUIModel ?? contractUIModel)
                                .profileCode,
                            colors: AppColor.black22),
                      ]),
                      isContractFrom
                          ? TableRow(children: [
                              bkavTextStyleMultiple(S.of(context).creator),
                              bkavTextStyleMultiple(
                                  Utils.showTitleName(
                                      (state.contractUIModel ?? contractUIModel)
                                          .nameCreate,
                                      (state.contractUIModel ?? contractUIModel)
                                          .fullNameCreate),
                                  colors: AppColor.black22)
                            ])
                          : TableRow(children: [Container(), Container()]),
                      isContractFrom
                          ? TableRow(children: [
                              bkavTextStyle(
                                  //Bkav HoangCV: setpadding end cho cột đầu
                                  '${S.of(context).source_contract}  '),
                              bkavTextStyle(
                                  (state.contractUIModel ?? contractUIModel)
                                      .sourceName,
                                  colors: AppColor.black22),
                            ])
                          : TableRow(children: [Container(), Container()]),
                      TableRow(children: [
                        bkavTextStyle('${S.of(context).create_date}  '),
                        bkavTextStyle(
                            (state.contractUIModel ?? contractUIModel)
                                .createdDate,
                            colors: AppColor.black22),
                      ]),
                      (state.contractUIModel ?? contractUIModel).status ==
                              ContractConstants.waitingSign
                          ?
                          // HanhNTHe: neu time deadline = vo thoi han thi an han ky di
                          ((state.contractUIModel ?? contractUIModel)
                                          .signDeadline)[
                                      ConstFDTFString.timeResult] !=
                                  ""
                              ? TableRow(
                                  children: [
                                    bkavTextStyleMultiple(
                                        '${S.of(context).date_sign}  '),
                                    //Bkav HoangCV: sử dụng Richtext cho text và image cùng 1 dòng khi có nhiều dòng
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: (state.contractUIModel ??
                                                        contractUIModel)
                                                    .signDeadline[
                                                        ConstFDTFString
                                                            .timeResult]
                                                    .replaceAll('', '\u200B'),
                                                style: StyleBkav.textStyleFW400(
                                                    (state.contractUIModel ??
                                                                    contractUIModel)
                                                                .signDeadline[
                                                            ConstFDTFString
                                                                .isExpired]
                                                        ? AppColor.redE5
                                                        : AppColor.black22,
                                                    14,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    height: 1.15)),
                                            (state.contractUIModel ??
                                                                contractUIModel)
                                                            .signDeadline[
                                                        ConstFDTFString
                                                            .isWarning] ==
                                                    null
                                                ? WidgetSpan(child: Container())
                                                : ((state.contractUIModel ??
                                                                contractUIModel)
                                                            .signDeadline[
                                                        ConstFDTFString
                                                            .isWarning])
                                                    ? WidgetSpan(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3,
                                                                  bottom: 2.5),
                                                          child:
                                                              SvgPicture.asset(
                                                            IconAsset.icWarning,
                                                            // height: 11,
                                                          ),
                                                        ),
                                                      )
                                                    : WidgetSpan(
                                                        child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3,
                                                                bottom: 2.5),
                                                        child:
                                                            BkavBlinkingButton(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                          IconAsset.icError,
                                                          // height: 11,
                                                        )),
                                                      )),
                                          ],
                                        ),
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor,
                                        maxLines: 2,
                                        // strutStyle: const StrutStyle(
                                        //   forceStrutHeight: true,
                                        // ),
                                      ),
                                    ),
                                  ],
                                )
                              : TableRow(children: [Container(), Container()])
                          : TableRow(children: [Container(), Container()]),
                      TableRow(children: [
                        bkavTextStyle('${S.of(context).status}  '),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Utils.showTextContractStatus(
                                context,
                                (state.contractUIModel ?? contractUIModel)
                                    .status,
                                weight: FontWeight.w400)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(
                  S.of(context).list_text,
                  style: StyleBkav.textStyleFW700(AppColor.black22, 14),
                )),
            Flexible(
              child: BlocBuilder<DetailAContractBloc, DetailAContractState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (state.contractUIModel ?? contractUIModel)
                            .listTextDetail
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemDocument(
                            textInList:
                                (state.contractUIModel ?? contractUIModel)
                                    .listTextDetail[index],
                            onTap: () async {
                              final result = await Navigator.of(context, rootNavigator: true).push(ShowDocumentPage.route(
                                  ((state.contractUIModel ?? contractUIModel)
                                          .listTextDetail[index])
                                      .profileGuid!,
                                  ((state.contractUIModel ?? contractUIModel)
                                          .listTextDetail[index])
                                      .objectGuid,
                                  ((state.contractUIModel ?? contractUIModel)
                                          .listTextDetail[index])
                                      .fileName,
                                  (state.contractUIModel ?? contractUIModel)
                                      .listTextDetail,
                                  index,
                                  (state.contractUIModel ?? contractUIModel).status ==
                                          ContractConstants.waitingSign &&
                                      (state.contractUIModel ?? contractUIModel)
                                          .isShowButtonSign,
                                  (state.contractUIModel ?? contractUIModel)
                                      .profileName,
                                  isContractFrom,
                                  false,
                                  (state.contractUIModel ?? contractUIModel)
                                      .typeSign,
                                  (state.contractUIModel ?? contractUIModel)
                                      .signDeadline[ConstFDTFString.isExpired],
                                  (state.contractUIModel ?? contractUIModel).signDeadline[ConstFDTFString.m3a] ?? ""));
                              if (result != null && result[0] == false) {
                                setState(() {
                                  isShowButtonSign = false;
                                });
                              }
                            },
                            contractUIModel:
                                state.contractUIModel ?? contractUIModel,
                          );
                        }),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Widget bkavTextStyle(String text, {Color? colors, double? height}) {
    // tạo 1 chuỗi mới không trùng lặp
    //Bkav HoangLD comment code này lại vì là nguyên nhân gây không xuống dòng text
    // text = text.replaceAll('', '\u200B');
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          //Bkav HoangCV: để hiển thị nhiều dòng
          text,
          style: StyleBkav.textStyleFW400(colors ?? AppColor.gray500, 14,
              overflow: TextOverflow.visible, height: height),
        ));
  }

  Widget bkavTextStyleMultiple(String text, {Color? colors}) {
    // tạo 1 chuỗi mới không trùng lặp
    //Bkav HoangLD comment code này lại vì là nguyên nhân gây không xuống dòng text
    // text = text.replaceAll('', '\u200B');
    return Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Text(
          //Bkav HoangCV: để hiển thị nhiều dòng
          text,
          style: StyleBkav.textStyleFW400(colors ?? AppColor.gray500, 14,
              overflow: TextOverflow.visible, height: 1.15),
        ));
  }

  Widget itemDocument(
      {required TextDetail textInList,
      required VoidCallback onTap,
      required ContractUIModel contractUIModel}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isHorizontal ? AppColor.gray50 : Colors.white,
                ),
                padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
                // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textInList.fileName,
                            style: StyleBkav.textStyleBlack16NotOverflow(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: ScrollConfiguration(
                              behavior: BkavBehavior(),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: textInList.profileItemSigner.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //if (index < 3) {
                                  Logger.loggerDebug("Bkav DucLQ $index");
                                  //String key = contractUIModel.listSignerStatus.keys
                                  //    .elementAt(index);
                                  String key = textInList
                                          .profileItemSigner[index]
                                          .signerName ??
                                      "";
                                  return Utils.bkavTextSignerStyle(
                                      context,
                                      index,
                                      textInList.profileItemSigner[index]
                                              .signerName ??
                                          "",
                                      value:
                                          contractUIModel.listSignerStatus[key],
                                      length:
                                          textInList.profileItemSigner.length);
                                  /*} else if (index == 3) {
                                        return const Text(
                                          "...",
                                          style: TextStyle(
                                              color: AppColor.black22),
                                        );
                                      }
                                      return Container();*/
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
