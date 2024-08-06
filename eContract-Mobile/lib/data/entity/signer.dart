import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';

class Signer implements Insertable<Signer> {
  String? objectGuid;
  int statusSign;
  int statusView;
  String? signerName;
  int typeSignId;
  String? signDate;
  String? unitCode2;
  String? profileGuid;
  String? textDetailGuid;

  Signer(
      {this.objectGuid,
      required this.statusSign,
      required this.signerName,
      required this.statusView,
      required this.typeSignId,
      this.signDate,
      this.unitCode2,
      this.profileGuid,
      this.textDetailGuid});

  Signer.fromJson(Map<String, dynamic> json, bool isTextDetail,
      String profileId, String? textDetailId)
      : objectGuid = json['objectGuid'],
        statusSign = json['statusSign'],
        statusView = json['statusView'],
        signerName = json['signerName'],
        typeSignId = isTextDetail ? json['typeSign'] : json['typeSignId'],
        signDate = json['signDate'],
        unitCode2 = json['unitCode2'],
        profileGuid = profileId,
        textDetailGuid = textDetailId;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return SignerTableCompanion(
      objectGuid: Value(objectGuid),
      profileGuid:
          profileGuid != null ? Value(profileGuid!) : const Value.absent(),
      textDetailGuid: Value(textDetailGuid),
      signDate: Value(signDate),
      signerName: Value(signerName),
      statusSign: Value(statusSign),
      statusView: Value(statusView),
      typeSignId: Value(typeSignId),
      unitCode2: Value(unitCode2),
    ).toColumns(nullToAbsent);
  }
}
