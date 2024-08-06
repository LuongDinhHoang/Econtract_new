import 'package:e_contract/utils/utils.dart';

class HistoryModel {
  int id;
  String createDate;
  String ip;
  int userId;
  String account;
  String objectGuid;
  String logContent;

  HistoryModel(
      {required this.id,
      required this.createDate,
      required this.ip,
      required this.userId,
      required this.account,
      required this.objectGuid,
      required this.logContent});

  HistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createDate = Utils.convertTimeFDTF(
            time: json['createdDate'], type: ConstFDTFString.m1bM2d),
        ip = json['ip'],
        userId = json['userId'],
        account = json['account'] == "Không xác định" ? "" : json['account'],
        objectGuid = json['objectGuid'],
        logContent = json['logContent'];
}
