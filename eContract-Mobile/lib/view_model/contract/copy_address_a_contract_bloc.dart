import 'package:e_contract/data/entity/copy_address_model.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CopyAddressAContractBloc
    extends Bloc<CopyAddressAContractEvent, CopyAddressAContractState> {
  final Repository repository;
  final String objectGuid;
  // late LifecycleEventHandler _lifecycleEventHandler;
  CopyAddressAContractBloc({required this.repository, required this.objectGuid})
      : super(CopyAddressAContractState()) {
    on<StartCopyAddress>(_startShowCopyAddress);
    add(StartCopyAddress());
//Bkav HoangLD bloc này không cần lắng nghe vòng đời
/*    // lang nghe vong doi
    _lifecycleEventHandler = LifecycleEventHandler(
        resumeCallBack: () async => add(StartCopyAddress()));
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);*/
  }

  @override
  Future<void> close() {
    // WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    return super.close();
  }

  void _startShowCopyAddress(
      StartCopyAddress event, Emitter<CopyAddressAContractState> emit) async {
    emit(state.copyWith([], true));
    List<CopyAddressModel> list =
        await repository.showCopyAddressContract(objectGuid);
    emit(state.copyWith(list, false));
  }
}

class CopyAddressAContractEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class StartCopyAddress extends CopyAddressAContractEvent {}

class CopyAddressAContractState extends BlocEvent {
  final List<CopyAddressModel> copyAddressList;
  final bool isShowProgress;

  CopyAddressAContractState(
      {this.copyAddressList = const [], this.isShowProgress = false});

  CopyAddressAContractState copyWith(
      List<CopyAddressModel> list, bool isShowProgressbar) {
    return CopyAddressAContractState(
        copyAddressList: list, isShowProgress: isShowProgressbar);
  }

  @override
  List<Object?> get props => [copyAddressList, isShowProgress];
}
