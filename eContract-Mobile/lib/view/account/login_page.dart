import 'dart:convert';
import 'dart:io';

import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/api_constains.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/form_submission_status.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/button_widget.dart';
import 'package:e_contract/utils/widgets/text_form_input.dart';
import 'package:e_contract/view/contract/sign_form_page.dart';
import 'package:e_contract/view/home/home_page.dart';
import 'package:e_contract/view_model/account/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view_model/contract/contract_support_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.lastUserName, required this.isFaceId, required this.isFingerprint, required this.isChangeIOS, required this.checkUsers ,this.checkAutofocus = false}) : super(key: key);
  final String lastUserName;
  final bool isFaceId;
  final bool isFingerprint;
  final bool isChangeIOS;
  final bool checkUsers;
  final bool checkAutofocus;



  static Future<Route> route(bool isLoadingNext ,{bool isAutofocus = false}) async {
    //final pref = await SharedPreferences.getInstance();
    String userName = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "";
    bool statusFaceID = await Utils.statusFaceID();
    bool statusFingerprint = await Utils.statusFingerprint();
    bool statusBiometricChangeIOS = await Utils.checkBiometricsChangeIos();
    bool checkUsers = (await SharedPrefs.instance()).getBool(SharedPreferencesKey.checkUsers) ?? false;
    if(isLoadingNext){
      return MaterialPageRoute(
          builder: (_) => LoginPage(
              lastUserName: userName,
              isFaceId: statusFaceID,
              isFingerprint: statusFingerprint,
              isChangeIOS: statusBiometricChangeIOS,
              checkUsers: checkUsers,
              checkAutofocus: isAutofocus,
          ));
    }else{
      return Utils.pageRouteBuilder(
          LoginPage(
              lastUserName: userName,
              isFaceId: statusFaceID,
              isFingerprint: statusFingerprint,
              isChangeIOS: statusBiometricChangeIOS,
              checkUsers: checkUsers,
              checkAutofocus: isAutofocus,
          ),false);
    }
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver{
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _inputUsernameController;

  final TextEditingController _inputPasswordController =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDialogShowing = false;
  bool _keyboardIsOpen = true;
  bool _isClickSupportMes = false;
  bool _isClickSupportTel = false;
  bool _isClickSupportZalo = false;

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  void initState() {
    super.initState();
    _inputUsernameController = TextEditingController(text: widget.lastUserName);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,// làm trong suốt statusbar
          statusBarIconBrightness: Brightness.dark,// icon statusbar màu trắng
        )
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
      if(state == AppLifecycleState.resumed){
        setState(() {
          _isClickSupportZalo = false;
          _isClickSupportMes = false;
          _isClickSupportTel = false;
        });
        //Bkav HoangLD fix bug thoát app mà vẫn có dữ liệu database thì set trở lại giao diện
    }if(state == AppLifecycleState.inactive){
        List<UserInfo> list = await EContractDb.instance.allUserEntries;
        if(list.isNotEmpty){
          //final SharedPreferences prefs = await SharedPreferences.getInstance();
          (await SharedPrefs.instance()).setBool(SharedPreferencesKey.checkUsers, true);
          (await SharedPrefs.instance()).setString(SharedPreferencesKey.userName,list.first.userName??"");
        }
      }
  }

  @override
  dispose(){
    //Bkav HoangLD chuyển qua hàm này để tránh tự động huỷ xoay màn hình
    //Bkav HoangLD comment tạm hàm này lại,không hiểu sao khu từ màn user về màn login tự tự động nhảy vào dispose
/*    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
            body: Utils.bkavCheckOrientation(
              context, SingleChildScrollView(
                  child: Container(
          //Bkav Nhungltk: diem diem giao dien
          alignment: const Alignment(0, -0.408),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAsset.loginBackground),
                  fit: BoxFit.cover),
          ),
          child: BlocProvider(
              create: (context) => LoginBloc(
                widget.isFaceId,
                widget.isFingerprint,
                widget.lastUserName,
                context,
                widget.isChangeIOS,
                repository: context.read<Repository>()
              ),
              child: _loginForm(context),
          ),
        )),
            ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _fabButton(),
        ));
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          final formStatus = state.formStatus;
          if (_isDialogShowing) {
            _isDialogShowing = false; // set it `false` since dialog is closed
            Navigator.of(context).pop();
          }
          if (formStatus is SubmissionFailed) {
            // Bkav HanhNTHe: if login false => show snack bar with message
            //_showSnackBar(context, formStatus.exception.toString());
          } else if (formStatus is SubmissionSuccess) {
            Navigator.of(context).pushAndRemoveUntil<void>(
                await HomePage.route(), (route) => false);
          } else if (formStatus is FormSubmitting) {
            //_showLoaderDialog(context);
          }
        },
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _logoWidgetLogin(),
                        _usernameField(context),
                        _passwordField(),
                        //Bkav HoangLD bỏ checkbox duy trì đăng nhập
                        //_forgetPassword(context),
                        _rowButton(),
                        Platform.isAndroid?_textBy():Container()
                      ],
                    ),
              ),
            )));
  }
  Widget _logoWidgetLogin() {
    return  Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SvgPicture.asset(
              IconAsset.icLogoBkav,
          width: 250,
          height: 40,),
          const SizedBox(
            height: 16,
          ),
          _notifiLoginError(),
          const SizedBox(
            height: 16,
          ),
          Text(
            S.of(context).button_login,
            style: StyleBkav.textStyleFW700(AppColor.cyan, 24),
          )
        ],
      ),
    );
  }
  //Bkav Nhungltk: thong bao loi dang nhap
  Widget _notifiLoginError() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      final formStatus = state.formStatus;
      if (formStatus is SubmissionFailed) {
        String errorLogin = formStatus.exception.toString();
        //Bkav HoangLD fix bug BECM-522
        return Text(
          errorLogin,
          textAlign: TextAlign.center,
          style: StyleBkav.textStyleFW700(AppColor.redE1, 14,overflow: TextOverflow.clip),
        );
      }
      if (formStatus is SubmissionBiometricFailed) {
        String errorLogin = formStatus.exception.toString();
        return Container(
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          child: Text(
            errorLogin,
            textAlign: TextAlign.center,
            style: StyleBkav.textStyleFW400NotOverflow(AppColor.redE1, 14),
          ),
        );
      }
      return const SizedBox(
        height: 15,
      );
    });
  }

  Widget _usernameField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return Focus(
      child: Container(
          margin: const EdgeInsets.only(top: 30), //Bkav Nhungltk
          child: TextFormFieldInput(
              S.of(context).label_user_name,
              _inputUsernameController,
              false,
              false,
              _focusNodeName,
              "${S.of(context).error_input_empty}${S.of(context).label_user_name.toLowerCase()} !",(lostFocus){}, false,
          checkUser: widget.checkUsers,checkAutofocus: widget.checkAutofocus)),
      onFocusChange: (hasFocus) {
        if(hasFocus) {
          context.read<LoginBloc>().add(EventFocusTextField());
        }
      },
    );
  });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Material(
        child: Focus(
          child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: TextFormFieldInput(
                  S.of(context).label_password,
                  _inputPasswordController,
                  true,
                  false,
                  _focusNodePassword,
                  "${S.of(context).error_input_empty}${S.of(context).label_password.toLowerCase()} !",(lostFocus){
              }, false)),
          onFocusChange: (hasFocus) {
            if(hasFocus) {
              context.read<LoginBloc>().add(EventFocusTextField());
            }
          },
        ),
      );
    });
  }

  Widget _checkboxRememberLogin() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
                value: state.isRememberLogin,
                onChanged: (bool? value) {
                  context.read<LoginBloc>().add(RememberLoginChanged(value!));
                }),
          ),
          Container(
            //Bkav Nhungltk: diem diem giao dien
            padding: const EdgeInsets.only(left: 10),
            child: Text(S.of(context).keep_login,
                style: StyleBkav.textStyleBlack14()),
          ),
        ],
      );
    });
  }

  Widget _forgetPassword(BuildContext context) {
    return Container(
      //Bkav Nhungltk: diem diem giao dien
      height: 24,
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _checkboxRememberLogin(),
          //Bkav HoangCV: khi kich thuoc lon cho text nay xuong dong
          /*
          Bkav DucLQ TODO: tam comment button nay do chua ho cho tinh nang
          Flexible(
            flex: 1,
            child: TextButton(
              //Bkav Nhungltk: diem diem giao dien
              style: TextButton.styleFrom(
                primary: AppColor.cyan,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                //Bkav Nhungltk: quen mat khau
              },
              child: Text(S.of(context).forgot_password,
                  style: StyleBkav.textStyleFW400(null, 14,
                      overflow: TextOverflow.visible)),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return (state.formStatus is FormSubmitting)
          ? SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))
                    .copyWith(
                  elevation: MaterialStateProperty.resolveWith(
                    (states) {
                      return 0;
                    },
                  ),
                ),
                onPressed: () {},
                child: const Center(
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            )
          : BkavButton(
              text: S.of(context).button_login,
              onPressed: () async {
                //Bkav Nhungltk: auto focus vao truong du lieu trong tu tren xuong duoi
                if (_inputUsernameController.text.isEmpty) {
                  _focusNodeName.requestFocus();
                } else {
                  if (_inputPasswordController.text.isEmpty) {
                    _focusNodePassword.requestFocus();
                  }
                }
                _formKey.currentState!.validate();
                if (_inputUsernameController.text.isNotEmpty &&
                    _inputPasswordController.text.isNotEmpty) {
                  context.read<LoginBloc>().add(LoginSubmitted(
                      _inputUsernameController.text,
                      _inputPasswordController.text,
                      false,
                      BiometricType.iris,
                      widget.isChangeIOS,_scaffoldKey.currentContext!));
                }
              }
              );
    });
  }

  Widget _rowButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
          height: 50,
          margin: const EdgeInsets.only(top: 33),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: _loginButton()),
              Container(
                alignment: Alignment.centerRight, //Bkav Nhungltk
                child: FutureBuilder(
                    future: Utils.isBiometricSupport(),
                    builder: (BuildContext context,
                        AsyncSnapshot<BiometricType> snapshot) {
                      if (snapshot.data == BiometricType.face) {
                        //Bkav Nhungltk: fix loi icon khong can sat le phai do ImageButton luon co vung dem mac dinh
                        return GestureDetector(
                          child: Padding(
                              //Bkav Nhungltk: diem diem giao dien
                              padding: const EdgeInsets.only(left: 20),
                              child: Image.asset(
                                IconAsset.faceId,
                                width: 36,
                                height: 36,
                              )),
                          onTap: () async {
                            //final pref = await SharedPreferences.getInstance();
                            bool isBiometricLogin = (await SharedPrefs.instance()).getBool("${state.username}_${SharedPreferencesKey.isBiometricLogin}") ?? true;
                            if(isBiometricLogin){
                              context.read<LoginBloc>().add(LoginBiometric(
                                  _inputUsernameController.text,
                                  BiometricType.face,
                                  _scaffoldKey.currentContext!,
                                  widget.isChangeIOS));
                            }else{
                              context.read<LoginBloc>().add(NotClickBiometric(BiometricType.face, context));
                            }
                          },
                        );
                      } else if (snapshot.data == BiometricType.fingerprint) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              IconAsset.touchIc,
                              width: 36,
                              height: 36,
                            ),
                          ),
                          onTap: () async {
                            //final pref = await SharedPreferences.getInstance();
                            bool isBiometricLogin = (await SharedPrefs.instance()).getBool("${state.username}_${SharedPreferencesKey.isBiometricLogin}") ?? true;
                            if(isBiometricLogin){
                              context.read<LoginBloc>().add(LoginBiometric(
                                  _inputUsernameController.text,
                                  BiometricType.fingerprint,
                                  _scaffoldKey.currentContext!,
                                  widget.isChangeIOS));
                            }else{
                              context.read<LoginBloc>().add(NotClickBiometric(BiometricType.fingerprint, context));
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ));
    });
  }
  Future<void> _launchUrl(String url, {required LaunchMode mode}) async {
    Uri uriBy = Uri.parse(url);
    if (!await launchUrl(uriBy, mode: mode)) {

    }
  }
  Widget _textBy() {
    return BlocProvider(
      create: (context) => SupportAContractBloc(
          repository: context.read<Repository>()),

      child: BlocBuilder<SupportAContractBloc, SupportAContractState>(
          builder: (context,state) {
            return Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text(S.of(context).no_user,
                    style: StyleBkav.textStyleBlack14()),
                GestureDetector(
                  onTap: (){
                    if(Platform.isIOS){
                      //Bkav DucLQ neu tren ios thi chi chuyen sang trang gioi thieu san pham de tranh report google
                      //_launchUrl("https://econtract.vn/", mode: LaunchMode.inAppWebView);
                    }else {
                      _launchUrl(state.listUrlSupport.url[5], mode: LaunchMode.platformDefault);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(S.of(context).buy,
                        style: StyleBkav.textStyleFW700(AppColor.cyan, 14)),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  Widget _fabButton() {
    return BlocProvider(
      create: (context) => SupportAContractBloc(
          repository: context.read<Repository>()),

      child: BlocBuilder<SupportAContractBloc, SupportAContractState>(
        builder: (context,state) {
        return Visibility(
          visible: !_keyboardIsOpen && state.callApiError,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: !_isClickSupportZalo,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        heroTag: "zalo",
                        onPressed: () async {
                          setState(() {
                            _isClickSupportZalo = true;
                          });
                          //Bkav HoangLD thêm await để chờ sự kiện này xong thì setstate lại tránh giật lang
                          await Utils.launchInBrowser(state.listUrlSupport.url[0]);
                          setState(() {
                            _isClickSupportZalo = false;
                          });
                        },
                        child: Image.asset(
                          ImageAsset.imageZalo,
                          height: 26.49,
                          width: 30.07,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isClickSupportZalo,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {  },
                        child: const CircularProgressIndicator(color: AppColor.cyan),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                      Visibility(
                        visible: !_isClickSupportMes,
                        child: SizedBox(
                    height: 48,
                    width: 48,
                    child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        heroTag: "messenger",
                        onPressed: () async {
                          setState(() {
                            _isClickSupportMes = true;
                          });
                          await Utils.launchInBrowser(state.listUrlSupport.url[1]);
                          setState(() {
                            _isClickSupportMes = false;
                          });
                        },
                        child: Image.asset(
                          ImageAsset.imageMessenger,
                          height: 26,
                          width: 26,
                        )
                    ),
                  ),
                      ),
                  Visibility(
                    visible: _isClickSupportMes,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        heroTag: "loading",
                        backgroundColor: Colors.white,
                        onPressed: () {  },
                        child: const CircularProgressIndicator(color: AppColor.cyan),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                  Visibility(
                    visible: !_isClickSupportTel,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          heroTag: "telephone",
                          onPressed: () async {
                            setState(() {
                              _isClickSupportTel = true;
                            });
                            await Utils.launchInBrowser(state.listUrlSupport.url[4]);
                            setState(() {
                              _isClickSupportTel = false;
                            });
                          },
                          child: Image.asset(
                            ImageAsset.imageTelephone,
                            height: 26,
                            width: 26,
                          )
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isClickSupportTel,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        heroTag: "loading",
                        backgroundColor: Colors.white,
                        onPressed: () {  },
                        child: const CircularProgressIndicator(color: AppColor.cyan),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );}
      ),
    );
  }
}
