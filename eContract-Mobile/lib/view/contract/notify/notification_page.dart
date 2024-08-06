import 'package:e_contract/data/repository.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/view/contract/detail_a_contract_page.dart';
import 'package:e_contract/view_model/contract/notification_bloc.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../utils/widgets/notification_internet_widget.dart';

///Bkav TungDV Giao dien notification
class NotificationContract extends StatefulWidget {
  const NotificationContract.init({Key? key, required this.onNumberChange})
      : super(key: key);

  // Thong bao so notification chua doc cho bottom navigation hien thi
  final void Function(int) onNumberChange;

  @override
  State<NotificationContract> createState() => _NotificationContractState();
}

class _NotificationContractState extends State<NotificationContract> {
  @override
  void dispose() {
    // dispose your stuff here
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // làm trong suốt statusbar
      statusBarIconBrightness: Brightness.dark, // icon statusbar màu trắng
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = 0;
    return BlocProvider(
      create: (context) => NotificationBloc(
          context.read<Repository>(), currentPage, widget.onNumberChange),
      child: Scaffold(
        backgroundColor: AppColor.gray50,
        appBar: BkavAppBar(
          context,
          backgroundColor: AppColor.cyan,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(right: 16, top: 11, bottom: 13),
            child: Text(S.of(context).title_notification,
                style: StyleBkav.textStyleGray20()),
          ),
          showDefaultBackButton: false,
        ),
        body: Utils.bkavCheckOrientation(
          context,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NotificationInternet(),
              BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    Logger.logActivity("NotificationPage list notification length (${state.listNotification.length})");
                return state.listNotification.isNotEmpty
                    ? Expanded(
                        child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification notification) {
                              if (notification.metrics.atEdge) {
                                if (notification.metrics.pixels == 0) {
                                } else {
                                  // if (state.currentPage < 5) {
                                    context.read<NotificationBloc>().add(
                                        GetListNotification(
                                            state.currentPage + 1,
                                            state.listNotification));
                                  // }
                                }
                              }
                              return true;
                            },
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context.read<NotificationBloc>().add(GetListNotification(1, const []));
                              },
                              edgeOffset: 5,
                              child: ListView.builder(
                                  itemCount: state.listNotification.length+1,
                                  itemBuilder: (context, index) => index ==
                                          state.listNotification.length
                                      ? Visibility(
                                          visible: state.hasListNotificationContinue,
                                          child: const Center(
                                              child:
                                                  RefreshProgressIndicator()),
                                        )
                                      : Container(
                                          child: itemNotification(
                                              context, index))),
                            )))
                    : Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(IconAsset.icEmpty),
                              const SizedBox(
                                height: 27.56,
                              ),
                              Text(
                                S.of(context).empty,
                                style: StyleBkav.textStyleFW400(
                                    AppColor.black22, 18),
                              )
                            ],
                          ),
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget itemNotification(BuildContext context, int index) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // fake du lieu voi [profileGuid] de cap nha sau
          ContractUIModel model = ContractUIModel(
              objectGuid: state.listNotification[index].profileGuid,
              profileName: "",
              profileTypeName: "HỒ SƠ MẪU TÀI CHÍNH",
              listSignerStatus: {},
              status: 2,
              nameCreate: "Nhungltk",
              profileCode: "2566HSMTC2022",
              sourceName: "BES",
              createdDate: "0001-01-01T00:00:00",
              fullNameCreate: "Le Thi Nhung",
              listTextDetail: [],
              isShowButtonSign: false,
              timeRefusingSign: '',
              timeUpdate: '',
              timeCancel: '',
              signDeadline: {
                ConstFDTFString.timeResult: S.of(context).unlimited,
                ConstFDTFString.isExpired: false,
                ConstFDTFString.isWarning: null
              },
              timeCompleted: '',
              isShowHistory: false,
              isShowCopyPageSign: false,
              typeSign: []);

          // call sang giao dien chi tiet
          Navigator.of(context).push(
              DetailAContract.route(model, false, context, isNotifyFrom: true));
          if (state.listNotification[index].status !=
              ContractConstants.notificationSeen) {
            state.listNotification[index].status =
                ContractConstants.notificationSeen;
            context.read<NotificationBloc>().add(NotificationStatusChange(
                state.listNotification, state.listNotification[index]));
          }
        },
        child: Column(
          children: [
            // Utils.horizontalLine(),
            Container(
                color: state.listNotification[index].status == 4
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFFD3F7FF),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 16, top: 12, right: 14, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 4),
                      child: state.listNotification[index].notifyTypeID ==
                              ContractConstants.signSuccess
                          ? SvgPicture.asset(IconAsset.icSignSuccess, allowDrawingOutsideViewBox: true)
                          : SvgPicture.asset(IconAsset.icSignAwait, allowDrawingOutsideViewBox: true),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                            data: state.listNotification[index].body,
                            style: {
                              '#': Style(
                                fontSize: FontSize(14),
                                maxLines: 2,
                                fontFamily: "Roboto",
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              Utils.convertTimeInNotification(
                                  state.listNotification[index].createDate),
                              style: StyleBkav.textGrey(),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                )),
            // index + 1 ==
            //         state
            //             .listNotification
            //             .length
            //     ?
            // : Container(),
          ],
        ),
      );
    });
  }
}
