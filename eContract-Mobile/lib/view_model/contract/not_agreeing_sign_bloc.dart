import 'dart:async';

import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/utils/form_submission_status.dart';
import 'package:e_contract/utils/validator.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/home/home_page.dart';
import 'package:e_contract/view/home/tab_item.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Bkav TungDV Bloc quản lý giao diện từ chối ký
class NotAgreeingSignBloc extends Bloc<BlocEvent, NotAgreeingSignState> {
  final FormSubmissionStatus isValidate;
  final String errorValidate;
  final Repository repository;
  final String objectGuid;
  final BuildContext context;
  final bool isContractFrom;

  NotAgreeingSignBloc(this.isValidate, this.errorValidate, this.repository,
      this.objectGuid, this.context, this.isContractFrom)
      : super(NotAgreeingSignState(
            formSubmissionStatus: isValidate, errorValidate: errorValidate)) {
    on<CLickRecord>(_onLickRecord);
    on<ValidateChange>(_validateChange);
  }

  FutureOr<void> _onLickRecord(
      CLickRecord event, Emitter<NotAgreeingSignState> emit) async {
    String rejectContent = event.content;
    String errorContent = Validator.errorValidate(rejectContent);
    if (errorContent != "") {
      emit(state.copyWith(isValidate: SubmissionFailed(" not valid"), errorValidate: errorContent));
    } else {
      emit(state.copyWith(isValidate: FormSubmitting(), errorValidate: errorContent));
      try {
        final response =
            await repository.postRejectReason(objectGuid, rejectContent.trim());
        emit(state.copyWith(
            isValidate: SubmissionSuccess(), errorValidate: errorContent));

        if (response.isOk) {
          Navigator.of(context).pushAndRemoveUntil<void>(
              await HomePage.route(
                  tab: isContractFrom
                      ? TabItem.contractFrom
                      : TabItem.contractTo),
              (route) => false);
          //Bkav HoangLD snackbar từ chối ký thành công
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(S.of(context).not_agree_sign)));
        } else if (response.isError) {
          if (response.status == -1 || response.status == 1) {
            DiaLogManager.showDialogHTTPError(
                status: 200,
                resultStatus: response.status,
                resultObject: response.object);
          }
        } else {
          DiaLogManager.showDialogHTTPError(
              status: response.status,
              resultStatus: response.status,
              resultObject: response.object);
        }
      } catch (e) {
        //debugPrint(e.toString());
      }
    }
  }

  FutureOr<void> _validateChange(
      ValidateChange event, Emitter<NotAgreeingSignState> emit) async {
    String rejectContent = event.content;
    String errorContent = Validator.errorValidate(rejectContent);
    if (errorContent == "" || event.content == "") {
      emit(state.copyWith(
          isValidate: SubmissionSuccess(), errorValidate: errorContent));
    }else{
      emit(state.copyWith(isValidate: SubmissionFailed(" not valid"), errorValidate: errorContent));
    }
  }
}

class CLickRecord extends BlocEvent {
  final String content;

  CLickRecord(this.content);

  @override
  List<Object?> get props => [content];
}
class ValidateChange extends BlocEvent {
  final String content;

  ValidateChange(this.content);

  @override
  List<Object?> get props => [content];
}

class NotAgreeingSignState extends BlocState {
  final FormSubmissionStatus formSubmissionStatus;
  final String errorValidate;

  NotAgreeingSignState(
      {required this.formSubmissionStatus, required this.errorValidate});

  NotAgreeingSignState copyWith(
      {required FormSubmissionStatus isValidate,
      required String errorValidate}) {
    return NotAgreeingSignState(
        formSubmissionStatus: isValidate, errorValidate: errorValidate);
  }

  @override
  List<Object?> get props => [formSubmissionStatus, errorValidate];
}
