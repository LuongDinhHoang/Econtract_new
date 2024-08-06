import 'dart:async';
import 'dart:math';

import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/sign_otp_status.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/view_model/contract/show_dcument_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

///Bkav Nhungltk: input otp code
class SignOtpPage extends StatefulWidget {
  final String profileGuid;// objectGuid cua ho so
  final String objectGuid;// objectGuid cua ProfileTextDetail
  final String fileName;
  final String phoneNumber;
  final bool isFrom;
  final BuildContext? context;
  final int typeSign;
  final bool checkSignEKYC;

   const SignOtpPage.init({Key? key,
    required this.profileGuid,
    required this.objectGuid,
    required this.fileName,
    required this.phoneNumber,
    required this.isFrom,
  this.context, required this.typeSign, required this.checkSignEKYC})
      : super(key: key);

  static Route route(String profileGuid, String objectGuid, String fileName, String? phoneNumber, bool isFrom, BuildContext context, int typeSign,
      {bool checkEKYC = false}) {
    return MaterialPageRoute(
        builder: (_) =>
            SignOtpPage.init(
              profileGuid: profileGuid,
              objectGuid: objectGuid,
              fileName: fileName,
              phoneNumber: phoneNumber ?? "",
              isFrom: isFrom,
              context: context, typeSign: typeSign,
              checkSignEKYC: checkEKYC,
            ));
  }

