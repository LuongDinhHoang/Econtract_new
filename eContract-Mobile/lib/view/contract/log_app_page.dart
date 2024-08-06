import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/send_log_status.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/button_widget.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/utils/widgets/notification_internet_widget.dart';
import 'package:e_contract/view/contract/view_log_page.dart';
import 'package:e_contract/view_model/contract/send_log_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LogAppPage extends StatelessWidget{

  const LogAppPage({Key? key}) : super(key: key);

  static Route route(){
    return Utils.pageRouteBuilder(const LogAppPage(), true);
  }

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show SendLogAppPage");
    int count=0;
    return BlocProvider(create: (context)=> SendLogBloc(repository: context.read<Repository>(),viewLog: false),
    child: BlocListener<SendLogBloc, SendLogState>(
      listener: (context, state){
        if(state.sendLogStatus is SendLogSuccess){
          DiaLogManager.displayDialog(context, "", S.of(context).content_send_log_complete, () { }, () {
            Get.back();
            Navigator.of(context).pop();
          }, S.of(context).close_dialog, "",dialogComplete: true);
        }else if(state.sendLogStatus is SendLogFail){
           // Get.back();
        }
      },
    child: BlocBuilder<SendLogBloc, SendLogState>(
        builder: (context, state){
          return Scaffold(appBar: BkavAppBar(
            context, showDefaultBackButton: true,
            title: Text(S.of(context).title_log_app_page, style: StyleBkav.textStyleFW700(Colors.white, 20),),
          ),
            body: Utils.bkavCheckOrientation(
              context, Column(
                children: [
                  const NotificationInternet(),
                  Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                  child: Column(children: [
                    Container( padding: const EdgeInsets.only(left: 30, right: 30),
                      child: GestureDetector(child: Text(S.of(context).text_log_app,
                        style: StyleBkav.textStyleFW400(AppColor.black22, 14, overflow: TextOverflow.visible, height: 1.5),textAlign: TextAlign.center),
                        onTap: (){
                          if(count>=2){
                            Navigator.of(context).push(ViewLogPage.route());
                            count=0;
                          }else{
                            count++;
                          }
                        },),),
                  ],),
            ),
                ],
              ),
            ),
          bottomSheet: Container(width: double.infinity,
            margin: const EdgeInsets.only(right: 16,left: 16,bottom: 34),
            child: BkavButton(text: S.of(context).send_log,onPressed: (){
              //send log
              DiaLogManager.displayLoadingDialog(context);
              context.read<SendLogBloc>().add(SendLogEvent(context));
            },),));
        }),
    ));
  }

}