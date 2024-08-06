import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';

class ButtonShow implements Insertable<ButtonShow> {
  String? contractGuid;

  ///Bkav Nhungltk: trang thai cac button
  final bool copyPageSign;
  final bool edit;
  final bool restore;
  final bool sign;
  final bool download;
  final bool viewHistory;
  final bool cancelTranferSign;

  ButtonShow(
      {required this.copyPageSign,
      required this.edit,
      required this.restore,
      required this.sign,
      required this.download,
      required this.viewHistory,
      required this.cancelTranferSign,
      this.contractGuid});

  ButtonShow.fromJson(Map<String, dynamic> json, String contractId)
      : copyPageSign = json["copyPageSign"],
        edit = json["edit"],
        restore = json["restore"],
        sign = json["sign"],
        download = json["download"],
        viewHistory = json["viewHistory"],
        cancelTranferSign = json["cancelTranferSign"],
        contractGuid = contractId;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ButtonShowTableCompanion(
            cancelTranferSign: Value(cancelTranferSign),
            copyPageSign: Value(copyPageSign),
            download: Value(download),
            edit: Value(edit),
            restore: Value(restore),
            sign: Value(sign),
            viewHistory: Value(viewHistory),
            contractGuid: Value(contractGuid))
        .toColumns(nullToAbsent);
  }
}