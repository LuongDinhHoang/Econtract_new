import 'package:e_contract/data/entity/text_detail.dart';

/// Bkav HanhNTHe: model chua data hien thi tren ui
class ContractUIModel {
  final String objectGuid;
  final String profileName;
  final String profileTypeName;
  final Map<String, int> listSignerStatus;
  final int status;
  final String nameCreate;
  final String fullNameCreate;
  final String profileCode;
  final String sourceName;
  final String createdDate;
  final String timeUpdate;
  final String timeRefusingSign;
  final String timeCancel;
  final String timeCompleted;
  final Map<String, dynamic> signDeadline;
  List<TextDetail> listTextDetail;
  bool isShowButtonSign;
  bool isShowHistory;
  bool isShowCopyPageSign;
  List<String> typeSign;

  ContractUIModel(
      {required this.objectGuid,
      required this.profileName,
      required this.profileTypeName,
      required this.listSignerStatus,
      required this.status,
      required this.nameCreate,
      required this.profileCode,
      required this.sourceName,
      required this.createdDate,
      required this.signDeadline,
      required this.fullNameCreate,
      required this.listTextDetail,
      required this.isShowButtonSign,
      required this.timeCompleted,
      required this.timeRefusingSign,
      required this.timeUpdate,
      required this.timeCancel,
      required this.isShowHistory,
      required this.isShowCopyPageSign,
      required this.typeSign});
}