  @override
  State<StatefulWidget> createState() =>StateSignOtpPage();
}
class StateSignOtpPage extends State<SignOtpPage> with TickerProviderStateMixin{
  int currentTime= 30;
  bool reSendOTP= true;
  bool countTime= true;
  late AnimationController _controller;
  late Timer _timer;
  TextEditingController controler= TextEditingController();
  FocusNode focusNode= FocusNode();

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    //controler.dispose();
    super.dispose();
  }

  @override
  initState(){
    Logger.loggerDebug("=================Nhungltk init sign otp");
    _controller= AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  void countDownTimer(){
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (currentTime == 0) {
          setState(() {
            reSendOTP= false;
            timer.cancel();
          });
        } else if(_timer.isActive){
          setState(() {
            reSendOTP= true;
            currentTime--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    Logger.logActivity("Show Sign OTP Page");
    return BlocProvider(
        create: (context) => DocumentBloc(
            repository: context.read<Repository>(),
            profileGuid: widget.profileGuid,
            objectGuid: widget.objectGuid,
            titleFile: widget.fileName),
        child: BlocListener<DocumentBloc, DocumentState>(
            listener: (context, state) async {
              if(state.countTime== true && countTime==true){
                setState(() {
                  countTime= false;
                });
                context.read<DocumentBloc>().add(CountTimer(countTime: false));
                countDownTimer();
              }
              if(state.signOtpStatus is ConfirmOtpSuccess){
                if(widget.checkSignEKYC){
                  Navigator.of(buildContext).pop("OK");
                }else{
                  Navigator.of(buildContext).pop([widget.profileGuid, widget.objectGuid, widget.fileName, 0, state.contractSignInfo?.profileCode,
                    state.contractSignInfo?.signerName, state.contractSignInfo?.signDate]);
                }
              }
              if(state.signOtpStatus is SendOtpFail || state.signOtpStatus is ConfirmOTPStatus){
                if(_timer.isActive){
                  _timer.cancel();
                }
              }
            },
            child: WillPopScope(
              onWillPop: () async{
                    _timer.cancel();
                    if(widget.checkSignEKYC){
                      Navigator.of(buildContext).pop("");
                    }else{
                      Navigator.of(buildContext).pop(
                          [widget.profileGuid, widget.objectGuid, widget.fileName, 0, "",
                            "", "", widget.context]);
                    }
                return false;
              },
              child: Scaffold(
                  appBar: BkavAppBar(context,
                    showDefaultBackButton: false,
                    title: Text(
                        S.of(context).title_sign_otp,
                        style: StyleBkav.textStyleGray20()
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
                          _timer.cancel();
                          if(widget.checkSignEKYC){
                            Navigator.of(buildContext).pop("");
                          }else{
                            Navigator.of(buildContext).pop(
                                [widget.profileGuid, widget.objectGuid, widget.fileName, 0, "",
                                  "", "", widget.context]);
                          }
                        },
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  body: Utils.bkavCheckOrientation(context, BlocBuilder<DocumentBloc, DocumentState>(
                      builder: (buildContext, state) {
                        _controller.forward().then((value) => _controller.reverse());
                        double width = MediaQuery.of(context).size.width;
                        return Scaffold(
                          backgroundColor: Colors.white,
                          body: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
                                  child: RichText(
                                    text:
                                    customContentInputOTP(widget.fileName, widget.phoneNumber, context),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 32),
                                  child: SizedBox(
                                    width: 260,
                                    child: PinCodeTextField(
                                      focusNode: focusNode,
                                      controller: controler,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      enablePinAutofill: true,
                                      keyboardType: TextInputType.number,
                                      appContext: context,
                                      length: 6,
                                      autoFocus: true,
                                      obscureText: false,
                                      obscuringCharacter: '*',
                                      cursorHeight: 2,
                                      cursorWidth: 9,
                                      animationType: AnimationType.fade,
                                      // validator: (v) {
                                      //   Logger.loggerDebug("nhungltk validator: ${v}");
                                      //   addEventConfirmOTP(buildContext, v!, widget.isFrom, widget.profileGuid);
                                      // },
                                      pinTheme: PinTheme(
                                        selectedColor: AppColor.gray400,
                                        disabledColor: AppColor.gray400,
                                        inactiveColor: AppColor.gray400,
                                        activeColor: AppColor.gray400,
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(8),
                                        fieldHeight: 36,
                                        fieldWidth: 36,
                                      ),
                                      autoDisposeControllers: false,
                                      cursorColor: AppColor.black22,
                                      animationDuration: const Duration(milliseconds: 300),
                                      textStyle: (state.signOtpStatus is ConfirmOtpFail)? StyleBkav.textStyleFW700(AppColor.redE5, 20):
                                      StyleBkav.textStyleFW700(AppColor.cyan, 20),
                                      onCompleted: (v) {
                                        Logger.loggerDebug("nhungltk status sign confirm: ${widget.profileGuid}");
                                        if(_timer.isActive) {
                                          _timer.cancel();
                                        }
                                        addEventConfirmOTP(buildContext, v, widget.isFrom, widget.profileGuid, widget.typeSign);
                                      },
                                      onChanged: (value) {
                                        //   Logger.loggerDebug("nhungltk change: ${value.length}");
                                        //   addEventConfirmOTP(buildContext, value, widget.isFrom, widget.profileGuid);
                                      },
                                      beforeTextPaste: (text) {
                                        return true;
                                      },
                                    ),
                                  ),
                                ),
                                (state.signOtpStatus is ConfirmOtpFail) ? Container(alignment: Alignment.center,margin: const EdgeInsets.only(top: 14, left: 16, right: 16),child:
                                Html(data: state.contractSignInfo!.errorMessage.replaceAll('"', ''), style: {
                                  "#": Style(fontSize: FontSize(15), color: AppColor.redE5, textOverflow: TextOverflow.visible,
                                      textAlign: TextAlign.center)
                                },)) : (state.signOtpStatus is SendOtpFail)? Html(data:state.signContractInfo!.errorMessage.replaceAll('"', ''),
                                style:{"#": Style(fontSize: FontSize(15), color: AppColor.black22, textOverflow: TextOverflow.visible,
                                    textAlign: TextAlign.center)},): Container(),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: (state.signOtpStatus is SendOtp  || (state.signOtpStatus is SendOtpSuccess
                                            //&&
                                            //state.signOtpStatus is! ConfirmOTPStatus
                                        )
                                             //|| state.signOtpStatus is SendOtpFail &&
                                            // currentTime!= 0 && reSendOTP==true && state.signContractInfo?.errorMessage==null
                                        ) && currentTime!= 0 ?null: () async{
                                          buildContext.read<DocumentBloc>().add(
                                              SignDocumentEvent(
                                                  widget.profileGuid, context, widget.fileName, widget.typeSign));
                                          controler.clear();
                                          focusNode.requestFocus();
                                          setState(() {
                                            reSendOTP= true;
                                            currentTime= 30;
                                            countTime= true;
                                          });
                                          buildContext.read<DocumentBloc>().add(CountTimer(countTime: true));
                                        },
                                        child: Text(S.of(context).resend_otp,style: (state.signOtpStatus is SendOtp  || /*(*/state.signOtpStatus is SendOtpSuccess /*&&
                                            state.signOtpStatus is! ConfirmOTPStatus  && currentTime !=0)|| state.signOtpStatus is SendOtpFail &&
                                            currentTime!= 0 && reSendOTP==true && state.signContractInfo?.errorMessage==null*/) && currentTime!= 0 ?
                                        StyleBkav.textStyleFW700(AppColor.cyanDisible, 15): StyleBkav.textStyleFW700(AppColor.cyan, 15),),
                                      ),
                                      Visibility(visible: (state.signOtpStatus is SendOtp  || (state.signOtpStatus is SendOtpSuccess /*&&
                                          state.signOtpStatus is! ConfirmOTPStatus  && currentTime !=0*/)/*|| state.signOtpStatus is SendOtpFail &&
                                          currentTime!= 0 && reSendOTP==true && state.signContractInfo?.errorMessage==null*/) && currentTime!= 0? true: false,
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 20),
                                            alignment: Alignment.center,
                                            child: Stack(
                                        alignment: Alignment.center,
                                        fit: StackFit.loose,
                                        children: [const DashedCircle(size: 39,stringIcon: IconAsset.icLoadOtp),
                                            Container(alignment: Alignment.center,padding: const EdgeInsets.all(5),child:
                                            Text("$currentTime", style: StyleBkav.textStyleGray400weight600(),textAlign: TextAlign.center,),),
                                        ],),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
              )),
            )
    ));
  }

  //Bkav Nhungltk: sendOTP
  void addEventConfirmOTP(BuildContext buildContext, String otp, bool isFrom, String profileGuid, int typeSign){
    if(otp.length==6) {
      buildContext.read<DocumentBloc>().add(
          ConfirmOTP(profileGuid: profileGuid, otp: otp, isFrom: isFrom ,typeSign: typeSign,checkEKYC: widget.checkSignEKYC));
      setState(() {
        reSendOTP= false;
      });
    }
  }

  TextSpan customContentInputOTP(
      String nameContract, String sdt, BuildContext context) {
    List<String> name = S.of(context).content_input_otp.split(' ');
    List<TextSpan> listTextSpan = [];
    for (int i = 0; i < name.length; i++) {
      if (name[i] == "sđt") {
        listTextSpan.add(TextSpan(
            text: "$sdt ",
            style: StyleBkav.textStyleFW700(AppColor.black22, 15,
                overflow: TextOverflow.visible)));
      } else {
        listTextSpan.add(TextSpan(
            text: "${name[i]} ",
            style: StyleBkav.textStyleFW400(AppColor.black22, 15,
                overflow: TextOverflow.visible)));
      }
    }
    listTextSpan.add(TextSpan(
        text: "$nameContract ",
        style: StyleBkav.textStyleFW700(AppColor.black22, 15,
            overflow: TextOverflow.visible)));
    return TextSpan(children: listTextSpan);
  }
}

//Bakv Nhungltk: progress bar timer count down
class CircularBorder extends StatelessWidget {
  final double size;
  final double width;
  final Widget icon;
  final String stringIcon;

  const CircularBorder({required this.size ,this.width =4.0, required this.icon, required this.stringIcon}): super();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(stringIcon),
    );
  }
}
class DashedCircle extends StatefulWidget {
  final double size;
  final String stringIcon;

  const DashedCircle ({Key? key,  required this.size,required this.stringIcon }) : super(key: key);


  @override
  DashedBorderState createState() => DashedBorderState();
}

class DashedBorderState extends State<DashedCircle> with TickerProviderStateMixin<DashedCircle> {

  late final AnimationController _controller =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: CircularBorder(icon: Container(),size: widget.size,stringIcon: widget.stringIcon),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
