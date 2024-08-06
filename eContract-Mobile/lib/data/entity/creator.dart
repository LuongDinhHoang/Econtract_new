import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';

class Creator extends Insertable<Creator> {
  String? contractGuid;
  int id;
  String? userName;
  String? fullName;

  Creator(
      {required this.id,
      required this.userName,
      required this.fullName,
      this.contractGuid});

  Creator.fromJson(Map<String, dynamic> json, String contractId)
      : id = json['id'],
        userName = json['userName'],
        fullName = json['fullName'],
        contractGuid = contractId;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return CreatorTableCompanion(
            userName: Value(userName),
            fullName: Value(fullName),
            id: Value(id),
            contractGuid: Value(contractGuid))
        .toColumns(nullToAbsent);
  }
}
