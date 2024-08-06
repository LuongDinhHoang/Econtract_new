import 'dart:async';
import 'dart:io' show Platform;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/download_status.dart';
import 'package:e_contract/utils/local_notification_service.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/sign_otp_status.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/auto_fade_button.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/contract/not_agreeing_sign_page.dart';
import 'package:e_contract/view/contract/show_list_text_page.dart';
import 'package:e_contract/view/contract/sign_contract_page.dart';
import 'package:e_contract/view/contract/sign_form_page.dart';
import 'package:e_contract/view/contract/sign_otp_page.dart';
import 'package:e_contract/view_model/contract/show_dcument_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/repository.dart';
import '../../utils/widgets/notification_internet_widget.dart';

/// Bkav HanhNTHe: hien thi noi dung van ban trong chi tiet ho so
class ShowDocumentPage extends StatefulWidget {
//Bkav Nhungltk
  final String objectGuid; //objectGuid cua profileTextDetail
  final String profileGuid; //objectGuid cua ho so
  final bool isSignDocumentPage;
  late final String fileName;
  final List<TextDetail>? listText;
  final int? openSignPageTo;
  final bool isShowButtonSign;
  final bool? signSuccess;
  final bool isFrom;
  final List<String> typeSign;
  int indexSelected;
  bool isExpired;
  String timeExpired;

  static Route route(
      String profileGuid,
      String objectGuid,
      String fileName,
      List<TextDetail> list,
      int indexSelection,
      bool isShowButton,
      String profileName,
      bool isFrom,
      bool isSignDoccument,
      List<String> typeSign,
      bool isExpired,
      String timeExpired) {
    return Utils.pageRouteBuilder(
        ShowDocumentPage.init(
          profileGuid: profileGuid,
          objectGuid: objectGuid,
          fileName: fileName,
          isSignDocumentPage: isSignDoccument,
          indexSelected: indexSelection,
          listText: list,
          isShowButtonSign: isShowButton,
          isFrom: isFrom,
          typeSign: typeSign,
          isExpired: isExpired,
          timeExpired: timeExpired,
        ),
        true);
  }

  ShowDocumentPage.init(
      {Key? key,
      required this.profileGuid,
      required this.objectGuid,
      required this.fileName,
      required this.isSignDocumentPage,
      required this.indexSelected,
      this.listText,
      this.openSignPageTo,
      required this.isShowButtonSign,
      this.signSuccess,
      required this.isFrom,
      required this.typeSign,
      required this.isExpired,
      required this.timeExpired})
      : super(key: key);

  @override
  State<ShowDocumentPage> createState() => _ShowDocumentPageState();
}

class _ShowDocumentPageState extends State<ShowDocumentPage> {
  LocalNotificationService? service;

  late var result = [];
  bool isShowButtonSign = true;

  final GlobalKey<FadeButtonAutoState> _fadeBackButtonAutoState =
      GlobalKey<FadeButtonAutoState>();

  final GlobalKey<FadeButtonAutoState> _fadeForwardButtonAutoState =
      GlobalKey<FadeButtonAutoState>();

