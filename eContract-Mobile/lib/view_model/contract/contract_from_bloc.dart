import 'dart:async';

import 'package:e_contract/data/entity/contract_doc_from.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ContractFromBloc extends Bloc<ContractFromEvent, ContractFromState> {
  final Repository repository;
  late StreamSubscription<List<ContractDocFrom>> _listContractFromSubscription;
  StreamSubscription<List<TextDetail>>? _listTextDetailSubscription;
  final BuildContext blocContext;
  late StreamSubscription<bool> _checkTimeDifferentSubscription;
  late LifecycleEventHandler _lifecycleEventHandler ;

  ContractFromBloc({required this.repository, required this.blocContext})
      : super(ContractFromState(hasListContractContinue: false)) {
    on<GetListContractApiFromEvent>(_getListContractApiFrom);
    on<GetListContractLastUpdateEvent>(_getListContractLatsUpdate);
    on<ClickAContractShowDetailEvent>(_showDetailContract);
    on<PullUpListContractEvent>(_getListContractContinue);
    on<CheckTimeDifferentEvent>(_checkTimeDifferent);
    add(GetListContractApiFromEvent());
    _lifecycleEventHandler = LifecycleEventHandler(
        resumeCallBack: () async => add(GetListContractApiFromEvent()));
    // lang nghe vong doi
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);

    _checkTimeDifferentSubscription = repository.checkTime
          .listen((isDifferent) => add(CheckTimeDifferentEvent(isDifferent)));
  }

  void _checkTimeDifferent(
      CheckTimeDifferentEvent event, Emitter<ContractFromState> emit) {
    // debugPrint(" _checkTimeDifferent event  ${event.isDifferent}");
    if (event.isDifferent) {
      // Bkav HanhNTHe: neu khac thi show dialog canh bao
      DiaLogManager.displayDialog(blocContext, S.of(blocContext).title_different_time,
          S.of(blocContext).content_different_time, () {
            Get.back();
      }, () {
            Get.back();
      }, S.of(blocContext).close_dialog, "");
    }
  }

  void _getListContractApiFrom(
      GetListContractApiFromEvent event, Emitter<ContractFromState> emit) {
    emit(state.copyWith(
        isShowProgressbar: true, hasListContractContinuee: false,

    ));
    Logger.logActivity(" getListContractApiFrom ho so di");
    _listContractFromSubscription = repository
        .parseResultSearCh("", 0, "", blocContext, 1, 20)
        .listen((list) => add(GetListContractLastUpdateEvent(list)));
  }

  void _showDetailContract(
      ClickAContractShowDetailEvent event, Emitter<ContractFromState> emit) {
    _listTextDetailSubscription = repository
        .getDetailContract(event.contractUIModel.objectGuid)
        .listen((data) {
      event.contractUIModel.listTextDetail = data;
    });
  }

  ///Bkav Nhungltk: refress DSHS khi vuot xuong
  FutureOr<void> _getListContractLatsUpdate(
      GetListContractLastUpdateEvent event,
      Emitter<ContractFromState> emit) async {
    // List<ContractDocFrom> listResultSearch =
    //     await repository.parseResultSearCh("", 0, "", blocContext, 1, 20);
    if (event.listResultSearch.isEmpty) {
      //Bkav HoangLD neu list trong thi hien thi item trong
      emit(state.copyWith(
          isShowProgressbar: false, hasListContractContinuee: false));
      return;
    }
    List<ContractUIModel> listContract =
        Utils.getResultSearch(event.listResultSearch, blocContext);
    Logger.logActivity(" update list danh sach ${listContract.length} ");
    //Bkav DucLQ TODO: Tam thoi coment lai xem co con lag ko
    /*event.listResultSearch.sort((a, b) =>
        (Utils.convertTimeToMilliseconds(a.lastUpdate!))
            .compareTo(Utils.convertTimeToMilliseconds(b.lastUpdate!)));*/
    emit(state.copyWith(
        list: listContract,
        lastTimeUpdate: event
            .listResultSearch.last.lastUpdate,
        listContract: event.listResultSearch,
        isShowProgressbar: false,
      hasListContractContinuee: listContract.length>19 ?true: false,

    ));
  }

  ///Bkav Nhungltk: lay 20 ho so den tiep theo theo lastupdate khi vuot len
  FutureOr<void> _getListContractContinue(
      PullUpListContractEvent event, Emitter<ContractFromState> emit) async {
    List<ContractDocFrom> listContract = await repository
        .getListContractContinue(event.lastUpdate, 1, blocContext);
    if (listContract.isEmpty) {
      emit(state.copyWith( isShowProgressbar: false, hasListContractContinuee: false));
      return;
    }
    event.listAgain.removeWhere((element) => listContract
        .map((e) => e.contractGuid)
        .toList()
        .contains(element.contractGuid));
    for (int i = 0; i < listContract.length; i++) {
      event.listAgain.add(listContract[i]);
    }
    // debugPrint(
    //     " _getListContractContinue listContract ---------------------- ${listContract.length}  event.listAgain = ${event.listAgain.length} "
    //         " -- legnht end ${event.listAgain.last.contractGuid}");
    listContract = event.listAgain;

    // Bkav HanhNTHe comment do: sap xep dang bi sai thu tu lastupdate
    // listContract.sort((a, b) => (Utils.convertTimeToMilliseconds(a.lastUpdate!))
    //     .compareTo(Utils.convertTimeToMilliseconds(b.lastUpdate!)));
    List<ContractUIModel> list =
        Utils.getResultSearch(event.listAgain, blocContext);
    // debugPrint(
    //     " _getListContractContinue listContract ---------------------- ${listContract.length}  event.listAgain = ${list.length} "
    //         " -- legnht end ${listContract.last.contractGuid} --------- -- list end ${list.last.objectGuid}");

    emit(state.copyWith(
        list: list,
        lastTimeUpdate: listContract.last.lastUpdate,
        listContract: event.listAgain,
        isShowProgressbar: false,
        hasListContractContinuee: true));
  }

  @override
  Future<void> close() {
    repository.dispose();
    _listContractFromSubscription.cancel();
    _checkTimeDifferentSubscription.cancel();
    if (_listTextDetailSubscription != null) {
      _listTextDetailSubscription!.cancel();
    }
    //Bkav DucLQ close thi huy dang ky lang nghe even di
    WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    return super.close();
  }
}

class ContractFromEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListContractApiFromEvent extends ContractFromEvent {
  GetListContractApiFromEvent();

  @override
  List<Object> get props => [];
}

class GetListContractLastUpdateEvent extends ContractFromEvent {
  final List<ContractDocFrom> listResultSearch;

  GetListContractLastUpdateEvent(this.listResultSearch);

  @override
  List<Object> get props => [listResultSearch];
}

class ClickAContractShowDetailEvent extends ContractFromEvent {
  final ContractUIModel contractUIModel;

  ClickAContractShowDetailEvent(this.contractUIModel);

  @override
  List<Object> get props => [contractUIModel];
}

class PullUpListContractEvent extends ContractFromEvent {
  final String lastUpdate;
  final List<ContractDocFrom> listAgain;

  PullUpListContractEvent({this.lastUpdate = "", this.listAgain = const []});

  @override
  List<Object> get props => [lastUpdate, listAgain];
}

class CheckTimeDifferentEvent extends ContractFromEvent {
  final bool isDifferent;

  CheckTimeDifferentEvent(this.isDifferent);

  @override
  List<Object> get props => [isDifferent];
}

class ContractFromState extends BlocState {
  final List<ContractUIModel> listContracts;
  final String lastUpdate;
  final List<ContractDocFrom> listContractDocFrom;
  final bool hasListContractContinue;
  final bool isShowProgress;


  ContractFromState(
      {this.listContracts = const [],
      this.lastUpdate = "",
      this.listContractDocFrom = const [],
        required this.hasListContractContinue, this.isShowProgress = false});

  ContractFromState copyWith(
      {List<ContractUIModel>? list,
      String? lastTimeUpdate,
      List<ContractDocFrom>? listContract,
        required bool  hasListContractContinuee, required bool isShowProgressbar}) {
    return ContractFromState(
        listContracts: list ?? listContracts,
        lastUpdate: lastTimeUpdate ?? lastUpdate,
        listContractDocFrom: listContract ?? listContractDocFrom,
        hasListContractContinue:
        hasListContractContinuee ,
        isShowProgress: isShowProgressbar);
  }

  @override
  List<Object?> get props => [
        listContracts,
        lastUpdate,
        listContractDocFrom,
        hasListContractContinue, isShowProgress
      ];
}
