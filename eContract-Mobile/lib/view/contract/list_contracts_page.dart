import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/item_contract_in_list.dart';
import 'package:e_contract/view/contract/search_contract_page.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../utils/widgets/notification_internet_widget.dart';

/// Bkav HanhNTHe: Hien thi chung danh sach ho so
class ListContracts extends StatelessWidget {
  final List<ContractUIModel> list;
  final String textTitle;
  final bool isSearch;
  final bool isFrom; // xac dinh la den hay di
  final VoidCallback refreshListContract;
  final VoidCallback updateListContract;
  final bool hasListContractContinue;
  final bool isShowProgress;
  final bool isHorizontal;
  final int? positionClick;

  final Function(ContractUIModel,int) clickItem;

  ListContracts.init(
      {Key? key,
      required this.list,
      required this.textTitle,
      required this.isFrom,
      required this.isSearch,
      required this.refreshListContract,
      required this.clickItem,
      required this.updateListContract,
      required this.hasListContractContinue, required this.isShowProgress,required this.isHorizontal, this.positionClick })
      : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show list contract from(true)/to(false): $isFrom");
    Logger.loggerDebug("Nhungltk ListContracts");
    return Scaffold(
      appBar: isHorizontal?null:BkavAppBar(
        context,
        title: Padding(
          padding: const EdgeInsets.only(right: 16, top: 11, bottom: 13),
          child: Text(
              textTitle,
              style: StyleBkav.textStyleGray20()),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .push(ContractSearch.route(list, isFrom, refreshListContract));
            },
            icon: SvgPicture.asset(IconAsset.icSearch),
            enableFeedback: false,
          ),
        ], showDefaultBackButton: false,

      ),
      backgroundColor: AppColor.gray50,
      body:isShowProgress
          ? const Center(
                child: CircularProgressIndicator(),
              )
            : Utils.bkavCheckOrientation(context,SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: AppColor.gray50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHorizontal?Container():const NotificationInternet(),
              list.isNotEmpty
                  ? Expanded(
                flex: 1,
                child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.metrics.atEdge) {
                        if (notification.metrics.pixels == 0) {
                        } else {
                          updateListContract();
                        }
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        refreshListContract();
                      },
                      edgeOffset: 0,
                      child: ListView.builder(
                          itemCount: list.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            bool checkClick = false;
                            if(index == positionClick){
                              checkClick = true;
                            }
                            return index == list.length
                                ? Visibility(visible: hasListContractContinue,child: const Center(child: RefreshProgressIndicator()),)
                                : Container( margin: index==0? const EdgeInsets.only(top: 8): index== list.length-1?
                            const EdgeInsets.only(bottom: 8): null,
                              child: ContractItem(
                              onTap: () async{
                                await clickItem(list[index],index);
                                // Navigator.of(context)
                                //     .push(DetailAContract.route(list[index], isFrom));
                              },
                              contractUIModel: list[index],
                              isFrom: isFrom,
                              refreshListContract: refreshListContract,
                                positionClick: checkClick,
                            ),);
                          }),
                    )),
              )
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
                        style:
                        StyleBkav.textStyleFW400(AppColor.black22, 18),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),);
  }
}
