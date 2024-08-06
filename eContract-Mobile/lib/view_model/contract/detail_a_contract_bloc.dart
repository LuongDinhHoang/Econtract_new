import 'dart:async';

import 'package:e_contract/data/entity/contract_doc_from.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailAContractBloc
    extends Bloc<DetailAContractEvent, DetailAContractState> {
  final Repository repository;
  StreamSubscription<List<TextDetail>>? _listTextDetailSubscription;
  ContractUIModel contractUIModel;
  final bool isNotification;
  final BuildContext blocContext;
  late WidgetsBindingObserver _observer;

  DetailAContractBloc(this.blocContext,
      {required this.repository,
      required this.contractUIModel,
      required this.isNotification})
      : super(DetailAContractState()) {
    on<ClickAContractShowDetailEvent>(_showDetailContract);
    on<GetDetailAContractApp>(_getDetailAContractApp);
    on<ShowResult>(_showResult);
    isNotification
        ? add(GetDetailAContractApp(contractUIModel.objectGuid))
        : add(ShowResult(contractUIModel));

    // lang nghe vong doi
    _observer = LifecycleEventHandler(
        resumeCallBack: () async{
            add(ClickAContractShowDetailEvent(contractUIModel));});
    WidgetsBinding.instance.addObserver(_observer);
  }

  void _showDetailContract(
      ClickAContractShowDetailEvent event, Emitter<DetailAContractState> emit) {
    //Bkav HoangLD fixbug BECM-336
    if(!isNotification){
      _listTextDetailSubscription = repository
          .getDetailContract(event.contractUIModel.objectGuid)
          .listen((data) {
        event.contractUIModel.listTextDetail = data;
        add(ShowResult(event.contractUIModel));
      });
    }
  }

  void _showResult(ShowResult event, Emitter<DetailAContractState> emit) {
    emit(state.copyWith(event.contractUIModel));
  }

  void _getDetailAContractApp(
      GetDetailAContractApp event, Emitter<DetailAContractState> emit) async {
    emit(state.copyWith(null, isLoad: true));
    ContractDocFrom element =
        await repository.getDetailContractApp(event.profileGuid);
    ContractUIModel contractUIModel = Utils.convertToContractUIModel(element);
    emit(state.copyWith(contractUIModel, isLoad: false));
  }

  @override
  Future<void> close() {
    repository.dispose();
    if (_listTextDetailSubscription != null) {
      _listTextDetailSubscription!.cancel();
    }
    WidgetsBinding.instance.removeObserver(_observer);
    return super.close();
  }
}

class DetailAContractEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class ClickAContractShowDetailEvent extends DetailAContractEvent {
  final ContractUIModel contractUIModel;

  ClickAContractShowDetailEvent(this.contractUIModel);

  @override
  List<Object> get props => [contractUIModel];
}

class GetDetailAContractApp extends DetailAContractEvent {
  final String profileGuid;

  GetDetailAContractApp(this.profileGuid);

  @override
  List<Object> get props => [profileGuid];
}

class ShowResult extends DetailAContractEvent {
  final ContractUIModel contractUIModel;

  ShowResult(this.contractUIModel);

  @override
  List<Object> get props => [contractUIModel];
}

class DetailAContractState extends BlocState {
  final ContractUIModel? contractUIModel;
  final bool isLoading;

  DetailAContractState({this.contractUIModel, this.isLoading = false});

  DetailAContractState copyWith(ContractUIModel? contractUi, {bool? isLoad}) {
    return DetailAContractState(
        contractUIModel: contractUi, isLoading: isLoad ?? isLoading);
  }

  @override
  List<Object?> get props => [contractUIModel, isLoading];
}
