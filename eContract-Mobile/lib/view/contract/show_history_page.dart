import 'package:e_contract/data/repository.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/view_model/contract/history_a_contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../generated/l10n.dart';
import '../../utils/widgets/notification_internet_widget.dart';

///Bkav Nhungltk
class HistoryContract extends StatelessWidget {
  final String objectGuid;

  const HistoryContract.init({Key? key, required this.objectGuid})
      : super(key: key);

  static Route route(String id) {
    return Utils.pageRouteBuilder(HistoryContract.init(objectGuid: id), true);
  }

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show History Page");
    return Scaffold(
        backgroundColor: AppColor.gray50,
        appBar: BkavAppBar(
          context,
          title: Text(
            S.of(context).title_history,
            style: StyleBkav.textStyleGray20(),
          ),
          showDefaultBackButton: true,
        ),
        body: Utils.bkavCheckOrientation(context,BlocProvider(
          create: (context) => HistoryAContractBloc(
              repository: context.read<Repository>(), objectGuid: objectGuid),
          child: Container(
            color: AppColor.gray50,
            child: BlocBuilder<HistoryAContractBloc, HistoryAContractState>(
              builder: (context, state) {
                return state.isShowProgress
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemBuilder: (context, position) {
                      return Column(
                        children: [
                          const NotificationInternet(),
                          Container(
                            color: Colors.white,
                            padding:
                            const EdgeInsets.only(top: 18, bottom: 18),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                        const EdgeInsets.only(left: 16),
                                        child: Text(
                                          state.historyList[position]
                                              .createDate,
                                          style: StyleBkav.textStyleFW700(
                                              AppColor.black22, 14, overflow: TextOverflow.visible),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                        const EdgeInsets.only(right: 16),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          state.historyList[position].account,
                                          style: StyleBkav.textStyleFW700(
                                              AppColor.black22, 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                  const EdgeInsets.only(left: 16, top: 6),
                                  child: Html(
                                      data: state
                                          .historyList[position].logContent,
                                      style: {
                                        "body": Style(
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
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: AppColor.gray50,
                          )
                        ],
                      );
                    },
                    itemCount: state.historyList.length);
              },
            ),
          ),
        )));
  }
}
