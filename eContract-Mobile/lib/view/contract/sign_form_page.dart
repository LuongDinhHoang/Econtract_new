import 'dart:async';

import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/api_constains.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/sign_otp_status.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/contract/sign_otp_page.dart';
import 'package:e_contract/view_model/contract/sign_form_bloc.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SignFormPage extends StatefulWidget {
  final String objectGuid;
  static bool isDialogShow = false; // xac dinh xem dialog co dang show k
  final String profileGuid; //objectGuid cua ho so
  final bool isSignDocumentPage;
  late final String fileName;
  final int? openSignPageTo;
  final bool isShowButtonSign;
  final bool isFrom;
  int indexSelected;

  SignFormPage.init({
    Key? key,
    required this.objectGuid,
    required this.profileGuid,
    required this.isSignDocumentPage,
    required this.fileName,
    this.openSignPageTo,
    required this.isShowButtonSign,
    required this.isFrom,
    required this.indexSelected,
  }) : super(key: key);

  static Route route(
    String id,
    String profileGuid,
    String fileName,
    int indexSelection,
    bool isShowButton,
    bool isFrom,
    bool isSignDoccument,
  ) {
    return Utils.pageRouteBuilder(
        SignFormPage.init(
          objectGuid: id,
          profileGuid: profileGuid,
          fileName: fileName,
          isSignDocumentPage: isSignDoccument,
          indexSelected: indexSelection,
          isShowButtonSign: isShowButton,
          isFrom: isFrom,
        ),
        true);
  }

  @override
  State<StatefulWidget> createState() => _SignFormPageState();
}

class _SignFormPageState extends State<SignFormPage> {
  int signType = 0;
  late var result = [];

  // thực hiện đếm ngược để ký remote signing
  int _counter = 0;
  late StreamController<String> _events;

  @override
  initState() {
    super.initState();
    _events = StreamController<String>.broadcast();
    _events.add("3 phút 20 giây"); // đếm ngược 3p20s
  }

  Timer? _timer;

