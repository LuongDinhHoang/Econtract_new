import 'dart:async';

import 'package:e_contract/data/entity/notification_entity.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_event.dart';

///Bkav TungDV Bloc quan ly Giao dien notification
class NotificationBloc extends Bloc<BlocEvent, NotificationState> {
  final Repository repository;
  int currentPage;
  late StreamSubscription<List<NotificationEntity>>
      _notificationStreamSubscription;
  void Function(int) onNumberChange;

  NotificationBloc(this.repository, this.currentPage, this.onNumberChange)
      : super(NotificationState(
            listNotification: const [],
            currentPage: currentPage,
            hasListNotificationContinue: false)) {
    on<GetListNotification>(_getListNotification);
    on<GetListNotificationSuccess>(_onSuccess);
    on<RefreshListNotification>(_refreshListNotification);
    on<NotificationStatusChange>(_onChangeStatus);

    add(GetListNotification(1, const []));
  }

  FutureOr<void> _getListNotification(
      GetListNotification event, Emitter<NotificationState> emit) async {
    int bagNumber= await repository.getBagNumberApp();
    if (currentPage == event.currentPage) {
      return;
    }
    currentPage = event.currentPage;
    List<NotificationEntity> listNotification = event.listNotification;
    // debugPrint(" getlist current page ${event.currentPage}");
    _notificationStreamSubscription = repository
        .getListNotification(event.currentPage)
        .listen((listNotificationNew) async {
      if (listNotificationNew.isNotEmpty) {
        // debugPrint(
        //     " listNotificationNew ${listNotificationNew.length} listNotification "
        //         "${listNotification.length}  + ${listNotificationNew.first.notifyId}  ${listNotificationNew.first.totalUnread} ");
        for (NotificationEntity elementNew in listNotificationNew) {
          bool isHaveOldList = false;
          for (int i = 0; i < listNotification.length; i++) {
            if (listNotification[i].notifyId == elementNew.notifyId) {
              listNotification[i] = elementNew;
              isHaveOldList = true;
              // debugPrint(
              //     " listNotificationNew ${listNotificationNew.length} index listNotification  $i");
            }
          }
          if (!isHaveOldList) {
            listNotification = List.from(listNotification)..add(elementNew);
            // debugPrint(" listNotificationNew adddddd ==========  ${listNotification.length}");
          }
        }
      }
      if (listNotification.isEmpty) {
        return;
      }
      add(GetListNotificationSuccess(currentPage, listNotification,
          listNotificationNew.isNotEmpty && currentPage < 5 && listNotification.length > 19?   true : false,bagNumber));
      currentPage = 0;
    });
  }

  FutureOr<void> _refreshListNotification(
      RefreshListNotification event, Emitter<NotificationState> emit) async {
    int bagNumber= await repository.getBagNumberApp();
    _notificationStreamSubscription =
        repository.getListNotification(1).listen((listNotification) {
      if (listNotification.isEmpty) {
        return;
      }
      add(GetListNotificationSuccess(1, listNotification, listNotification.length > 19?   true : false,bagNumber));
      currentPage = 0;
    });
  }

  void _onSuccess(
      GetListNotificationSuccess event, Emitter<NotificationState> emit) async {
    // debugPrint(" listNotificationNew _onSuccess ==========  ${event.listNotification.length}");

    // debugPrint("GetListNotificationSuccess  _onSuccess item _onSuccess state.notificationCountNotSeen =  ${state.notificationCountNotSeen} +"
    //     " count ${event.listNotification.last.totalUnread}  notify id ${event.listNotification.last.notifyId}");
    // thong bao so notification, neu status != 4 => chua xem
    onNumberChange(event.bagNumber);

    emit(state.copyWith(
        listNotification: event.listNotification,
        currentPage: event.currentPage,
    count: event.listNotification.last.totalUnread,
        hasListNotificationContinue: event.isNewListNotificationEmpty));
  }

  void _onChangeStatus(
      NotificationStatusChange event, Emitter<NotificationState> emit) async {
    //onNumberChange(state.notificationCountNotSeen - 1);
    // debugPrint(" Click item _onChangeStatus ${state.notificationCountNotSeen} ");
    await repository.updateNotificationStatusViewed(
        notificationEntity: event.notificationEntity,
        total: state.notificationCountNotSeen - 1);
    emit(state.copyWith(
        listNotification: event.listNotification,
        currentPage: currentPage,
        count: state.notificationCountNotSeen - 1,
        hasListNotificationContinue: false));
  }

  @override
  Future<void> close() async {
    repository.dispose();
    _notificationStreamSubscription.cancel();
    return super.close();
  }
}

class GetListNotification extends BlocEvent {
  final int currentPage;
  final List<NotificationEntity> listNotification;

  GetListNotification(this.currentPage, this.listNotification);

  @override
  List<Object?> get props => [currentPage, listNotification];
}

class GetListNotificationSuccess extends BlocEvent {
  final int currentPage;
  final List<NotificationEntity> listNotification;
  final bool isNewListNotificationEmpty;
  final int bagNumber;

  GetListNotificationSuccess(
      this.currentPage, this.listNotification, this.isNewListNotificationEmpty, this.bagNumber);

  @override
  List<Object?> get props =>
      [currentPage, listNotification, isNewListNotificationEmpty,bagNumber];
}

class RefreshListNotification extends BlocEvent {
  final List<NotificationEntity> listNotification;

  RefreshListNotification(this.listNotification);

  @override
  List<Object?> get props => [listNotification];
}

class NotificationStatusChange extends BlocEvent {
  final List<NotificationEntity> listNotification;
  final NotificationEntity notificationEntity;

  NotificationStatusChange(this.listNotification, this.notificationEntity);

  @override
  List<Object?> get props => [listNotification, notificationEntity];
}

class NotificationState extends BlocState {
  final List<NotificationEntity> listNotification;
  final int currentPage;
  final int notificationCountNotSeen; // so luong thong bao chua xem
  final bool hasListNotificationContinue;
  // final bool isLoad;

  NotificationState(
      {required this.hasListNotificationContinue,
      required this.listNotification,
      required this.currentPage,
      this.notificationCountNotSeen = 0});

  NotificationState copyWith(
      {required List<NotificationEntity> listNotification,
      required int currentPage,
      required int count,
      required bool hasListNotificationContinue}) {
    return NotificationState(
        listNotification: listNotification,
        currentPage: currentPage,
        notificationCountNotSeen: count,
        hasListNotificationContinue: hasListNotificationContinue);
  }

  @override
  List<Object?> get props =>
      [listNotification, currentPage, notificationCountNotSeen];
}
