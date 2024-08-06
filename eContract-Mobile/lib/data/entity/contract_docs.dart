import 'dart:convert';

import 'package:e_contract/data/entity/button_show.dart';
import 'package:e_contract/data/entity/creator.dart';
import 'package:e_contract/data/entity/signer.dart';
import 'package:e_contract/data/entity/text_detail.dart';

abstract class ContractDocs {
  String? contractGuid;
  String? contractName;
  String? sampleContractName;
  List<Signer>? signers;
  int? contractStatus;
  String? lastUpdate;
  String? signDeadline;
  String? createdDate;
  String? timeRefusingSign;
  String? timeCancelled;
  String? timeCompleted;
  bool? isTimeLimit;
  ButtonShow? buttonShow;
  bool? isUseProfileType;
  String? sourceName;
  int? sourceId;
  String? code;
  String? profileTypeName;
  int? profileTypeId;
  String? profileTypeGuid;
  Creator? creator;
  String? userId;
  List<TextDetail>? listextDetail;
  String? typeSign;

  ContractDocs(
      {this.contractGuid,
      this.contractName,
      this.sampleContractName,
      this.signers,
      this.contractStatus,
      this.lastUpdate,
      this.signDeadline,
      this.timeCancelled,
      this.timeCompleted,
      this.createdDate,
      this.timeRefusingSign,
      this.isTimeLimit,
      this.buttonShow,
      this.isUseProfileType,
      this.sourceId,
      this.sourceName,
      this.code,
      this.profileTypeId,
      this.profileTypeGuid,
      this.profileTypeName,
      this.creator,
      this.listextDetail,
      this.typeSign});

  ContractDocs.fromJson(Map<String, dynamic> json, this.userId)
      : contractGuid = json['objectGuid'],
        code = json['code'],
        contractName = json['profileName'],
        sourceId = json['sourceId'],
        sourceName = json['sourceName'],
        isUseProfileType = json['isUseProfileType'],
        profileTypeId = json['profileTypeId'],
        profileTypeGuid = json['profileTypeGuid'],
        profileTypeName = json['profileTypeName'],
        signers = parseListSigner(
          jsonEncode(json['listSigner']),
          false,
          json['objectGuid'] ?? "",
        ),
        creator = Creator.fromJson(json['userCreated'], json['objectGuid']),
        createdDate = json['createdDate'],
        isTimeLimit = json['isTimeLimit'],
        signDeadline = json['signDeadline'],
        lastUpdate = json['lastUpdate'],
        contractStatus = json['status'],
        timeCompleted = json['lastUpdate'],
        timeCancelled = json['lastUpdate'],
        timeRefusingSign = json['lastUpdate'],
        buttonShow = ButtonShow.fromJson(json["buttonShow"], json['objectGuid']),
        listextDetail= parseListTextDetail(jsonEncode(json["ltProfileTextDetail"]), json['objectGuid']),
        typeSign= json["typeSign"];

  /// Bkav HanhNTHe: convert list signer
  static List<Signer> parseListSigner(
      String listSigner, bool isTextDetail, String profileId,
      {String? textDetailId}) {
    final parsed = jsonDecode(listSigner).cast<Map<String, dynamic>>();
    return parsed
        .map<Signer>((json) =>
            Signer.fromJson(json, isTextDetail, profileId, textDetailId))
        .toList();
  }

  static List<TextDetail> parseListTextDetail(String listTextDetail, String profileId){
    final parsed= jsonDecode(listTextDetail).cast<Map<String, dynamic>>();
    return parsed.map<TextDetail>((json)=> TextDetail.fromJson(json, profileId)).toList();
  }

  void setListSigner(List<Signer> signer) {
    signers = signer;
  }

  static List<String> parseListTypeSign(String typeSign){
    List<String> listTypeSign= typeSign.split(",");
    return listTypeSign;
  }
}