  void _startTimer(BuildContext context, int time) {
    _counter = time;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //setState(() {
      if (_counter > 0) {
        _counter--;
      } else {
        _timer!.cancel();
        // show dialog het han
        if (ApiConstants.switchRemoteSigningOk) {
          // goi event tat timer call api lang nghe result
          context.read<SignFormBloc>().add(RemoteSigningFinishEvent());
          DiaLogManager.displayCancelRemoteSigningDialog(context, false, () {
            // ky lai thi goi lai api ky remote signing
            context
                .read<SignFormBloc>()
                .add(RemoteSigningSubmitEvent(widget.objectGuid));
          });
        } else {
          // dong dialog khi dem xong
          context.read<SignFormBloc>().add(RemoteSigningFinishEvent());
          Navigator.pop(context);
          SignFormPage.isDialogShow = false;
        }
      }
      //});
      // print(_counter);

      _events.add(
          "${_counter ~/ 60} ${S.of(context).minute} ${_counter % 60} ${S.of(context).second}");
    });
  }

  // thực hiện đếm ngược để ký remote signing: -end

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignFormBloc(context,
          repository: context.read<Repository>(),
          objectGuid: widget.profileGuid),
      child: BlocListener<SignFormBloc, SignFormState>(
          listener: (context, state) async {
            if (state.isSignRemoteSuccess && state.timeSignRS != 0) {
              Timer? t;
              _startTimer(context, state.timeSignRS);
              SignFormPage.isDialogShow = true;
              displayGuideRemoteSigningDialog(context, state.timeSignRS,() {
                // neu nhan huy va van chua launch app RS thi huy launch app
                if (t != null) {
                  t.cancel();
                }
                if (ApiConstants.switchRemoteSigningOk) {
                  context
                      .read<SignFormBloc>()
                      .add(RemoteSigningCancelSignEvent(state.transactionGuid));
                } else {
                  context.read<SignFormBloc>().add(RemoteSigningFinishEvent());
                  Navigator.pop(context);
                  SignFormPage.isDialogShow = false;
                }
              });
              // đợi 3s thì launch app bkab remote signing
              t = Timer(const Duration(seconds: 3), () async {
                await LaunchApp.openApp(
                  androidPackageName:
                      ContractConstants.bkavRemoteSigningPackageName,
                  iosUrlScheme: ContractConstants.bkavRemoteSigningUrlScheme,
                  appStoreLink: ContractConstants.bkavRemoteSigningUrlAppStore,
                  // openStore: false
                );
              });
            } else if (state.signOtpStatus is SendOtpFail &&
                state.signContractInfo != null &&
                state.sendingOTP == true) {
              //Get.back();
              //HoangLD để thời gian lên 3s để người dùng đọc thông báo
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                      "${state.signContractInfo?.errorMessage.replaceAll('"', '')}")));
              context
                  .read<SignFormBloc>()
                  .add(SendingOTPEvent(sendingOTP: false));
            } else if (state.signOtpStatus is SendOtpSuccess &&
                state.sendingOTP == true) {
/*              Get.back();
              context
                  .read<SignFormBloc>()
                  .add(SendingOTPEvent(sendingOTP: false));*/
              //Bkav Nhungltk: fix loi khong hien thi sdt trong giao dien nhap otp
              result = await Navigator.of(context).push(SignOtpPage.route(
                  widget.profileGuid,
                  widget.objectGuid,
                  widget.fileName,
                  state.signContractInfo?.phoneNumber,
                  widget.isFrom,
                  context,state.typeSign));
              if (result[6] !="") {
                Navigator.of(NavigationService.navigatorKey.currentContext!).pop(result);
/*                if (result[6] != "") {
                  */ /**Bkav Nhungltk: result[4]: ma ho so
                    result[5]: ten nguoi ky
                    result[6]: thoi gian ky*/ /*
                  Navigator.of(context).pop(result);
                }*/
              }else{
                context.read<SignFormBloc>()
                    .add(SendingOTPEvent(sendingOTP: false));
              }
            } else if (state.signOtpStatus is SendOtpEKYCSuccess &&
                state.sendingOTP == true) {

              String resultEKYC = await Navigator.of(context).push(SignOtpPage.route(
                  widget.profileGuid,
                  widget.objectGuid,
                  widget.fileName,
                  state.signContractInfo?.phoneNumber,
                  widget.isFrom,
                  context,ContractConstants.radioEKYC,checkEKYC: true));
              if (resultEKYC =="OK") {
                context.read<SignFormBloc>()
                    .add(SignEKYC(widget.profileGuid));
              }else if(resultEKYC ==""){
                context.read<SignFormBloc>()
                    .add(SendingOTPEvent(sendingOTP: false));
              }
            } else if (!state.statusSign) {
              setState(() {
/*
                isShowButtonSign = false;
*/
              });
            }else if(state.signOtpStatus is SendTokenHsmSuccess){
              Navigator.of(context).pop([widget.profileGuid, widget.objectGuid, widget.fileName, 0, state.contractSignInfo?.profileCode,
                state.contractSignInfo?.signerName, state.contractSignInfo?.signDate]);
            }
            if (!state.isSignRemoteSuccess) {
              if (_timer != null) {
                _timer!.cancel();
              }
              // print(" lister ok false ${SignFormPage.isDialogShow}");
            }
            if (state.signerName != "" ||
                state.profileCode != "" ||
                state.signDate != "") {
              // lam gi do sau khi thanh cong
              // print(
              //     " lister ok false ${state.signerName} === ${state.profileCode} --- ${state.signDate} ${SignFormPage.isDialogShow}");
              // dong dialog neu co
              if (SignFormPage.isDialogShow) {
                Navigator.of(context).pop();
                SignFormPage.isDialogShow = false;
              }
              // pop ve man hinh truoc do
              Navigator.of(context).pop([widget.profileGuid, widget.objectGuid, widget.fileName, 0, state.profileCode,
                state.signerName, state.signDate]);
              // pop ve goa
            }
          },
          child: WillPopScope(
            onWillPop: () async{
              Navigator.of(context).pop(
                  [widget.profileGuid, widget.objectGuid, widget.fileName, 0, "",
                    "", ""]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              return false;
            },
            child: Scaffold(
              appBar: BkavAppBar(
                context,
                showDefaultBackButton: false,
                title: Text(
                  S.of(context).sign_form,
                  style: StyleBkav.textStyleFW700(Colors.white, 20),
                ),
                leading: Container(
                  padding: const EdgeInsets.only(left: 6),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      IconAsset.icArrowLeft,
                      height: 24,
                      // color: Colors.,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(
                          [widget.profileGuid, widget.objectGuid, widget.fileName, 0, "",
                            "", ""]);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              body: Utils.bkavCheckOrientation(
                context, Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).sign_form_select,
                      textAlign: TextAlign.start,
                      style: StyleBkav.textStyleFW700(AppColor.black22, 16,
                          overflow: TextOverflow.visible, height: 1.2),
                      // textAlign: TextAlign.center,
                    ),
                    Expanded(
                        flex: 1,
                        child: BlocBuilder<SignFormBloc, SignFormState>(
                            builder: (context, state) {
                              return ListView.builder(
                                  itemCount: state.usersList.length,
                                  itemBuilder: (context, index) {
                                    return signTypeItem(
                                        context,
                                        index,
                                        state.usersList[index].name,
                                        state.usersList[index].description,
                                        state.usersList[index].isDisable,
                                        state.usersList[index].isCheck,
                                        state.clickList[index]);
                                  });
                            })),
                    //Bkav HanhNTHe: them vao de k bi 2 nut de len
                    const SizedBox(
                      height: 75,
                    )
                  ],
                ),
              ),
              ),
              bottomSheet: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(bottom: 16, left: 16),
                child: Row(
                  children: [
                  BlocBuilder<SignFormBloc, SignFormState>(
                  builder: (context, state) {
                  return Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: state.typeSign != 0 ? Colors.white : AppColor.cyan,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          Navigator.of(context).pop(
                              [widget.profileGuid, widget.objectGuid, widget.fileName, 0, "",
                                "", ""]);                             },
                        child: Text(S.of(context).close_dialog,
                            style: StyleBkav.textStyleFW700(state.typeSign != 0 ? AppColor.gray500 : Colors.white,14)),
                      ),
                    ),
                  );
                  }),

                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<SignFormBloc, SignFormState>(
                        builder: (context, state) {
                      return Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: state.typeSign != 0
                                    ? AppColor.cyan
                                    : AppColor.gray300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () async {
                              if (state.typeSign ==
                                  ContractConstants.radioRemoteSigning) {
                                /// lua chon la ky bang remote signing
                                context.read<SignFormBloc>().add(
                                    RemoteSigningSubmitEvent(widget.profileGuid));
                                DiaLogManager.displayLoadingDialog(context);
                              } else if (state.typeSign ==
                                  ContractConstants.radioHSM) {
                                /// Bkav HoangLD lua chon la ky bang HSM
                                /*context.read<SignFormBloc>().add(
                                    SignHSMDocumentEvent(widget.profileGuid));*/
                                context.read<SignFormBloc>().add(
                                    SignDocumentEvent(widget.profileGuid, context,
                                        widget.fileName,ContractConstants.radioHSM));
                                //DiaLogManager.displayLoadingDialog(context);
                              } else if (state.typeSign ==
                                  ContractConstants.radioOTP) {
                                /// lua chon la ky bang OTP
                                context.read<SignFormBloc>().add(
                                    SignDocumentEvent(widget.profileGuid, context,
                                        widget.fileName,ContractConstants.radioOTP));
                                /*context.read<SignFormBloc>().add(
                                    ShowDocumentEvent(widget.profileGuid, widget.objectGuid,
                                        widget.fileName, widget.indexSelected, false));*/
/*                                context
                                    .read<SignFormBloc>()
                                    .add(SendingOTPEvent(sendingOTP: true));
                                DiaLogManager.displayLoadingDialog(context);*/
                                // context
                                //     .read<SignFormBloc>()
                                //     .add(RemoteSigningSubmitEvent(objectGuid));
                              }else if (state.typeSign ==
                                  ContractConstants.radioEKYC){
                                context.read<SignFormBloc>().add(
                                    SignDocumentEvent(widget.profileGuid, context,
                                        widget.fileName,ContractConstants.radioEKYC));
                              }
                            },
                            child: Text(
                              S.of(context).continue_sign,
                              style: StyleBkav.textStyleFW700(Colors.white,14),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
  Widget signTypeItem(BuildContext context, int index, String name,
      String description, bool isDisable, bool isCheck, bool checkClick) {
    return BlocBuilder<SignFormBloc, SignFormState>(builder: (context, state) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          if (!isDisable) {
            setState(() {
              List<bool> clickList = [];
              clickList.addAll(List<bool>.generate(state.usersList.length, (i) => false));
              for (var i = 0; i < state.usersList.length; i++) {
                clickList[i] = false;
              }
              clickList[index] = true;
              context.read<SignFormBloc>().add(RadioChangeEvent(
                  state.usersList[index].id, clickList));
              /*print(state.usersList[index].id);*/
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                  scale: 1.1,
                  child: Radio<bool>(
                    fillColor: isDisable
                        ? MaterialStateColor.resolveWith(
                            (states) => Colors.black26)
                        : state.typeSign == state.usersList[index].id
                            ? MaterialStateColor.resolveWith(
                                (states) => AppColor.cyan)
                            : MaterialStateColor.resolveWith(
                                (states) => AppColor.black22),
                    activeColor: Colors.blue,
                    hoverColor: Colors.blue,
                    focusColor: Colors.blue,
                    value: checkClick,
                    groupValue: true,
                    onChanged: (bool? value) {
                      if (!isDisable) {
                        setState(() {
                          List<bool> clickList = [];
                          clickList.addAll(List<bool>.generate(state.usersList.length, (i) => false));
                          clickList[index] = true;
                          context.read<SignFormBloc>().add(RadioChangeEvent(
                              state.usersList[index].id, clickList));
                        });
                      }
                    },
                  )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: isDisable
                        ? StyleBkav.textBlack700Size14(color: AppColor.gray400)
                        : StyleBkav.textBlack700Size14(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 6),
                    child: Html(
                        data: description,
                        /*onLinkTap: (link) async {
                          if (await canLaunch(link!)) {
                            await launch(
                              link,
                            );
                          } else {
                            throw 'Could not launch $link';
                          }
                        },*/
                        style: {
                          "body": isDisable
                              ? Style(
                                  margin: Margins(
                                    bottom: Margin.zero(),
                                    left: Margin.zero(),
                                    top: Margin.zero(),
                                    right: Margin.zero(),
                                  ),
                                  fontSize: FontSize(14),
                                  color: AppColor.gray400,
                                  fontWeight: FontWeight.w400)
                              : Style(
                                  margin: Margins(
                                    bottom: Margin.zero(),
                                    left: Margin.zero(),
                                    top: Margin.zero(),
                                    right: Margin.zero(),
                                  ),
                                  fontSize: FontSize(14),
                                  color: AppColor.black22,
                                  fontWeight: FontWeight.w400)
                        }),
                  ),
                ],
              ))
            ],
          ),
        ),
      );
    });
  }

  Future<void> displayGuideRemoteSigningDialog(
      BuildContext context, int timeRS,VoidCallback onCancelSign) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 24),
                    child: SvgPicture.asset(
                      IconAsset.icSignRemoteSuccess,
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, right: 16, left: 16),
                    child: Text(
                      S.of(context).remote_guide,
                      textAlign: TextAlign.center,
                      style: StyleBkav.textStyleBlack16NotOverflow(),
                    ),
                  ),
                  StreamBuilder<String>(
                      stream: _events.stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        // print(snapshot.data.toString());
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, right: 10, left: 10),
                          child: Html(
                            data:
                                "${S.of(context).remote_guide_content} <font color= '#08B7DD'><b>${snapshot.data ?? "${timeRS~/60} ${S.of(context).minute} ${timeRS%60} ${S.of(context).second}"}</b></font>",
                            style: {
                              "#": Style(
                                  textAlign: TextAlign.center,
                                  fontSize: FontSize(14),
                                  fontFamily: "Roboto",
                                  lineHeight: const LineHeight(1.5))
                            },
                          ),
                        );
                      }),
                  const Divider(
                    color: AppColor.gray300,
                    height: 1.0,
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onCancelSign,
                      child: InkWell(
                        child: SizedBox(
                          height: 52,
                          child: Center(
                            child: Text(
                                ApiConstants.switchRemoteSigningOk
                                    ? S.of(context).cancel_sign_remote_signing
                                    : S.of(context).cancel,
                                textAlign: TextAlign.center,
                                style: StyleBkav.textStyleFW700(
                                    AppColor.cyan, 15)),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
