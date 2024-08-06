import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/utils/widgets/notification_internet_widget.dart';
import 'package:e_contract/view/contract/detail_a_contract_page.dart';
import 'package:e_contract/view/contract/list_contracts_page.dart';
import 'package:e_contract/view_model/contract/contract_to_bloc.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../search_contract_page.dart';

/// Bkav HanhNTHe: class quan ly cac du lieu lien quan den "Ho So Di" -> show ui phu hop
class ContractToManager {
  static Widget showListContractsTo(
      Function(ContractUIModel model, int selection) callback,
      {bool isSignSuccess = false,
      ContractUIModel? selectedValue,
      int? position,
      required Function(bool) signSuccessCallBack}) {
    bool isLargeScreen = false;
    return BlocProvider(
        create: (context) => ContractToBloc(
            repository: context.read<Repository>(), blocContext: context),
        child: BlocBuilder<ContractToBloc, ContractToState>(
            builder: (context, state) {
          selectedValue ??= ContractUIModel(
              objectGuid: "",
              profileName: "",
              profileTypeName: "",
              listSignerStatus: {},
              status: 6,
              nameCreate: "",
              profileCode: "",
              sourceName: "",
              createdDate: "",
              fullNameCreate: "",
              listTextDetail: [],
              isShowButtonSign: false,
              timeRefusingSign: '',
              timeUpdate: '',
              timeCancel: '',
              signDeadline: {
                ConstFDTFString.timeResult: "",
                ConstFDTFString.isExpired: false,
                ConstFDTFString.isWarning: null
              },
              timeCompleted: '',
              isShowHistory: false,
              isShowCopyPageSign: false,
              typeSign: []);
          isLargeScreen = Utils.checkHorizontal(context);
          if (isSignSuccess == true) {
            context.read<ContractToBloc>().add(GetListContractApiToEvent());
            isSignSuccess = false;
          }
          return Scaffold(
            appBar: isLargeScreen
                ? BkavAppBar(
                    NavigationService.navigatorKey.currentContext!,
                    title: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, top: 11, bottom: 13),
                      child: Text(
                          S
                              .of(NavigationService
                                  .navigatorKey.currentContext!)
                              .contract_to,
                          style: StyleBkav.textStyleGray20()),
                    ),
                    actions: [
                      BlocBuilder<ContractToBloc, ContractToState>(
                          builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).push(
                                ContractSearch.route(state.listContracts, false,
                                    () {
                              context
                                  .read<ContractToBloc>()
                                  .add(GetListContractApiToEvent());
                            }));
                          },
                          icon: SvgPicture.asset(IconAsset.icSearch),
                          enableFeedback: false,
                        );
                      })
                    ],
                    showDefaultBackButton: false,
                  )
                : null,
            backgroundColor: AppColor.gray50,
            body: Column(
              children: [
                isLargeScreen ? const NotificationInternet() : Container(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListContracts.init(
                          isFrom: false,
                          list: state.listContracts,
                          textTitle: S.of(context).contract_to,
                          isSearch: false,
                          refreshListContract: () {
                            context
                                .read<ContractToBloc>()
                                .add(GetListContractApiToEvent());
                          },
                          clickItem: (model, select) async {
                            selectedValue = model;
                            callback(model, select);
                            if (!isLargeScreen) {
                              // neu kh phai man to thi call sang giao dien chi tiet
                              final result =
                                 await Navigator.of(context, rootNavigator: true)
                                      .push(DetailAContract.route(
                                          model, false, context));
                              if (result != null && result[0] == false) {
                                signSuccessCallBack(true);
                              } else {
                                signSuccessCallBack(false);
                              }
                            }
                          },
                          updateListContract: () {
                            //add event update list contract
                            context.read<ContractToBloc>().add(
                                PullUpListContractEvent(
                                    listAgain: state.listContractDocTo,
                                    lastUpdate: state.lastUpdate));
                          },
                          hasListContractContinue:
                              state.hasListContractContinue,
                          isShowProgress: state.isShowProgress,
                          isHorizontal: isLargeScreen,
                          positionClick: position,
                        ),
                      ),
                      isLargeScreen
                          ? selectedValue?.objectGuid == ""
                              ? Container()
                              : Expanded(
                                  child: DetailAContract(
                                  contractUIModel: selectedValue!,
                                  isContractFrom: true,
                                  isHorizontal: isLargeScreen,
                                ))
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
