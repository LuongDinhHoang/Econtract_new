import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/view_model/contract/send_log_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewLogPage extends StatelessWidget{
  const ViewLogPage({Key? key}) : super(key: key);
  static Route route(){
    return Utils.pageRouteBuilder(const ViewLogPage(), true);/*MaterialPageRoute(builder: (_)=> const ViewLogPage.init());*/
  }
  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show View Log Page");
    return BlocProvider(create: (context)=> SendLogBloc(repository: context.read<Repository>(),viewLog: true),
    child: BlocListener<SendLogBloc, SendLogState>(
    listener: (context, state){
    },
    child: BlocBuilder<SendLogBloc, SendLogState>(
    builder: (context, state){
      /*context.read<SendLogBloc>().add(ViewLogEvent());*/
      return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar:BkavAppBar(context, showDefaultBackButton: true,
            title: Text(S.of(context).view_log,style: StyleBkav.textStyleFW700(Colors.white, 20),),
        toolbarHeight: 44,
        hasBottom: true,
        //   leadingWidth: 34,
        // toolbarHeight: 44,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(41),
          child: Column(children: [Container(
            color: AppColor.cyan,
            height: 1,
          ),
            Container(
              color: AppColor.cyan,
              child: TabBar(
                indicatorPadding: const EdgeInsets.only(left: 16, right: 16),
                tabs: <Widget>[
                  Tab(child: Text(S.of(context).log_bug,),),
                  Tab(child: Text(S.of(context).log_activity),),
                  Tab(child: Text(S.of(context).log_other,),)
                ],
                labelColor: Colors.white,
                unselectedLabelColor: AppColor.cyan100,
                indicatorColor: Colors.white,
              ),)
          ],),
        ),
          backgroundColor: AppColor.cyan,
        ),
        body: Utils.bkavCheckOrientation(
          context, TabBarView(
          children: [
            state.isShowProgress
                ? const Center(
              child: CircularProgressIndicator(),
            ):SingleChildScrollView(scrollDirection: Axis.vertical,child: SelectableText(state.logError),),
            state.isShowProgress
                ? const Center(
              child: CircularProgressIndicator(),
            ):SingleChildScrollView(scrollDirection: Axis.vertical,child: SelectableText(state.logActivity),),
            state.isShowProgress
                ? const Center(
              child: CircularProgressIndicator(),
            ):SingleChildScrollView(scrollDirection: Axis.vertical,child: SelectableText(state.logOther),),
          ],
        ),
        ),
      ),
    );})));
  }

}