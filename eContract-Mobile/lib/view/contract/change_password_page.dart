import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/change_password_status.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/button_widget.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/utils/widgets/notification_internet_widget.dart';
import 'package:e_contract/utils/widgets/text_form_input.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:e_contract/view_model/account/change_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ChangePassWordPage extends StatefulWidget {
   const ChangePassWordPage.init({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(const ChangePassWordPage.init(), true);
  }

  @override
  State<StatefulWidget> createState() => StateChangePassWordPage();
}

class StateChangePassWordPage extends State<ChangePassWordPage> {
  final TextEditingController _inputPassCurrent = TextEditingController();
  final TextEditingController _inputPassNew = TextEditingController();
  final TextEditingController _inputConfirmPassNew = TextEditingController();
  final FocusNode _focusNodePassCurrent = FocusNode();
  final FocusNode _focusNodePassNew = FocusNode();
  final FocusNode _focusConfirmPassNew = FocusNode();
  bool isVisibleErrorPassCurrent = false;
  bool isVisibleErrorPassNew = false;
  bool isVisibleErrorConfirmPass = false;
  String errorPassCurrent = "";
  String errorPassNew = "";
  String errorConfirmPassNew = "";
  final _formKey = GlobalKey<FormState>();
  ValidatePassFail? validatePassFail;
  ChangePasswordFailed? changePasswordFailed;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
          ForgetPasswordBloc(repository: context.read<Repository>()),
      child: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) async {
          Logger.logActivity("ForgetPassword changePass status (${state.formStatus}) ");
          if(state.formStatus is ChangePasswordSuccess){
            if(!mounted) return;
            DiaLogManager.displayDialog(context, S.of(context).change_pass_success_title, S.of(context).change_pass_success, () { },
                    () async {context.read<ForgetPasswordBloc>().add(Logout());
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil<void>(
                        await LoginPage.route(true), (route) => false);
                    if(!mounted) return;
                    Get.back();}, S.of(context).agree, "", dialogComplete: true);
          }
        },
        child: Scaffold(
            appBar: BkavAppBar(
              context,
              showDefaultBackButton: true,
              title: Text(
                S.of(context).change_password,
                style: StyleBkav.textStyleFW700(Colors.white, 20),
              ),
            ),
            body: Utils.bkavCheckOrientation(
              context, BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                if(state.formStatus is ValidatePassFail){
                  validatePassFail= state.formStatus as ValidatePassFail;
                }else if(state.formStatus is ChangePasswordFailed){
                  changePasswordFailed= state.formStatus as ChangePasswordFailed;
                }
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){FocusScope.of(context).unfocus();},
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              const NotificationInternet(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 25),
                                      child: TextFormFieldInput(
                                          S.of(context).pass_current,
                                          _inputPassCurrent,
                                          true,
                                          (state.formStatus is ChangePasswordFailed && changePasswordFailed?.stringError!="")? true: false,
                                          _focusNodePassCurrent,
                                          (state.formStatus is ChangePasswordFailed && changePasswordFailed?.stringError!="") ?
                                          changePasswordFailed!.stringError: S.of(context).pass_empty, (lostFocus){
                                        if(!lostFocus) {
                                          _focusNodePassNew.requestFocus();
                                        }
                                      }, true, checkAutofocus: true),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 25),
                                      child: TextFormFieldInput(
                                          S.of(context).pass_new,
                                          _inputPassNew,
                                          true,
                                          (state.formStatus is ValidatePassFail && validatePassFail?.errorPassNew!= "")? true: false,
                                          _focusNodePassNew,
                                          (state.formStatus is ValidatePassFail && validatePassFail?.errorPassNew!= "")? validatePassFail!.errorPassNew:
                                          S.of(context).pass_empty, (lostFocus){
                                        context.read<ForgetPasswordBloc>().add(
                                            ValidatePassNew(
                                                passCurrent: _inputPassCurrent.text,
                                                passNew: _inputPassNew.text,
                                                passNewConfirm: _inputConfirmPassNew.text,
                                                context: context));
                                        if(!lostFocus) {
                                          _focusConfirmPassNew.requestFocus();
                                        }
                                      }, true),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 25),
                                        child: TextFormFieldInput(
                                            S.of(context).confirm_pass_new,
                                            _inputConfirmPassNew,
                                            true,
                                            (state.formStatus is ValidatePassFail && validatePassFail?.errorPassNewConfirm!= "")? true: false,
                                            _focusConfirmPassNew,
                                            (state.formStatus is ValidatePassFail && validatePassFail?.errorPassNewConfirm!= "")?
                                            validatePassFail!.errorPassNewConfirm:
                                            S.of(context).pass_empty, (lostFocus){
                                          context.read<ForgetPasswordBloc>().add(
                                              ValidatePassNew(
                                                  passCurrent: _inputPassCurrent.text,
                                                  passNew: _inputPassNew.text,
                                                  passNewConfirm: _inputConfirmPassNew.text,
                                                  context: context));
                                          if(!lostFocus) {
                                            FocusScope.of(context).unfocus();
                                          }
                                        }, true)
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: Html(
                                        data: S.of(context).note_change_password,
                                        style: {
                                          "#": Style(
                                              textAlign: TextAlign.left,
                                              fontSize: FontSize(12),
                                              fontFamily: "Roboto",
                                              lineHeight: const LineHeight(1.5))
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 32, bottom: 20),
                                      width: double.infinity,
                                      child: BkavButton(
                                        text: S.of(context).change_password,
                                        onPressed: () {
                                          String passCurrent = _inputPassCurrent.text;
                                          String passNew = _inputPassNew.text;
                                          String confirmPassNew =
                                              _inputConfirmPassNew.text;
                                          _formKey.currentState!.validate();
                                          if(validatePassFail?.errorPassCurrent==""&& passCurrent.isNotEmpty){
                                            if(validatePassFail?.errorPassNew!= ""|| passNew.isEmpty){
                                              _focusNodePassNew.requestFocus();
                                            }else if(validatePassFail?.errorPassNewConfirm!= ""|| confirmPassNew.isEmpty){
                                              _focusConfirmPassNew.requestFocus();
                                            }
                                          }else{
                                            _focusNodePassCurrent.requestFocus();
                                          }
                                          if(changePasswordFailed!= null && changePasswordFailed?.stringError!= ""){
                                            _focusNodePassCurrent.requestFocus();
                                          }
                                          //if(passCurrent.isNotEmpty && passNew.isNotEmpty && confirmPassNew.isNotEmpty) {
                                          context.read<ForgetPasswordBloc>().add(
                                              ValidatePassNew(
                                                  passCurrent: passCurrent,
                                                  passNew: passNew,
                                                  passNewConfirm: confirmPassNew,
                                                  context: context,
                                                  submit: true));
                                          requestFocus();
                                          //}
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
            )),
      ),
    );
  }

  void requestFocus(){
    if(validatePassFail!= null){
      if(validatePassFail!.errorPassCurrent=="" && _inputPassCurrent.text.isNotEmpty) {
        if (validatePassFail!.errorPassNew != ""|| _inputPassNew.text.isEmpty) {
          _focusNodePassNew.requestFocus();
        } else if (validatePassFail!.errorPassNewConfirm != ""|| _inputConfirmPassNew.text.isEmpty) {
          _focusConfirmPassNew.requestFocus();
        }
      }else{
        _focusNodePassCurrent.requestFocus();
      }
    }else{
      if(_inputPassCurrent.text.isEmpty){
        _focusNodePassCurrent.requestFocus();
      }else if(_inputPassNew.text.isEmpty){
        _focusNodePassNew.requestFocus();
      }else if(_inputConfirmPassNew.text.isEmpty){
        _focusConfirmPassNew.requestFocus();
      }
    }
  }
}
