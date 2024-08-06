import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/button_show.dart';
import 'package:e_contract/data/entity/contract_docs.dart';
import 'package:e_contract/data/entity/creator.dart';
import 'package:e_contract/data/entity/signer.dart';
import 'package:e_contract/data/local_data/contract_db.dart';

class ContractDocTo extends ContractDocs implements Insertable<ContractDocTo> {
  ContractDocTo(
      {String? contractGuid,
      String? contractName,
      String? sampleContractName,
      List<Signer>? signers,
      int? contractStatus,
      String? lastUpdate,
      String? signDeadline,
      String? createdDate,
      String? timeRefusingSign,
      String? timeCancelled,
      String? timeCompleted,
      bool? isTimeLimit,
      ButtonShow? buttonShow,
      bool? isUseProfileType,
      String? sourceName,
      int? sourceId,
      String? code,
      String? profileTypeName,
      int? profileTypeId,
      String? profileTypeGuid,
      Creator? creator,
      String? typeSign})
      : super(
            contractGuid: contractGuid,
            contractName: contractName,
            sampleContractName: sampleContractName,
            signers: signers,
            contractStatus: contractStatus,
            lastUpdate: lastUpdate,
            signDeadline: signDeadline,
            createdDate: createdDate,
            timeRefusingSign: timeRefusingSign,
            timeCancelled: timeCancelled,
            timeCompleted: timeCompleted,
            isTimeLimit: isTimeLimit,
            buttonShow: buttonShow,
            isUseProfileType: isUseProfileType,
            sourceId: sourceId,
            sourceName: sourceName,
            code: code,
            profileTypeName: profileTypeName,
            profileTypeId: profileTypeId,
            profileTypeGuid: profileTypeGuid,
            creator: creator,
            typeSign: typeSign);

  ContractDocTo.fromJson(Map<String, dynamic> json, String userId)
      : super.fromJson(json, userId);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ContractDocsToTableCompanion(
            userId: Value(userId),
            profileTypeGuid: Value(profileTypeGuid),
            profileTypeId: Value(profileTypeId),
            profileTypeName: Value(profileTypeName),
            code: Value(code),
            sourceName: Value(sourceName),
            sourceId: Value(sourceId),
            isUseProfileType: Value(isUseProfileType),
            timeCompleted: Value(timeCompleted),
            timeCancelled: Value(timeCancelled),
            timeRefusingSign: Value(timeRefusingSign),
            createdDate: Value(createdDate),
            signDeadline: Value(signDeadline),
            lastUpdate: Value(lastUpdate),
            contractStatus: Value(contractStatus),
            sampleContractName: Value(sampleContractName),
            creatorFullName: creator != null
                ? Value(creator!.fullName)
                : const Value.absent(),
            creatorId:
                creator != null ? Value(creator!.id) : const Value.absent(),
            creatorUserName: creator != null
                ? Value(creator!.userName)
                : const Value.absent(),
            contractName: Value(contractName),
            contractGuid: (contractGuid != null)
                ? Value(contractGuid!)
                : const Value.absent(),
            isShowButtonSign: Value(buttonShow!.sign),
            isShowButtonCopysign: Value(buttonShow!.copyPageSign),
            isShowButtonHistory: Value(buttonShow!.viewHistory),
            typeSign: Value(typeSign)
            )
        .toColumns(nullToAbsent);
  }
}
