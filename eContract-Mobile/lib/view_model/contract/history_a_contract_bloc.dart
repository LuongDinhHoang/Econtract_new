import 'dart:async';

import 'package:e_contract/data/entity/history_model.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryAContractBloc
    extends Bloc<HistoryAContractEvent, HistoryAContractState> {
  final Repository repository;
  final String objectGuid;
  late LifecycleEventHandler _lifecycleEventHandler;

  HistoryAContractBloc({required this.repository, required this.objectGuid})
      : super(HistoryAContractState()) {
    on<StartShowHistory>(_startShowHistory);
    add(StartShowHistory());
    _lifecycleEventHandler = LifecycleEventHandler(
        resumeCallBack: () async => add(StartShowHistory()));
    // lang nghe vong doi
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    return super.close();
  }

  void _startShowHistory(
      StartShowHistory event, Emitter<HistoryAContractState> emit) async {
    emit(state.copyWith([], true));
    List<HistoryModel> list = await repository.showHistoryAContract(objectGuid);
    emit(state.copyWith(list, false));
  }
}

class HistoryAContractEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class StartShowHistory extends HistoryAContractEvent {}

class HistoryAContractState extends BlocEvent {
  final List<HistoryModel> historyList;
  final bool isShowProgress;

  HistoryAContractState(
      {this.historyList = const [], this.isShowProgress = false});

  HistoryAContractState copyWith(
      List<HistoryModel> list, bool isShowProgressBar) {
    return HistoryAContractState(
        historyList: list, isShowProgress: isShowProgressBar);
  }

  @override
  List<Object?> get props => [historyList, isShowProgress];
}