  /// Create a controller to control the carousel programmatically
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show DocumentPage");
    return WillPopScope(child: BlocProvider(
        create: (context) => DocumentBloc(
            repository: context.read<Repository>(),
            profileGuid: widget.profileGuid,
            objectGuid: widget.objectGuid,
            isSignDocumentPage: widget.isSignDocumentPage,
            openSignTo: widget.openSignPageTo ?? -1,
            titleFile: widget.fileName,
            indexSelected: widget.indexSelected),
        child: BlocListener<DocumentBloc, DocumentState>(
            listener: (context, state) async {
              /*if (state.signOtpStatus is SendOtpFail &&
                  state.signContractInfo != null &&
                  state.sendingOTP == true) {
                Get.back();
                //HoangLD để thời gian xuống 0,5s tránh TH nó hiển thị các page khác
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 500),
                    content: Text(
                        "${state.signContractInfo?.errorMessage.replaceAll('"', '')}")));
                context
                    .read<DocumentBloc>()
                    .add(SendingOTPEvent(sendingOTP: false));
              } else */
              if (state.selectSign == true) {
                // Get.back();
                /*context
                    .read<DocumentBloc>()
                    .add(SendingOTPEvent(selectSign: false));*/
                //Bkav Nhungltk: fix loi khong hien thi sdt trong giao dien nhap otp
                result = await Navigator.of(context).push(SignFormPage.route(
                    widget.objectGuid,
                    widget.profileGuid,
                    widget.fileName,
                    widget.indexSelected,
                    widget.isShowButtonSign,
                    widget.isFrom,
                    widget.isSignDocumentPage));
                if (result != null) {
                  context.read<DocumentBloc>().add(SendingOTPEvent(selectSign: false));
                  if (result[6] != "") {
                    /**Bkav Nhungltk: result[4]: ma ho so
                        result[5]: ten nguoi ky
                        result[6]: thoi gian ky
                     */
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      DiaLogManager.showDialogSignSucces(
                          context, result[4], result[5], Utils.formatTimeSign(result[6]),delayDialog: true);
                    });
                    setState(() {
                      isShowButtonSign = false;
                    });
                    context.read<DocumentBloc>().add(ShowDocumentEvent(
                        widget.profileGuid,
                        widget.objectGuid,
                        widget.fileName,
                        widget.indexSelected,
                        true));

                  } else {
                    context.read<DocumentBloc>().add(ShowDocumentEvent(
                        widget.profileGuid,
                        widget.objectGuid,
                        widget.fileName,
                        widget.indexSelected,
                        false));
                  }
                }
              }else if(!state.statusSign){
                setState(() {
                  isShowButtonSign = false;
                });
              }
              if (state.downloadStatus is DownloadCompleteStatus) {
                DownloadCompleteStatus downloadCompleteStatus =
                state.downloadStatus as DownloadCompleteStatus;
                String nameFileDownload = downloadCompleteStatus.fileName;
                service = LocalNotificationService();
                service!.intialize();
                await service!.showNotification(
                    id: 0,
                    title: nameFileDownload,
                    body: S.of(context).download_complete);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                context.read<DocumentBloc>().add(ShowDocumentEvent(
                    widget.profileGuid,
                    widget.objectGuid,
                    widget.fileName,
                    widget.indexSelected,
                    false));
              } else if (state.downloadStatus is DownloadFailStatus) {
                DownloadFailStatus downloadStatus =
                state.downloadStatus as DownloadFailStatus;
                String error = S.of(context).download_error;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                context.read<DocumentBloc>().add(ShowDocumentEvent(
                    widget.profileGuid,
                    widget.objectGuid,
                    widget.fileName,
                    widget.indexSelected,
                    false));
                error.isNotEmpty
                    ? ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(duration: const Duration(seconds: 2),content: Text(error)))
                    : null;
              } else if (state.downloadStatus is DownloadCancelStatus) {
                DownloadCancelStatus downloadStatus =
                state.downloadStatus as DownloadCancelStatus;
                String error = downloadStatus.error;
                if (error.isNotEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(duration: const Duration(seconds: 2),content: Text(error)));
                  context.read<DocumentBloc>().add(ShowDocumentEvent(
                      widget.profileGuid,
                      widget.objectGuid,
                      widget.fileName,
                      widget.indexSelected,
                      false));
                }
              }
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: BkavAppBar(
                  context,
                  showDefaultBackButton: false,
                  leading: Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        IconAsset.icArrowLeft,
                        height: 24,
                        // color: Colors.,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop([isShowButtonSign]);
                      },
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  title: widget.isSignDocumentPage
                      ? Text(
                    S.of(context).sign_contract,
                    style: StyleBkav.textStyleGray20(),
                  )
                      : BlocBuilder<DocumentBloc, DocumentState>(
                      builder: (context, state) {
                        return Text(
                          state.titleFile,
                          textAlign: TextAlign.center,
                          style: StyleBkav.textStyleGray20(),
                        );
                      }),
                  actions: [
                    Visibility(
                        visible: Platform.isAndroid,
                        child: BlocBuilder<DocumentBloc, DocumentState>(
                            builder: (context, state) {
                              return Container(
                                padding: const EdgeInsets.only(right: 24),
                                child: SizedBox(
                                  width: 14,
                                  height: 17,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        icon: SvgPicture.asset(IconAsset.icDownload, allowDrawingOutsideViewBox: true),
                                        onPressed: () async {
                                          var request =
                                          await Permission.storage.request();
                                          var status = await Permission.storage.status;
                                          if (request == PermissionStatus.granted) {
                                            Logger.loggerDebug(
                                                "nhungltk permission granded==========");
                                            context.read<DocumentBloc>().add(
                                                DownloadDoccumentEvent(widget.objectGuid,
                                                    widget.fileName, false));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  S.of(context).downloading,
                                                  style: StyleBkav.textStyleFW400(
                                                      Colors.white, 14),
                                                ),
                                                action: SnackBarAction(
                                                  label: S.of(context).cancel_download,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    if(!mounted) return;
                                                    context.read<DocumentBloc>().add(
                                                        DownloadDoccumentEvent(
                                                            widget.objectGuid,
                                                            widget.fileName,
                                                            true));
                                                  },
                                                ),
                                                backgroundColor: AppColor.cyan,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                ),
                              );
                            })),
                    BlocBuilder<DocumentBloc, DocumentState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.only(right: 18),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () {
                                    //HoangLD vì share file quá lâu nên hiển thị dialog loading để chờ
                                    DiaLogManager.displayLoadingDialog(context);
                                    context.read<DocumentBloc>().add(ShareDocumentEvent(
                                        widget.objectGuid, widget.fileName, true, context));
                                  },
                                  icon: Platform.isAndroid
                                      ? SvgPicture.asset(IconAsset.icShareWhite, allowDrawingOutsideViewBox: true)
                                      : SvgPicture.asset(IconAsset.icShareIos, allowDrawingOutsideViewBox: true),
                                ),
                            ),
                          );
                        }),
                    BlocBuilder<DocumentBloc, DocumentState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () async {
                              final index = await Navigator.of(context).push(
                                  ShowListTextPage.route(
                                      widget.listText ?? [], state.indexSelected));
                              // Bkav HanhNTHe: nhan ve su kien va load van ban tuong ung
                              if (index != null) {
                                widget.indexSelected = index;
                                carouselController.jumpToPage(widget.indexSelected);
                                context.read<DocumentBloc>().add(ShowDocumentEvent(
                                    (widget.listText ?? [])[index].profileGuid!,
                                    (widget.listText ?? [])[index].objectGuid,
                                    (widget.listText ?? [])[index].fileName,
                                    index, false));
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 18, bottom: 13, top: 13),
                              height: 18,
                              width: 18,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          ImageAsset.buttonNumberBackgroundWhite),
                                      fit: BoxFit.fill)),
                              child: Center(
                                child: Text(
                                  "${(widget.listText ?? []).length}",
                                  style: StyleBkav.textStyleFW700(Colors.white, 12,height: 0),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
                body: Column(children: [
                  const NotificationInternet(),
                  Expanded(
                      child:
                      Utils.bkavCheckOrientation(context, showDocument()))
                ]),
                floatingActionButton: BlocBuilder<DocumentBloc, DocumentState>(
                    builder: (context, state) { return
                      !widget.isSignDocumentPage &&
                        widget.isShowButtonSign  && !widget.isExpired &&
                        /*widget.typeSign.contains(ContractConstants.optSign.toString()) &&*/ isShowButtonSign
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
                              final result = await   Navigator.of(context).push(
                                  SignContractPage.route(
                                      (widget.listText ?? [])[widget.indexSelected]
                                          .profileGuid!,
                                      (widget.listText ?? [])[widget.indexSelected]
                                          .objectGuid,
                                      widget.indexSelected,
                                      ContractConstants.signFromDocumentPage,
                                      widget.listText ?? [],
                                      widget.fileName,
                                      false,
                                      widget.isFrom,
                                      widget.typeSign,
                                      widget.isExpired,
                                      widget.timeExpired));
                              if(result!= null && result[0]==false){
                                setState(() {
                                  isShowButtonSign= false;
                                });
                              }
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            }),
                      ),
                    )
                        : !widget.isSignDocumentPage &&
                        widget.isShowButtonSign &&
                          widget.isExpired && isShowButtonSign
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
                              DiaLogManager.displayDialog(context, "",
                                  S.of(context).status_expired + widget.timeExpired, () { }, () {Get.back();},
                                  S.of(context).close_dialog, "");
                            }),
                      ),
                    )
                          : !widget.isSignDocumentPage &&
                          widget.isShowButtonSign  &&
                          widget.typeSign.contains(ContractConstants.hsmSign.toString()) && isShowButtonSign
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
                                final result = await   Navigator.of(context).push(
                                    SignContractPage.route(
                                        (widget.listText ?? [])[widget.indexSelected]
                                            .profileGuid!,
                                        (widget.listText ?? [])[widget.indexSelected]
                                            .objectGuid,
                                        widget.indexSelected,
                                        ContractConstants.signFromDocumentPage,
                                        widget.listText ?? [],
                                        widget.fileName,
                                        false,
                                        widget.isFrom,
                                        widget.typeSign,
                                        widget.isExpired,
                                        widget.timeExpired));
                                if(result!= null && result[0]==false){
                                  setState(() {
                                    isShowButtonSign= false;
                                  });
                                }
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              }),
                        ),
                      )
                        : Container();}),
                bottomSheet: Visibility(
                  visible: widget.isSignDocumentPage && isShowButtonSign,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                Navigator.of(context).push(
                                    NotAgreeingSignPage.route(
                                        widget.profileGuid, widget.isFrom));
                              },
                              child: Text(S.of(context).no_agree_sign,
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color(0xFF626262)))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        BlocBuilder<DocumentBloc, DocumentState>(
                            builder: (context, state) {
                              return Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.cyan,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12))),
                                    onPressed: () async {
                                      context
                                          .read<DocumentBloc>()
                                          .add(SendingOTPEvent(selectSign: true));
                                      /*if(widget.typeSign.contains(ContractConstants.optSign.toString())){
                                        context.read<DocumentBloc>().add(
                                            SignDocumentEvent(
                                                widget.profileGuid, context, widget.fileName));
                                        context.read<DocumentBloc>().add(
                                            ShowDocumentEvent(widget.profileGuid, widget.objectGuid,
                                                widget.fileName, widget.indexSelected, false));
                                        context
                                            .read<DocumentBloc>()
                                            .add(SendingOTPEvent(sendingOTP: true));
                                        DiaLogManager.displayLoadingDialog(context);
                                      }else if(widget.typeSign.contains(ContractConstants.hsmSign.toString())){
                                        //Bkav HoangLD ký hsm
                                        context.read<DocumentBloc>().add(
                                            SignHSMDocumentEvent(
                                                widget.profileGuid,context));
                                        DiaLogManager.displayLoadingDialog(context);

                                      }*/
                                    },
                                    child: Text(
                                      S.of(context).agree_sign,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                )))), onWillPop: ()async{
      Navigator.of(context).pop([isShowButtonSign]);
      return false;
    });
  }

  Widget showDocument() {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      return
          // RefreshIndicator(
          //   onRefresh: () => refreshDocument(context),
          //   child:
          Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        margin: widget.isSignDocumentPage && isShowButtonSign
            ? const EdgeInsets.only(bottom: 72)
            : const EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child:
/*                            const Align(
                                      alignment: Alignment.topCenter,
                                      child: NotificationInternet(),
                                    ),*/
                Listener(
                  onPointerDown: (details) {
                    if (_fadeBackButtonAutoState.currentState != null) {
                      _fadeBackButtonAutoState.currentState!.animationRun();
                    }
                    if (_fadeForwardButtonAutoState.currentState != null) {
                      _fadeForwardButtonAutoState.currentState!.animationRun();
                    }
                  },
                  child: CarouselSlider(
                    carouselController: carouselController,
                    // Give the controller
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      enableInfiniteScroll: false,
                      initialPage: widget.indexSelected,
                      height: double.infinity,
                      onPageChanged: (index, reason) {
                        // debugPrint(
                        //     " onPageChanged $index indexSelected ${widget.indexSelected} state ${state.indexSelected}");
                        context.read<DocumentBloc>().add(ShowDocumentEvent(
                            (widget.listText ?? [])[index].profileGuid!,
                            (widget.listText ?? [])[index].objectGuid,
                            (widget.listText ?? [])[index].fileName,
                            index,
                            false));
                      },
                      viewportFraction: 1,
                      autoPlay: false,
                    ),
                    items: (widget.listText ?? []).map((textDetail) {
                      return (state.bytes ?? {})
                          .containsKey(textDetail.objectGuid)
                          ? PDFView(
                        // key: UniqueKey(),
                        pdfData: (state.bytes ?? {})[textDetail.objectGuid],
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: Platform.isIOS ? true : false,
                        pageFling: false,
                        pageSnap: false,
                        fitEachPage: false,
                        gestureRecognizers: <
                            Factory<OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                                () => VerticalDragGestureRecognizer(),
                          ),
                        },
                        fitPolicy: FitPolicy.WIDTH,
                      )
                          : const Center(child: CircularProgressIndicator());
                    }).toList(),
                  ),
                ),
                /*const Align(
                                      alignment: Alignment.topCenter,
                                      child: NotificationInternet(),
                                    ),*/
                //NotificationInternet(),
              ),
            ),
            Visibility(
              visible: state.indexSelected != 0 &&
                  state.signOtpStatus is! ConfirmOtpSuccess,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: FadeButtonAuto(
                    key: _fadeBackButtonAutoState,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        carouselController.previousPage();
                      },
                      child: Container(
                          padding: const EdgeInsets.only(left: 5,right: 35,top: 18,bottom: 18),
                          child: SvgPicture.asset(IconAsset.icArrowBack)
                      ),
                    ),
                  )),
            ),
            Visibility(
                visible: state.signOtpStatus is! ConfirmOtpSuccess &&
                    state.indexSelected != (widget.listText ?? []).length - 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FadeButtonAuto(
                    key: _fadeForwardButtonAutoState,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        carouselController.nextPage();
                      },
                      child: Container(
                          padding: const EdgeInsets.only(left: 35,right: 5,top: 18,bottom: 18),
                          child: SvgPicture.asset(IconAsset.icArrowForward)
                      ),
                    ),
                  ),
                )),
          ],
        ),
        // )
      );
    });
  }

  refreshDocument(BuildContext context ,String titleName, int indexSelect) {
    //Bkav Nhungltk: refress document
    context.read<DocumentBloc>().add(RefreshDocumentEvent(titleName, indexSelect));
  }

  void showAgreeSign(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              // height: 307,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Xác thực OTP',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColor.black22),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Quý khách vui lòng nhập mã OTP được gửi về sđt để xác nhận đồng ý với thoải thuận Hỗ trợ lãi suất',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColor.black22),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const TextField(
                      decoration: InputDecoration(hintText: 'OPT'),
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ));
  }

  void createKeyBoard() {}
}
