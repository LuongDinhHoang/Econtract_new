import 'dart:async';

import 'package:e_contract/data/entity/contract_doc_to.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContractToBloc extends Bloc<ContractToEvent, ContractToState> {
  final Repository repository;
  late StreamSubscription<List<ContractDocTo>> _listContractToSubscription;
  StreamSubscription<List<TextDetail>>? _listTextDetailSubscription;
  final BuildContext blocContext;
  late LifecycleEventHandler _lifecycleEventHandler ;

  ContractToBloc({required this.repository, required this.blocContext})
      : super(ContractToState(hasListContractContinue: false)) {
    on<GetListContractApiToEvent>(_getListContractApiTo);
    on<ClickAContractShowDetailEvent>(_showDetailContract);
    on<GetListContractLastUpdateEvent>(_getListContractLatsUpdate);
    on<PullUpListContractEvent>(_getListContractContinue);
    add(GetListContractApiToEvent());
    _lifecycleEventHandler = LifecycleEventHandler(
        resumeCallBack: () async => add(GetListContractApiToEvent()));
    // lang nghe vong doi
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);
  }

  void _getListContractApiTo(
      GetListContractApiToEvent event, Emitter<ContractToState> emit) {
    emit(state.copyWith(
        isShowProgressbar: true, hasListContractContinuee: false));
    Logger.logActivity(" getListContractApiFrom ho so den");
    _listContractToSubscription = repository
        .getListContractsTo(20)
        .listen((list) => add(GetListContractLastUpdateEvent(list)));
  }

  @override
  Future<void> close() {
    repository.dispose();
    _listContractToSubscription.cancel();
    if (_listTextDetailSubscription != null) {
      _listTextDetailSubscription!.cancel();
    }
    WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    return super.close();
  }

  void _showDetailContract(
      ClickAContractShowDetailEvent event, Emitter<ContractToState> emit) {
    _listTextDetailSubscription = repository
        .getDetailContract(event.contractUIModel.objectGuid)
        .listen((data) {
      event.contractUIModel.listTextDetail = data;
    });
  }

  ///Bkav Nhungltk: refress DSHS khi vuot xuong
  FutureOr<void> _getListContractLatsUpdate(
      GetListContractLastUpdateEvent event,
      Emitter<ContractToState> emit) async {
    // List<ContractDocTo> listRefresh =
    //     await repository.parseResultSearChTo("", 0, "", blocContext, 2, 20);
    if (event.listResultSearch.isEmpty) {
      //Bkav HoangLD neu list trong thi hien thi item trong
      emit(state.copyWith(
          isShowProgressbar: false, hasListContractContinuee: false));
      return;
    }
    List<ContractUIModel> listContract =
        Utils.getResultSearchTo(event.listResultSearch, blocContext);
    Logger.logActivity(" update list danh sach ${listContract.length}");
    //Bkav DucLQ TODO: update list danh sach
   /* listRefresh.sort((a, b) => (Utils.convertTimeToMilliseconds(a.lastUpdate!))
        .compareTo(Utils.convertTimeToMilliseconds(b.lastUpdate!)));*/
    emit(state.copyWith(
        list: listContract,
        lastTimeUpdate: event.listResultSearch.last.lastUpdate,
        listContract: event.listResultSearch,
        isShowProgressbar: false,
        hasListContractContinuee: listContract.length > 19 ? true : false));
  }

  ///Bkav Nhungltk: lay 20 ho so den tiep theo theo lastupdate khi vuot len
  FutureOr<void> _getListContractContinue(
      PullUpListContractEvent event, Emitter<ContractToState> emit) async {
    List<ContractDocTo> listContract = await repository
        .getListContractToContinue(event.lastUpdate, 2, blocContext);
    // debugPrint(
    //     " _getListContractContinue listContract ---------------------- ${listContract.length} "
    //         " -- legnht end ${listContract.last.contractGuid} ${event.lastUpdate}");
    if(listContract.isEmpty){
      emit(state.copyWith(hasListContractContinuee: false, isShowProgressbar: false));
      return;
    }
    event.listAgain.removeWhere((element) => listContract
        .map((e) => e.contractGuid)
        .toList()
        .contains(element.contractGuid));
    for (int i = 0; i < listContract.length; i++) {
      event.listAgain.add(listContract[i]);
    }
    listContract = event.listAgain;
    // HanhNTHe: comment do sap xep sai
    // listContract.sort((a, b) => (Utils.convertTimeToMilliseconds(a.lastUpdate!))
    //     .compareTo(Utils.convertTimeToMilliseconds(b.lastUpdate!)));
    List<ContractUIModel> list =
        Utils.getResultSearchTo(event.listAgain, blocContext);

    // debugPrint(
    //     " _getListContractContinue listContract ---------------------- ${listContract.length}  event.listAgain = ${list.length} "
    //         " -- legnht end ${listContract.last.contractGuid} --------- -- list end ${list.last.objectGuid}");

    emit(state.copyWith(
        list: list,
        lastTimeUpdate: listContract.last.lastUpdate,
        listContract: event.listAgain,
        hasListContractContinuee: true,
        isShowProgressbar: false));
  }
}

class ContractToEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListContractApiToEvent extends ContractToEvent {
  GetListContractApiToEvent();

  @override
  List<Object> get props => [];
}

class GetListContractLastUpdateEvent extends ContractToEvent {
  final List<ContractDocTo> listResultSearch;

  GetListContractLastUpdateEvent(this.listResultSearch);

  @override
  List<Object> get props => [listResultSearch];
}

class PullUpListContractEvent extends ContractToEvent {
  final String lastUpdate;
  final List<ContractDocTo> listAgain;

  PullUpListContractEvent({this.lastUpdate = "", this.listAgain = const []});

  @override
  List<Object> get props => [lastUpdate, listAgain];
}

class ClickAContractShowDetailEvent extends ContractToEvent {
  final ContractUIModel contractUIModel;

  ClickAContractShowDetailEvent(this.contractUIModel);

  @override
  List<Object> get props => [contractUIModel];
}

class ContractToState extends BlocState {
  final List<ContractUIModel> listContracts;
  final String lastUpdate;
  final List<ContractDocTo> listContractDocTo;
  final bool hasListContractContinue;
  final bool isShowProgress;

  ContractToState(
      {this.listContracts = const [],
      this.lastUpdate = "",
      this.listContractDocTo = const [],
      required this.hasListContractContinue, this.isShowProgress = false});

  ContractToState copyWith(
      {List<ContractUIModel>? list,
      String? lastTimeUpdate,
      List<ContractDocTo>? listContract,
      required bool  hasListContractContinuee, required bool isShowProgressbar}) {
    return ContractToState(
        listContracts: list ?? listContracts,
        lastUpdate: lastTimeUpdate ?? lastUpdate,
        listContractDocTo: listContract ?? listContractDocTo,
        hasListContractContinue: hasListContractContinuee
        , isShowProgress: isShowProgressbar);
  }

  @override
  List<Object?> get props => [listContracts, lastUpdate, listContractDocTo, hasListContractContinue, isShowProgress];
}
