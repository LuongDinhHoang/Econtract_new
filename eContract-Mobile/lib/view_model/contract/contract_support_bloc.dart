import 'package:e_contract/data/entity/support_info.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportAContractBloc
    extends Bloc<SupportAContractEvent, SupportAContractState> {
  final Repository repository;

  SupportAContractBloc({required this.repository})
      : super(SupportAContractState(listUrlSupport: const SupportInfo([]), callApiError: false)) {
    on<StartSupport>(_startShowSupport);
    add(StartSupport());
  }

  void _startShowSupport(
      StartSupport event, Emitter<SupportAContractState> emit) async {
    //final pref = await SharedPreferences.getInstance();
    List<String> cacheList = (await SharedPrefs.instance()).getStringList(SharedPreferencesKey.listSupport) ?? [];
    SupportInfo cacheListSupport = SupportInfo(cacheList);
    emit(state.copyWith(cacheListSupport, false));
    SupportInfo list = await repository.getListSupport();
    bool callApiError = (await SharedPrefs.instance()).getBool(SharedPreferencesKey.callApiError) ?? false;
    if(callApiError) {
      emit(state.copyWith(list, callApiError));
    }
  }
}

class SupportAContractEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class StartSupport extends SupportAContractEvent {}

class SupportAContractState extends BlocEvent {
  final SupportInfo listUrlSupport;
  final bool callApiError;

  SupportAContractState({required this.callApiError,required this.listUrlSupport});

  SupportAContractState copyWith(SupportInfo list, bool callApiError) {
    return SupportAContractState(listUrlSupport: list, callApiError: callApiError);
  }

  @override
  List<Object?> get props => [listUrlSupport, callApiError];
}
