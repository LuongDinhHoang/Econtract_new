import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/contract_docs.dart';
import 'package:e_contract/data/entity/signer.dart';
import 'package:e_contract/data/local_data/contract_db.dart';

class TextDetail implements Insertable<TextDetail> {
  String objectGuid;
  String fileName;
  List<Signer> profileItemSigner;
  String? profileGuid;

  TextDetail(
      {required this.objectGuid,
      required this.fileName,
      this.profileItemSigner = const [],
      this.profileGuid});

  TextDetail.fromJson(Map<String, dynamic> json, String profileId)
      : objectGuid = json['objectGuid'],
        fileName = json["fileName"],
        profileItemSigner = ContractDocs.parseListSigner(
          jsonEncode(json['ltProfileItemSigner']),
          true,
          profileId,
          textDetailId: json['objectGuid'],
        ),
        profileGuid = profileId;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return TextDetailTableCompanion(
      objectGuid: Value(objectGuid),
      fileName: Value(fileName),
      profileGuid:
          profileGuid != null ? Value(profileGuid!) : const Value.absent(),
    ).toColumns(nullToAbsent);
  }

  void setListSigner(List<Signer> singer) {
    profileItemSigner = singer;
  }
}
