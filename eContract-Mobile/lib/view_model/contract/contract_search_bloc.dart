import 'dart:async';

import 'package:e_contract/data/entity/contract_doc_from.dart';
import 'package:e_contract/data/entity/contract_doc_to.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/entity/contract_search.dart';

///Bkav Nhunltk: search contract
class ContractSearchBloc
    extends Bloc<ContractSearchEvent, ContractSearchState> {
  final Repository repository;
  final String keySearch;
  final int categoryId;
  final String objectId;
  final BuildContext blocContext;
  final bool isFrom;

  ContractSearchBloc(
      {required this.repository,
      required this.keySearch,
      this.categoryId = 0,
      this.objectId = "",
      required this.blocContext,
      required this.isFrom})
      : super(ContractSearchState()) {
    on<ContractEasySearchEvent>(_getResultSearch);
    on<ContractSuggestSearchEvent>(_getSuggestSearch);
    on<ContractEasySearchResultEvent>(_getResultSearchSuccess);
    on<ContractEasySearchContinueEvent>(_getContractEasySearchContinueEvent);
    add(ContractSuggestSearchEvent(keySearch));
    add(ContractEasySearchEvent(keySearch, categoryId, objectId));

    // lang nghe vong doi
    // lang nghe vong doi
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(resumeCallBack: () async {
      add(ContractSuggestSearchEvent(keySearch));
      add(ContractEasySearchEvent(keySearch, categoryId, objectId));
    }));
  }

  FutureOr<void> _getSuggestSearch(ContractSuggestSearchEvent event,
      Emitter<ContractSearchState> emit) async {
    List<GroupContractSearch> suggestionList =
        await repository.getSuggestSearchFrom(event.keySearch, isFrom);
    emit(state.copyWith(suggestionListSearch: suggestionList));
  }

  FutureOr<void> _getResultSearch(
      ContractEasySearchEvent event, Emitter<ContractSearchState> emit) async {
    emit(state.copyWith( isChangeText: false));
    //Bkav Nhungltk: kich ban search dang khong co kich ban ofline nen tam thoi khong dung stream
    List<ContractDocTo> listResultSearch= await repository
        .parseResultSearChTo(event.keySearCh, event.categoryId, event.objectId,
        blocContext, isFrom ? 1 : 2, 20);
      List<ContractUIModel> listContract =
      Utils.getResultSearchTo(listResultSearch, blocContext);

    add(ContractEasySearchResultEvent(listContract, listResultSearch));
  }

  void _getResultSearchSuccess(
      ContractEasySearchResultEvent event, Emitter<ContractSearchState> emit) {
      emit(state.copyWith( listContract: event.listAgain, list: event.listContract, isChangeText: true ,lastTimeUpdate:event.listAgain.isNotEmpty? event.listAgain.last.lastUpdate : "",loadingSearch: event.listContract.length>19 ?true: false));
  }
  Future<void> _getContractEasySearchContinueEvent(
      ContractEasySearchContinueEvent event, Emitter<ContractSearchState> emit) async {
    // final prefs = await SharedPreferences.getInstance();
    // final lastUpdate = prefs.getString(SharedPreferencesKey.lastUpdate)??"";
    List<ContractDocTo> listContract = await repository
        .getListContractToContinue(event.lastUpdate, event.profileId, blocContext ,keySearch : event.keySearCh, categoryId: event.categoryId, objectId: event.objectId);
    if (listContract.isEmpty) {
      emit(state.copyWith( loadingSearch: false));
      return;
    }else{
      // await Future.delayed(const Duration(seconds: 1));
      event.listAgain.removeWhere((element) => listContract
          .map((e) => e.contractGuid)
          .toList()
          .contains(element.contractGuid));
      for (int i = 0; i < listContract.length; i++) {
        event.listAgain.add(listContract[i]);
      }
      listContract = event.listAgain;
      List<ContractUIModel> list =
      Utils.getResultSearchTo(listContract, blocContext);
      emit(state.copyWith(list: list,loadingSearch: true,listContract: event.listAgain,lastTimeUpdate:listContract.isNotEmpty? listContract.last.lastUpdate : ""));
    }
  }
}

class ContractSearchEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class ContractEasySearchEvent extends ContractSearchEvent {
  final String keySearCh;
  final int categoryId;
  final String objectId;

  ContractEasySearchEvent(this.keySearCh, this.categoryId, this.objectId);

  @override
  List<Object?> get props => [keySearCh, categoryId, objectId];
}

class ContractEasySearchResultEvent extends ContractSearchEvent {
  final List<ContractUIModel> listContract;
  final List<ContractDocTo> listAgain;

  ContractEasySearchResultEvent(this.listContract ,this.listAgain);

  @override
  List<Object?> get props => [listContract, listAgain];
}
class ContractEasySearchContinueEvent extends ContractSearchEvent {
  final String keySearCh;
  final int categoryId;
  final String objectId;
  final int profileId;
  final List<ContractDocTo> listAgain;
  final String lastUpdate;
  ContractEasySearchContinueEvent(this.keySearCh, this.categoryId, this.objectId, this.profileId, this.listAgain, this.lastUpdate);

  @override
  List<Object?> get props => [keySearCh, categoryId, objectId, profileId, listAgain, lastUpdate];
}

class ContractSuggestSearchEvent extends ContractSearchEvent {
  final String keySearch;

  ContractSuggestSearchEvent(this.keySearch);

  @override
  List<Object?> get props => [keySearch];
}

class ContractSearchState extends BlocState {
  final List<ContractUIModel> listContracts;
  final List<GroupContractSearch> suggestionList;
  final bool loadingSearch ;
  final List<ContractDocTo> listContractDocFrom;
  final String lastUpdate;
  final bool isChange;

  ContractSearchState(
      {this.listContracts = const [], this.suggestionList = const [], this.loadingSearch = false,this.listContractDocFrom = const [], this.lastUpdate = "", this.isChange = false});

  ContractSearchState copyWith(
      {List<ContractUIModel>? list,
      List<GroupContractSearch>? suggestionListSearch , bool loadingSearch = false, List<ContractDocTo>? listContract, String? lastTimeUpdate,bool? isChangeText}) {
    return ContractSearchState(
        listContracts: list?? listContracts , suggestionList: suggestionListSearch ??suggestionList , loadingSearch: loadingSearch,
      listContractDocFrom: listContract ?? listContractDocFrom,
        lastUpdate: lastTimeUpdate ?? lastUpdate,
        isChange: isChangeText ?? isChange
    );
  }

  @override
  List<Object?> get props => [listContracts, suggestionList, loadingSearch, listContractDocFrom, lastUpdate, isChange];
}
