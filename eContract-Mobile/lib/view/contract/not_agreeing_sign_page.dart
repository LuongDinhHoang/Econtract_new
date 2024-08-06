import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/form_submission_status.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/button_widget.dart';
import 'package:e_contract/utils/widgets/notification_internet_widget.dart';
import 'package:e_contract/view_model/contract/not_agreeing_sign_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

///Bkav TungDV Giao diện từ chối ký
class NotAgreeingSignPage extends StatefulWidget {
  final String objectGuid;
  final bool isContractFrom;

  const NotAgreeingSignPage({Key? key, required this.objectGuid, required this.isContractFrom})
      : super(key: key);

  const NotAgreeingSignPage.init(this.objectGuid, {Key? key, required this.isContractFrom}) : super(key: key);

  static Route route(String id, bool isFrom) {
    return Utils.pageRouteBuilder(NotAgreeingSignPage.init(id,isContractFrom: isFrom),false);
  }

  @override
  NotAgreeingSignPageState createState() => NotAgreeingSignPageState();
}

class NotAgreeingSignPageState extends State<NotAgreeingSignPage> {
  FormSubmissionStatus isValidate = const InitialFormStatus();
  String errorValidate = "";

  final TextEditingController _contentController = TextEditingController();
  bool checkButton = false;

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show RejectSignPage");
    return BlocProvider(
      create: (context) => NotAgreeingSignBloc(isValidate, errorValidate,
          context.read<Repository>(), widget.objectGuid, context, widget.isContractFrom),
      child: BlocListener<NotAgreeingSignBloc, NotAgreeingSignState>(
          listener: (context, state) async {
            if (state.formSubmissionStatus is FormSubmitting) {
              Get.dialog(const AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))));
              // DiaLogManager.displayLoadingDialog(context);
            }
            // else if (state.formSubmissionStatus is SubmissionSuccess) {
            //   Navigator.of(context).pop();
            // }
          },
      child: Scaffold(
        appBar: BkavAppBar(
          context,
          title: Text(
            S.of(context).reasons_not_agreeing_sign,
            style: StyleBkav.textStyleGray20(),
          ),
          showDefaultBackButton: true,
        ),
        body: Utils.bkavCheckOrientation(
          context,
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const NotificationInternet(),
                Expanded(
                  child: BlocBuilder<NotAgreeingSignBloc, NotAgreeingSignState>(
                      builder: (context, state) {
                        return Padding(
                            padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
                            child: SizedBox(
                                height: double.infinity,
                                child: TextField(
                                    onChanged: (text) =>{
                                        context
                                            .read<NotAgreeingSignBloc>()
                                            .add(ValidateChange(text)),
                                    },
                                    controller: _contentController,
                                    autofocus: true,
                                    minLines: 1,
                                    maxLines: 5000,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorText: state.formSubmissionStatus
                                        is SubmissionFailed
                                            ? state.errorValidate
                                            : ""))));
                      }),
                )
              ],
            ),
          ),
        ),
        floatingActionButton:
          BlocBuilder<NotAgreeingSignBloc, NotAgreeingSignState>(
          builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.87,
            child: BkavButton(text: S.of(context).record,onPressed: (){
              context
                  .read<NotAgreeingSignBloc>()
                  .add(CLickRecord(_contentController.text));
            },),);
          }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),)
    );
  }
}
