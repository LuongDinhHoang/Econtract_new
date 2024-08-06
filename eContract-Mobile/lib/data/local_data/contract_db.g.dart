// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_db.dart';

// ignore_for_file: type=lint
class ContractDocsFromTableCompanion extends UpdateCompanion<ContractDocFrom> {
  final Value<String?> userId;
  final Value<String> contractGuid;
  final Value<String?> contractName;
  final Value<String?> lastUpdate;
  final Value<String?> sampleContractName;
  final Value<int?> contractStatus;
  final Value<String?> signDeadline;
  final Value<String?> createdDate;
  final Value<String?> timeRefusingSign;
  final Value<String?> timeCancelled;
  final Value<String?> timeCompleted;
  final Value<bool?> isUseProfileType;
  final Value<String?> sourceName;
  final Value<int?> sourceId;
  final Value<String?> code;
  final Value<String?> profileTypeName;
  final Value<String?> profileTypeGuid;
  final Value<int?> profileTypeId;
  final Value<int?> creatorId;
  final Value<String?> creatorUserName;
  final Value<String?> creatorFullName;
  final Value<bool?> isShowButtonSign;
  final Value<bool?> isShowButtonCopysign;
  final Value<bool?> isShowButtonHistory;
  final Value<String?> typeSign;
  const ContractDocsFromTableCompanion({
    this.userId = const Value.absent(),
    this.contractGuid = const Value.absent(),
    this.contractName = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.sampleContractName = const Value.absent(),
    this.contractStatus = const Value.absent(),
    this.signDeadline = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.timeRefusingSign = const Value.absent(),
    this.timeCancelled = const Value.absent(),
    this.timeCompleted = const Value.absent(),
    this.isUseProfileType = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.code = const Value.absent(),
    this.profileTypeName = const Value.absent(),
    this.profileTypeGuid = const Value.absent(),
    this.profileTypeId = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorUserName = const Value.absent(),
    this.creatorFullName = const Value.absent(),
    this.isShowButtonSign = const Value.absent(),
    this.isShowButtonCopysign = const Value.absent(),
    this.isShowButtonHistory = const Value.absent(),
    this.typeSign = const Value.absent(),
  });
  ContractDocsFromTableCompanion.insert({
    this.userId = const Value.absent(),
    required String contractGuid,
    this.contractName = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.sampleContractName = const Value.absent(),
    this.contractStatus = const Value.absent(),
    this.signDeadline = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.timeRefusingSign = const Value.absent(),
    this.timeCancelled = const Value.absent(),
    this.timeCompleted = const Value.absent(),
    this.isUseProfileType = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.code = const Value.absent(),
    this.profileTypeName = const Value.absent(),
    this.profileTypeGuid = const Value.absent(),
    this.profileTypeId = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorUserName = const Value.absent(),
    this.creatorFullName = const Value.absent(),
    this.isShowButtonSign = const Value.absent(),
    this.isShowButtonCopysign = const Value.absent(),
    this.isShowButtonHistory = const Value.absent(),
    this.typeSign = const Value.absent(),
  }) : contractGuid = Value(contractGuid);
  static Insertable<ContractDocFrom> custom({
    Expression<String>? userId,
    Expression<String>? contractGuid,
    Expression<String>? contractName,
    Expression<String>? lastUpdate,
    Expression<String>? sampleContractName,
    Expression<int>? contractStatus,
    Expression<String>? signDeadline,
    Expression<String>? createdDate,
    Expression<String>? timeRefusingSign,
    Expression<String>? timeCancelled,
    Expression<String>? timeCompleted,
    Expression<bool>? isUseProfileType,
    Expression<String>? sourceName,
    Expression<int>? sourceId,
    Expression<String>? code,
    Expression<String>? profileTypeName,
    Expression<String>? profileTypeGuid,
    Expression<int>? profileTypeId,
    Expression<int>? creatorId,
    Expression<String>? creatorUserName,
    Expression<String>? creatorFullName,
    Expression<bool>? isShowButtonSign,
    Expression<bool>? isShowButtonCopysign,
    Expression<bool>? isShowButtonHistory,
    Expression<String>? typeSign,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (contractGuid != null) 'contract_guid': contractGuid,
      if (contractName != null) 'contract_name': contractName,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (sampleContractName != null)
        'sample_contract_name': sampleContractName,
      if (contractStatus != null) 'contract_status': contractStatus,
      if (signDeadline != null) 'sign_deadline': signDeadline,
      if (createdDate != null) 'created_date': createdDate,
      if (timeRefusingSign != null) 'time_refusing_sign': timeRefusingSign,
      if (timeCancelled != null) 'time_cancelled': timeCancelled,
      if (timeCompleted != null) 'time_completed': timeCompleted,
      if (isUseProfileType != null) 'is_use_profile_type': isUseProfileType,
      if (sourceName != null) 'source_name': sourceName,
      if (sourceId != null) 'source_id': sourceId,
      if (code != null) 'code': code,
      if (profileTypeName != null) 'profile_type_name': profileTypeName,
      if (profileTypeGuid != null) 'profile_type_guid': profileTypeGuid,
      if (profileTypeId != null) 'profile_type_id': profileTypeId,
      if (creatorId != null) 'creator_id': creatorId,
      if (creatorUserName != null) 'creator_user_name': creatorUserName,
      if (creatorFullName != null) 'creator_full_name': creatorFullName,
      if (isShowButtonSign != null) 'show_button_sign': isShowButtonSign,
      if (isShowButtonCopysign != null)
        'show_button_copy_sign': isShowButtonCopysign,
      if (isShowButtonHistory != null)
        'show_button_history': isShowButtonHistory,
      if (typeSign != null) 'type_sign': typeSign,
    });
  }

  ContractDocsFromTableCompanion copyWith(
      {Value<String?>? userId,
      Value<String>? contractGuid,
      Value<String?>? contractName,
      Value<String?>? lastUpdate,
      Value<String?>? sampleContractName,
      Value<int?>? contractStatus,
      Value<String?>? signDeadline,
      Value<String?>? createdDate,
      Value<String?>? timeRefusingSign,
      Value<String?>? timeCancelled,
      Value<String?>? timeCompleted,
      Value<bool?>? isUseProfileType,
      Value<String?>? sourceName,
      Value<int?>? sourceId,
      Value<String?>? code,
      Value<String?>? profileTypeName,
      Value<String?>? profileTypeGuid,
      Value<int?>? profileTypeId,
      Value<int?>? creatorId,
      Value<String?>? creatorUserName,
      Value<String?>? creatorFullName,
      Value<bool?>? isShowButtonSign,
      Value<bool?>? isShowButtonCopysign,
      Value<bool?>? isShowButtonHistory,
      Value<String?>? typeSign}) {
    return ContractDocsFromTableCompanion(
      userId: userId ?? this.userId,
      contractGuid: contractGuid ?? this.contractGuid,
      contractName: contractName ?? this.contractName,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      sampleContractName: sampleContractName ?? this.sampleContractName,
      contractStatus: contractStatus ?? this.contractStatus,
      signDeadline: signDeadline ?? this.signDeadline,
      createdDate: createdDate ?? this.createdDate,
      timeRefusingSign: timeRefusingSign ?? this.timeRefusingSign,
      timeCancelled: timeCancelled ?? this.timeCancelled,
      timeCompleted: timeCompleted ?? this.timeCompleted,
      isUseProfileType: isUseProfileType ?? this.isUseProfileType,
      sourceName: sourceName ?? this.sourceName,
      sourceId: sourceId ?? this.sourceId,
      code: code ?? this.code,
      profileTypeName: profileTypeName ?? this.profileTypeName,
      profileTypeGuid: profileTypeGuid ?? this.profileTypeGuid,
      profileTypeId: profileTypeId ?? this.profileTypeId,
      creatorId: creatorId ?? this.creatorId,
      creatorUserName: creatorUserName ?? this.creatorUserName,
      creatorFullName: creatorFullName ?? this.creatorFullName,
      isShowButtonSign: isShowButtonSign ?? this.isShowButtonSign,
      isShowButtonCopysign: isShowButtonCopysign ?? this.isShowButtonCopysign,
      isShowButtonHistory: isShowButtonHistory ?? this.isShowButtonHistory,
      typeSign: typeSign ?? this.typeSign,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (contractGuid.present) {
      map['contract_guid'] = Variable<String>(contractGuid.value);
    }
    if (contractName.present) {
      map['contract_name'] = Variable<String>(contractName.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<String>(lastUpdate.value);
    }
    if (sampleContractName.present) {
      map['sample_contract_name'] = Variable<String>(sampleContractName.value);
    }
    if (contractStatus.present) {
      map['contract_status'] = Variable<int>(contractStatus.value);
    }
    if (signDeadline.present) {
      map['sign_deadline'] = Variable<String>(signDeadline.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<String>(createdDate.value);
    }
    if (timeRefusingSign.present) {
      map['time_refusing_sign'] = Variable<String>(timeRefusingSign.value);
    }
    if (timeCancelled.present) {
      map['time_cancelled'] = Variable<String>(timeCancelled.value);
    }
    if (timeCompleted.present) {
      map['time_completed'] = Variable<String>(timeCompleted.value);
    }
    if (isUseProfileType.present) {
      map['is_use_profile_type'] = Variable<bool>(isUseProfileType.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (profileTypeName.present) {
      map['profile_type_name'] = Variable<String>(profileTypeName.value);
    }
    if (profileTypeGuid.present) {
      map['profile_type_guid'] = Variable<String>(profileTypeGuid.value);
    }
    if (profileTypeId.present) {
      map['profile_type_id'] = Variable<int>(profileTypeId.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<int>(creatorId.value);
    }
    if (creatorUserName.present) {
      map['creator_user_name'] = Variable<String>(creatorUserName.value);
    }
    if (creatorFullName.present) {
      map['creator_full_name'] = Variable<String>(creatorFullName.value);
    }
    if (isShowButtonSign.present) {
      map['show_button_sign'] = Variable<bool>(isShowButtonSign.value);
    }
    if (isShowButtonCopysign.present) {
      map['show_button_copy_sign'] = Variable<bool>(isShowButtonCopysign.value);
    }
    if (isShowButtonHistory.present) {
      map['show_button_history'] = Variable<bool>(isShowButtonHistory.value);
    }
    if (typeSign.present) {
      map['type_sign'] = Variable<String>(typeSign.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractDocsFromTableCompanion(')
          ..write('userId: $userId, ')
          ..write('contractGuid: $contractGuid, ')
          ..write('contractName: $contractName, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('sampleContractName: $sampleContractName, ')
          ..write('contractStatus: $contractStatus, ')
          ..write('signDeadline: $signDeadline, ')
          ..write('createdDate: $createdDate, ')
          ..write('timeRefusingSign: $timeRefusingSign, ')
          ..write('timeCancelled: $timeCancelled, ')
          ..write('timeCompleted: $timeCompleted, ')
          ..write('isUseProfileType: $isUseProfileType, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceId: $sourceId, ')
          ..write('code: $code, ')
          ..write('profileTypeName: $profileTypeName, ')
          ..write('profileTypeGuid: $profileTypeGuid, ')
          ..write('profileTypeId: $profileTypeId, ')
          ..write('creatorId: $creatorId, ')
          ..write('creatorUserName: $creatorUserName, ')
          ..write('creatorFullName: $creatorFullName, ')
          ..write('isShowButtonSign: $isShowButtonSign, ')
          ..write('isShowButtonCopysign: $isShowButtonCopysign, ')
          ..write('isShowButtonHistory: $isShowButtonHistory, ')
          ..write('typeSign: $typeSign')
          ..write(')'))
        .toString();
  }
}

class $ContractDocsFromTableTable extends ContractDocsFromTable
    with TableInfo<$ContractDocsFromTableTable, ContractDocFrom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractDocsFromTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contractGuidMeta =
      const VerificationMeta('contractGuid');
  @override
  late final GeneratedColumn<String> contractGuid = GeneratedColumn<String>(
      'contract_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contractNameMeta =
      const VerificationMeta('contractName');
  @override
  late final GeneratedColumn<String> contractName = GeneratedColumn<String>(
      'contract_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<String> lastUpdate = GeneratedColumn<String>(
      'last_update', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sampleContractNameMeta =
      const VerificationMeta('sampleContractName');
  @override
  late final GeneratedColumn<String> sampleContractName =
      GeneratedColumn<String>('sample_contract_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contractStatusMeta =
      const VerificationMeta('contractStatus');
  @override
  late final GeneratedColumn<int> contractStatus = GeneratedColumn<int>(
      'contract_status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _signDeadlineMeta =
      const VerificationMeta('signDeadline');
  @override
  late final GeneratedColumn<String> signDeadline = GeneratedColumn<String>(
      'sign_deadline', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<String> createdDate = GeneratedColumn<String>(
      'created_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeRefusingSignMeta =
      const VerificationMeta('timeRefusingSign');
  @override
  late final GeneratedColumn<String> timeRefusingSign = GeneratedColumn<String>(
      'time_refusing_sign', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeCancelledMeta =
      const VerificationMeta('timeCancelled');
  @override
  late final GeneratedColumn<String> timeCancelled = GeneratedColumn<String>(
      'time_cancelled', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeCompletedMeta =
      const VerificationMeta('timeCompleted');
  @override
  late final GeneratedColumn<String> timeCompleted = GeneratedColumn<String>(
      'time_completed', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isUseProfileTypeMeta =
      const VerificationMeta('isUseProfileType');
  @override
  late final GeneratedColumn<bool> isUseProfileType =
      GeneratedColumn<bool>('is_use_profile_type', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_use_profile_type" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _sourceNameMeta =
      const VerificationMeta('sourceName');
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
      'source_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTypeNameMeta =
      const VerificationMeta('profileTypeName');
  @override
  late final GeneratedColumn<String> profileTypeName = GeneratedColumn<String>(
      'profile_type_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTypeGuidMeta =
      const VerificationMeta('profileTypeGuid');
  @override
  late final GeneratedColumn<String> profileTypeGuid = GeneratedColumn<String>(
      'profile_type_guid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTypeIdMeta =
      const VerificationMeta('profileTypeId');
  @override
  late final GeneratedColumn<int> profileTypeId = GeneratedColumn<int>(
      'profile_type_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<int> creatorId = GeneratedColumn<int>(
      'creator_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creatorUserNameMeta =
      const VerificationMeta('creatorUserName');
  @override
  late final GeneratedColumn<String> creatorUserName = GeneratedColumn<String>(
      'creator_user_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creatorFullNameMeta =
      const VerificationMeta('creatorFullName');
  @override
  late final GeneratedColumn<String> creatorFullName = GeneratedColumn<String>(
      'creator_full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isShowButtonSignMeta =
      const VerificationMeta('isShowButtonSign');
  @override
  late final GeneratedColumn<bool> isShowButtonSign =
      GeneratedColumn<bool>('show_button_sign', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("show_button_sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isShowButtonCopysignMeta =
      const VerificationMeta('isShowButtonCopysign');
  @override
  late final GeneratedColumn<bool> isShowButtonCopysign =
      GeneratedColumn<bool>('show_button_copy_sign', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("show_button_copy_sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isShowButtonHistoryMeta =
      const VerificationMeta('isShowButtonHistory');
  @override
  late final GeneratedColumn<bool> isShowButtonHistory =
      GeneratedColumn<bool>('show_button_history', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("show_button_history" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _typeSignMeta =
      const VerificationMeta('typeSign');
  @override
  late final GeneratedColumn<String> typeSign = GeneratedColumn<String>(
      'type_sign', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        contractGuid,
        contractName,
        lastUpdate,
        sampleContractName,
        contractStatus,
        signDeadline,
        createdDate,
        timeRefusingSign,
        timeCancelled,
        timeCompleted,
        isUseProfileType,
        sourceName,
        sourceId,
        code,
        profileTypeName,
        profileTypeGuid,
        profileTypeId,
        creatorId,
        creatorUserName,
        creatorFullName,
        isShowButtonSign,
        isShowButtonCopysign,
        isShowButtonHistory,
        typeSign
      ];
  @override
  String get aliasedName => _alias ?? 'contract_docs_from_table';
  @override
  String get actualTableName => 'contract_docs_from_table';
  @override
  VerificationContext validateIntegrity(Insertable<ContractDocFrom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('contract_guid')) {
      context.handle(
          _contractGuidMeta,
          contractGuid.isAcceptableOrUnknown(
              data['contract_guid']!, _contractGuidMeta));
    } else if (isInserting) {
      context.missing(_contractGuidMeta);
    }
    if (data.containsKey('contract_name')) {
      context.handle(
          _contractNameMeta,
          contractName.isAcceptableOrUnknown(
              data['contract_name']!, _contractNameMeta));
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    }
    if (data.containsKey('sample_contract_name')) {
      context.handle(
          _sampleContractNameMeta,
          sampleContractName.isAcceptableOrUnknown(
              data['sample_contract_name']!, _sampleContractNameMeta));
    }
    if (data.containsKey('contract_status')) {
      context.handle(
          _contractStatusMeta,
          contractStatus.isAcceptableOrUnknown(
              data['contract_status']!, _contractStatusMeta));
    }
    if (data.containsKey('sign_deadline')) {
      context.handle(
          _signDeadlineMeta,
          signDeadline.isAcceptableOrUnknown(
              data['sign_deadline']!, _signDeadlineMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('time_refusing_sign')) {
      context.handle(
          _timeRefusingSignMeta,
          timeRefusingSign.isAcceptableOrUnknown(
              data['time_refusing_sign']!, _timeRefusingSignMeta));
    }
    if (data.containsKey('time_cancelled')) {
      context.handle(
          _timeCancelledMeta,
          timeCancelled.isAcceptableOrUnknown(
              data['time_cancelled']!, _timeCancelledMeta));
    }
    if (data.containsKey('time_completed')) {
      context.handle(
          _timeCompletedMeta,
          timeCompleted.isAcceptableOrUnknown(
              data['time_completed']!, _timeCompletedMeta));
    }
    if (data.containsKey('is_use_profile_type')) {
      context.handle(
          _isUseProfileTypeMeta,
          isUseProfileType.isAcceptableOrUnknown(
              data['is_use_profile_type']!, _isUseProfileTypeMeta));
    }
    if (data.containsKey('source_name')) {
      context.handle(
          _sourceNameMeta,
          sourceName.isAcceptableOrUnknown(
              data['source_name']!, _sourceNameMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('profile_type_name')) {
      context.handle(
          _profileTypeNameMeta,
          profileTypeName.isAcceptableOrUnknown(
              data['profile_type_name']!, _profileTypeNameMeta));
    }
    if (data.containsKey('profile_type_guid')) {
      context.handle(
          _profileTypeGuidMeta,
          profileTypeGuid.isAcceptableOrUnknown(
              data['profile_type_guid']!, _profileTypeGuidMeta));
    }
    if (data.containsKey('profile_type_id')) {
      context.handle(
          _profileTypeIdMeta,
          profileTypeId.isAcceptableOrUnknown(
              data['profile_type_id']!, _profileTypeIdMeta));
    }
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    }
    if (data.containsKey('creator_user_name')) {
      context.handle(
          _creatorUserNameMeta,
          creatorUserName.isAcceptableOrUnknown(
              data['creator_user_name']!, _creatorUserNameMeta));
    }
    if (data.containsKey('creator_full_name')) {
      context.handle(
          _creatorFullNameMeta,
          creatorFullName.isAcceptableOrUnknown(
              data['creator_full_name']!, _creatorFullNameMeta));
    }
    if (data.containsKey('show_button_sign')) {
      context.handle(
          _isShowButtonSignMeta,
          isShowButtonSign.isAcceptableOrUnknown(
              data['show_button_sign']!, _isShowButtonSignMeta));
    }
    if (data.containsKey('show_button_copy_sign')) {
      context.handle(
          _isShowButtonCopysignMeta,
          isShowButtonCopysign.isAcceptableOrUnknown(
              data['show_button_copy_sign']!, _isShowButtonCopysignMeta));
    }
    if (data.containsKey('show_button_history')) {
      context.handle(
          _isShowButtonHistoryMeta,
          isShowButtonHistory.isAcceptableOrUnknown(
              data['show_button_history']!, _isShowButtonHistoryMeta));
    }
    if (data.containsKey('type_sign')) {
      context.handle(_typeSignMeta,
          typeSign.isAcceptableOrUnknown(data['type_sign']!, _typeSignMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contractGuid};
  @override
  ContractDocFrom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContractDocFrom(
      contractGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_guid'])!,
      contractName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_name']),
      sampleContractName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sample_contract_name']),
      contractStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contract_status']),
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_update']),
      signDeadline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sign_deadline']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_date']),
      timeRefusingSign: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}time_refusing_sign']),
      timeCancelled: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_cancelled']),
      timeCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_completed']),
      isUseProfileType: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_use_profile_type']),
      sourceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_name']),
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_id']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      profileTypeName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_type_name']),
      profileTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_type_id']),
      profileTypeGuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_type_guid']),
      typeSign: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_sign']),
    );
  }

  @override
  $ContractDocsFromTableTable createAlias(String alias) {
    return $ContractDocsFromTableTable(attachedDatabase, alias);
  }
}

class ContractDocsToTableCompanion extends UpdateCompanion<ContractDocTo> {
  final Value<String?> userId;
  final Value<String> contractGuid;
  final Value<String?> contractName;
  final Value<String?> lastUpdate;
  final Value<String?> sampleContractName;
  final Value<int?> contractStatus;
  final Value<String?> signDeadline;
  final Value<String?> createdDate;
  final Value<String?> timeRefusingSign;
  final Value<String?> timeCancelled;
  final Value<String?> timeCompleted;
  final Value<bool?> isUseProfileType;
  final Value<String?> sourceName;
  final Value<int?> sourceId;
  final Value<String?> code;
  final Value<String?> profileTypeName;
  final Value<String?> profileTypeGuid;
  final Value<int?> profileTypeId;
  final Value<int?> creatorId;
  final Value<String?> creatorUserName;
  final Value<String?> creatorFullName;
  final Value<bool?> isShowButtonSign;
  final Value<bool?> isShowButtonCopysign;
  final Value<bool?> isShowButtonHistory;
  final Value<String?> typeSign;
  const ContractDocsToTableCompanion({
    this.userId = const Value.absent(),
    this.contractGuid = const Value.absent(),
    this.contractName = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.sampleContractName = const Value.absent(),
    this.contractStatus = const Value.absent(),
    this.signDeadline = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.timeRefusingSign = const Value.absent(),
    this.timeCancelled = const Value.absent(),
    this.timeCompleted = const Value.absent(),
    this.isUseProfileType = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.code = const Value.absent(),
    this.profileTypeName = const Value.absent(),
    this.profileTypeGuid = const Value.absent(),
    this.profileTypeId = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorUserName = const Value.absent(),
    this.creatorFullName = const Value.absent(),
    this.isShowButtonSign = const Value.absent(),
    this.isShowButtonCopysign = const Value.absent(),
    this.isShowButtonHistory = const Value.absent(),
    this.typeSign = const Value.absent(),
  });
  ContractDocsToTableCompanion.insert({
    this.userId = const Value.absent(),
    required String contractGuid,
    this.contractName = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.sampleContractName = const Value.absent(),
    this.contractStatus = const Value.absent(),
    this.signDeadline = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.timeRefusingSign = const Value.absent(),
    this.timeCancelled = const Value.absent(),
    this.timeCompleted = const Value.absent(),
    this.isUseProfileType = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.code = const Value.absent(),
    this.profileTypeName = const Value.absent(),
    this.profileTypeGuid = const Value.absent(),
    this.profileTypeId = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorUserName = const Value.absent(),
    this.creatorFullName = const Value.absent(),
    this.isShowButtonSign = const Value.absent(),
    this.isShowButtonCopysign = const Value.absent(),
    this.isShowButtonHistory = const Value.absent(),
    this.typeSign = const Value.absent(),
  }) : contractGuid = Value(contractGuid);
  static Insertable<ContractDocTo> custom({
    Expression<String>? userId,
    Expression<String>? contractGuid,
    Expression<String>? contractName,
    Expression<String>? lastUpdate,
    Expression<String>? sampleContractName,
    Expression<int>? contractStatus,
    Expression<String>? signDeadline,
    Expression<String>? createdDate,
    Expression<String>? timeRefusingSign,
    Expression<String>? timeCancelled,
    Expression<String>? timeCompleted,
    Expression<bool>? isUseProfileType,
    Expression<String>? sourceName,
    Expression<int>? sourceId,
    Expression<String>? code,
    Expression<String>? profileTypeName,
    Expression<String>? profileTypeGuid,
    Expression<int>? profileTypeId,
    Expression<int>? creatorId,
    Expression<String>? creatorUserName,
    Expression<String>? creatorFullName,
    Expression<bool>? isShowButtonSign,
    Expression<bool>? isShowButtonCopysign,
    Expression<bool>? isShowButtonHistory,
    Expression<String>? typeSign,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (contractGuid != null) 'contract_guid': contractGuid,
      if (contractName != null) 'contract_name': contractName,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (sampleContractName != null)
        'sample_contract_name': sampleContractName,
      if (contractStatus != null) 'contract_status': contractStatus,
      if (signDeadline != null) 'sign_deadline': signDeadline,
      if (createdDate != null) 'created_date': createdDate,
      if (timeRefusingSign != null) 'time_refusing_sign': timeRefusingSign,
      if (timeCancelled != null) 'time_cancelled': timeCancelled,
      if (timeCompleted != null) 'time_completed': timeCompleted,
      if (isUseProfileType != null) 'is_use_profile_type': isUseProfileType,
      if (sourceName != null) 'source_name': sourceName,
      if (sourceId != null) 'source_id': sourceId,
      if (code != null) 'code': code,
      if (profileTypeName != null) 'profile_type_name': profileTypeName,
      if (profileTypeGuid != null) 'profile_type_guid': profileTypeGuid,
      if (profileTypeId != null) 'profile_type_id': profileTypeId,
      if (creatorId != null) 'creator_id': creatorId,
      if (creatorUserName != null) 'creator_user_name': creatorUserName,
      if (creatorFullName != null) 'creator_full_name': creatorFullName,
      if (isShowButtonSign != null) 'show_button_sign': isShowButtonSign,
      if (isShowButtonCopysign != null)
        'show_button_copy_sign': isShowButtonCopysign,
      if (isShowButtonHistory != null)
        'show_button_history': isShowButtonHistory,
      if (typeSign != null) 'type_sign': typeSign,
    });
  }

  ContractDocsToTableCompanion copyWith(
      {Value<String?>? userId,
      Value<String>? contractGuid,
      Value<String?>? contractName,
      Value<String?>? lastUpdate,
      Value<String?>? sampleContractName,
      Value<int?>? contractStatus,
      Value<String?>? signDeadline,
      Value<String?>? createdDate,
      Value<String?>? timeRefusingSign,
      Value<String?>? timeCancelled,
      Value<String?>? timeCompleted,
      Value<bool?>? isUseProfileType,
      Value<String?>? sourceName,
      Value<int?>? sourceId,
      Value<String?>? code,
      Value<String?>? profileTypeName,
      Value<String?>? profileTypeGuid,
      Value<int?>? profileTypeId,
      Value<int?>? creatorId,
      Value<String?>? creatorUserName,
      Value<String?>? creatorFullName,
      Value<bool?>? isShowButtonSign,
      Value<bool?>? isShowButtonCopysign,
      Value<bool?>? isShowButtonHistory,
      Value<String?>? typeSign}) {
    return ContractDocsToTableCompanion(
      userId: userId ?? this.userId,
      contractGuid: contractGuid ?? this.contractGuid,
      contractName: contractName ?? this.contractName,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      sampleContractName: sampleContractName ?? this.sampleContractName,
      contractStatus: contractStatus ?? this.contractStatus,
      signDeadline: signDeadline ?? this.signDeadline,
      createdDate: createdDate ?? this.createdDate,
      timeRefusingSign: timeRefusingSign ?? this.timeRefusingSign,
      timeCancelled: timeCancelled ?? this.timeCancelled,
      timeCompleted: timeCompleted ?? this.timeCompleted,
      isUseProfileType: isUseProfileType ?? this.isUseProfileType,
      sourceName: sourceName ?? this.sourceName,
      sourceId: sourceId ?? this.sourceId,
      code: code ?? this.code,
      profileTypeName: profileTypeName ?? this.profileTypeName,
      profileTypeGuid: profileTypeGuid ?? this.profileTypeGuid,
      profileTypeId: profileTypeId ?? this.profileTypeId,
      creatorId: creatorId ?? this.creatorId,
      creatorUserName: creatorUserName ?? this.creatorUserName,
      creatorFullName: creatorFullName ?? this.creatorFullName,
      isShowButtonSign: isShowButtonSign ?? this.isShowButtonSign,
      isShowButtonCopysign: isShowButtonCopysign ?? this.isShowButtonCopysign,
      isShowButtonHistory: isShowButtonHistory ?? this.isShowButtonHistory,
      typeSign: typeSign ?? this.typeSign,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (contractGuid.present) {
      map['contract_guid'] = Variable<String>(contractGuid.value);
    }
    if (contractName.present) {
      map['contract_name'] = Variable<String>(contractName.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<String>(lastUpdate.value);
    }
    if (sampleContractName.present) {
      map['sample_contract_name'] = Variable<String>(sampleContractName.value);
    }
    if (contractStatus.present) {
      map['contract_status'] = Variable<int>(contractStatus.value);
    }
    if (signDeadline.present) {
      map['sign_deadline'] = Variable<String>(signDeadline.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<String>(createdDate.value);
    }
    if (timeRefusingSign.present) {
      map['time_refusing_sign'] = Variable<String>(timeRefusingSign.value);
    }
    if (timeCancelled.present) {
      map['time_cancelled'] = Variable<String>(timeCancelled.value);
    }
    if (timeCompleted.present) {
      map['time_completed'] = Variable<String>(timeCompleted.value);
    }
    if (isUseProfileType.present) {
      map['is_use_profile_type'] = Variable<bool>(isUseProfileType.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (profileTypeName.present) {
      map['profile_type_name'] = Variable<String>(profileTypeName.value);
    }
    if (profileTypeGuid.present) {
      map['profile_type_guid'] = Variable<String>(profileTypeGuid.value);
    }
    if (profileTypeId.present) {
      map['profile_type_id'] = Variable<int>(profileTypeId.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<int>(creatorId.value);
    }
    if (creatorUserName.present) {
      map['creator_user_name'] = Variable<String>(creatorUserName.value);
    }
    if (creatorFullName.present) {
      map['creator_full_name'] = Variable<String>(creatorFullName.value);
    }
    if (isShowButtonSign.present) {
      map['show_button_sign'] = Variable<bool>(isShowButtonSign.value);
    }
    if (isShowButtonCopysign.present) {
      map['show_button_copy_sign'] = Variable<bool>(isShowButtonCopysign.value);
    }
    if (isShowButtonHistory.present) {
      map['show_button_history'] = Variable<bool>(isShowButtonHistory.value);
    }
    if (typeSign.present) {
      map['type_sign'] = Variable<String>(typeSign.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractDocsToTableCompanion(')
          ..write('userId: $userId, ')
          ..write('contractGuid: $contractGuid, ')
          ..write('contractName: $contractName, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('sampleContractName: $sampleContractName, ')
          ..write('contractStatus: $contractStatus, ')
          ..write('signDeadline: $signDeadline, ')
          ..write('createdDate: $createdDate, ')
          ..write('timeRefusingSign: $timeRefusingSign, ')
          ..write('timeCancelled: $timeCancelled, ')
          ..write('timeCompleted: $timeCompleted, ')
          ..write('isUseProfileType: $isUseProfileType, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceId: $sourceId, ')
          ..write('code: $code, ')
          ..write('profileTypeName: $profileTypeName, ')
          ..write('profileTypeGuid: $profileTypeGuid, ')
          ..write('profileTypeId: $profileTypeId, ')
          ..write('creatorId: $creatorId, ')
          ..write('creatorUserName: $creatorUserName, ')
          ..write('creatorFullName: $creatorFullName, ')
          ..write('isShowButtonSign: $isShowButtonSign, ')
          ..write('isShowButtonCopysign: $isShowButtonCopysign, ')
          ..write('isShowButtonHistory: $isShowButtonHistory, ')
          ..write('typeSign: $typeSign')
          ..write(')'))
        .toString();
  }
}

class $ContractDocsToTableTable extends ContractDocsToTable
    with TableInfo<$ContractDocsToTableTable, ContractDocTo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractDocsToTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contractGuidMeta =
      const VerificationMeta('contractGuid');
  @override
  late final GeneratedColumn<String> contractGuid = GeneratedColumn<String>(
      'contract_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contractNameMeta =
      const VerificationMeta('contractName');
  @override
  late final GeneratedColumn<String> contractName = GeneratedColumn<String>(
      'contract_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<String> lastUpdate = GeneratedColumn<String>(
      'last_update', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sampleContractNameMeta =
      const VerificationMeta('sampleContractName');
  @override
  late final GeneratedColumn<String> sampleContractName =
      GeneratedColumn<String>('sample_contract_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contractStatusMeta =
      const VerificationMeta('contractStatus');
  @override
  late final GeneratedColumn<int> contractStatus = GeneratedColumn<int>(
      'contract_status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _signDeadlineMeta =
      const VerificationMeta('signDeadline');
  @override
  late final GeneratedColumn<String> signDeadline = GeneratedColumn<String>(
      'sign_deadline', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<String> createdDate = GeneratedColumn<String>(
      'created_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeRefusingSignMeta =
      const VerificationMeta('timeRefusingSign');
  @override
  late final GeneratedColumn<String> timeRefusingSign = GeneratedColumn<String>(
      'time_refusing_sign', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeCancelledMeta =
      const VerificationMeta('timeCancelled');
  @override
  late final GeneratedColumn<String> timeCancelled = GeneratedColumn<String>(
      'time_cancelled', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeCompletedMeta =
      const VerificationMeta('timeCompleted');
  @override
  late final GeneratedColumn<String> timeCompleted = GeneratedColumn<String>(
      'time_completed', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isUseProfileTypeMeta =
      const VerificationMeta('isUseProfileType');
  @override
  late final GeneratedColumn<bool> isUseProfileType =
      GeneratedColumn<bool>('is_use_profile_type', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_use_profile_type" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _sourceNameMeta =
      const VerificationMeta('sourceName');
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
      'source_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTypeNameMeta =
      const VerificationMeta('profileTypeName');
  @override
  late final GeneratedColumn<String> profileTypeName = GeneratedColumn<String>(
      'profile_type_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTypeGuidMeta =
      const VerificationMeta('profileTypeGuid');
  @override
  late final GeneratedColumn<String> profileTypeGuid = GeneratedColumn<String>(
      'profile_type_guid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTypeIdMeta =
      const VerificationMeta('profileTypeId');
  @override
  late final GeneratedColumn<int> profileTypeId = GeneratedColumn<int>(
      'profile_type_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<int> creatorId = GeneratedColumn<int>(
      'creator_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creatorUserNameMeta =
      const VerificationMeta('creatorUserName');
  @override
  late final GeneratedColumn<String> creatorUserName = GeneratedColumn<String>(
      'creator_user_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creatorFullNameMeta =
      const VerificationMeta('creatorFullName');
  @override
  late final GeneratedColumn<String> creatorFullName = GeneratedColumn<String>(
      'creator_full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isShowButtonSignMeta =
      const VerificationMeta('isShowButtonSign');
  @override
  late final GeneratedColumn<bool> isShowButtonSign =
      GeneratedColumn<bool>('show_button_sign', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("show_button_sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isShowButtonCopysignMeta =
      const VerificationMeta('isShowButtonCopysign');
  @override
  late final GeneratedColumn<bool> isShowButtonCopysign =
      GeneratedColumn<bool>('show_button_copy_sign', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("show_button_copy_sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isShowButtonHistoryMeta =
      const VerificationMeta('isShowButtonHistory');
  @override
  late final GeneratedColumn<bool> isShowButtonHistory =
      GeneratedColumn<bool>('show_button_history', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("show_button_history" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _typeSignMeta =
      const VerificationMeta('typeSign');
  @override
  late final GeneratedColumn<String> typeSign = GeneratedColumn<String>(
      'type_sign', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        contractGuid,
        contractName,
        lastUpdate,
        sampleContractName,
        contractStatus,
        signDeadline,
        createdDate,
        timeRefusingSign,
        timeCancelled,
        timeCompleted,
        isUseProfileType,
        sourceName,
        sourceId,
        code,
        profileTypeName,
        profileTypeGuid,
        profileTypeId,
        creatorId,
        creatorUserName,
        creatorFullName,
        isShowButtonSign,
        isShowButtonCopysign,
        isShowButtonHistory,
        typeSign
      ];
  @override
  String get aliasedName => _alias ?? 'contract_docs_to_table';
  @override
  String get actualTableName => 'contract_docs_to_table';
  @override
  VerificationContext validateIntegrity(Insertable<ContractDocTo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('contract_guid')) {
      context.handle(
          _contractGuidMeta,
          contractGuid.isAcceptableOrUnknown(
              data['contract_guid']!, _contractGuidMeta));
    } else if (isInserting) {
      context.missing(_contractGuidMeta);
    }
    if (data.containsKey('contract_name')) {
      context.handle(
          _contractNameMeta,
          contractName.isAcceptableOrUnknown(
              data['contract_name']!, _contractNameMeta));
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    }
    if (data.containsKey('sample_contract_name')) {
      context.handle(
          _sampleContractNameMeta,
          sampleContractName.isAcceptableOrUnknown(
              data['sample_contract_name']!, _sampleContractNameMeta));
    }
    if (data.containsKey('contract_status')) {
      context.handle(
          _contractStatusMeta,
          contractStatus.isAcceptableOrUnknown(
              data['contract_status']!, _contractStatusMeta));
    }
    if (data.containsKey('sign_deadline')) {
      context.handle(
          _signDeadlineMeta,
          signDeadline.isAcceptableOrUnknown(
              data['sign_deadline']!, _signDeadlineMeta));
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('time_refusing_sign')) {
      context.handle(
          _timeRefusingSignMeta,
          timeRefusingSign.isAcceptableOrUnknown(
              data['time_refusing_sign']!, _timeRefusingSignMeta));
    }
    if (data.containsKey('time_cancelled')) {
      context.handle(
          _timeCancelledMeta,
          timeCancelled.isAcceptableOrUnknown(
              data['time_cancelled']!, _timeCancelledMeta));
    }
    if (data.containsKey('time_completed')) {
      context.handle(
          _timeCompletedMeta,
          timeCompleted.isAcceptableOrUnknown(
              data['time_completed']!, _timeCompletedMeta));
    }
    if (data.containsKey('is_use_profile_type')) {
      context.handle(
          _isUseProfileTypeMeta,
          isUseProfileType.isAcceptableOrUnknown(
              data['is_use_profile_type']!, _isUseProfileTypeMeta));
    }
    if (data.containsKey('source_name')) {
      context.handle(
          _sourceNameMeta,
          sourceName.isAcceptableOrUnknown(
              data['source_name']!, _sourceNameMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('profile_type_name')) {
      context.handle(
          _profileTypeNameMeta,
          profileTypeName.isAcceptableOrUnknown(
              data['profile_type_name']!, _profileTypeNameMeta));
    }
    if (data.containsKey('profile_type_guid')) {
      context.handle(
          _profileTypeGuidMeta,
          profileTypeGuid.isAcceptableOrUnknown(
              data['profile_type_guid']!, _profileTypeGuidMeta));
    }
    if (data.containsKey('profile_type_id')) {
      context.handle(
          _profileTypeIdMeta,
          profileTypeId.isAcceptableOrUnknown(
              data['profile_type_id']!, _profileTypeIdMeta));
    }
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    }
    if (data.containsKey('creator_user_name')) {
      context.handle(
          _creatorUserNameMeta,
          creatorUserName.isAcceptableOrUnknown(
              data['creator_user_name']!, _creatorUserNameMeta));
    }
    if (data.containsKey('creator_full_name')) {
      context.handle(
          _creatorFullNameMeta,
          creatorFullName.isAcceptableOrUnknown(
              data['creator_full_name']!, _creatorFullNameMeta));
    }
    if (data.containsKey('show_button_sign')) {
      context.handle(
          _isShowButtonSignMeta,
          isShowButtonSign.isAcceptableOrUnknown(
              data['show_button_sign']!, _isShowButtonSignMeta));
    }
    if (data.containsKey('show_button_copy_sign')) {
      context.handle(
          _isShowButtonCopysignMeta,
          isShowButtonCopysign.isAcceptableOrUnknown(
              data['show_button_copy_sign']!, _isShowButtonCopysignMeta));
    }
    if (data.containsKey('show_button_history')) {
      context.handle(
          _isShowButtonHistoryMeta,
          isShowButtonHistory.isAcceptableOrUnknown(
              data['show_button_history']!, _isShowButtonHistoryMeta));
    }
    if (data.containsKey('type_sign')) {
      context.handle(_typeSignMeta,
          typeSign.isAcceptableOrUnknown(data['type_sign']!, _typeSignMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contractGuid};
  @override
  ContractDocTo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContractDocTo(
      contractGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_guid'])!,
      contractName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_name']),
      sampleContractName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sample_contract_name']),
      contractStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contract_status']),
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_update']),
      signDeadline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sign_deadline']),
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_date']),
      timeRefusingSign: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}time_refusing_sign']),
      timeCancelled: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_cancelled']),
      timeCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_completed']),
      isUseProfileType: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_use_profile_type']),
      sourceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_name']),
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_id']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      profileTypeName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_type_name']),
      profileTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_type_id']),
      profileTypeGuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_type_guid']),
      typeSign: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_sign']),
    );
  }

  @override
  $ContractDocsToTableTable createAlias(String alias) {
    return $ContractDocsToTableTable(attachedDatabase, alias);
  }
}

class SignerTableCompanion extends UpdateCompanion<Signer> {
  final Value<String> profileGuid;
  final Value<String?> textDetailGuid;
  final Value<String?> objectGuid;
  final Value<int> statusView;
  final Value<int> statusSign;
  final Value<String?> signerName;
  final Value<int> typeSignId;
  final Value<String?> signDate;
  final Value<String?> unitCode2;
  const SignerTableCompanion({
    this.profileGuid = const Value.absent(),
    this.textDetailGuid = const Value.absent(),
    this.objectGuid = const Value.absent(),
    this.statusView = const Value.absent(),
    this.statusSign = const Value.absent(),
    this.signerName = const Value.absent(),
    this.typeSignId = const Value.absent(),
    this.signDate = const Value.absent(),
    this.unitCode2 = const Value.absent(),
  });
  SignerTableCompanion.insert({
    required String profileGuid,
    this.textDetailGuid = const Value.absent(),
    this.objectGuid = const Value.absent(),
    required int statusView,
    required int statusSign,
    this.signerName = const Value.absent(),
    required int typeSignId,
    this.signDate = const Value.absent(),
    this.unitCode2 = const Value.absent(),
  })  : profileGuid = Value(profileGuid),
        statusView = Value(statusView),
        statusSign = Value(statusSign),
        typeSignId = Value(typeSignId);
  static Insertable<Signer> custom({
    Expression<String>? profileGuid,
    Expression<String>? textDetailGuid,
    Expression<String>? objectGuid,
    Expression<int>? statusView,
    Expression<int>? statusSign,
    Expression<String>? signerName,
    Expression<int>? typeSignId,
    Expression<String>? signDate,
    Expression<String>? unitCode2,
  }) {
    return RawValuesInsertable({
      if (profileGuid != null) 'profile_guid': profileGuid,
      if (textDetailGuid != null) 'text_detail_guid': textDetailGuid,
      if (objectGuid != null) 'objectGuid': objectGuid,
      if (statusView != null) 'status_view': statusView,
      if (statusSign != null) 'status_sign': statusSign,
      if (signerName != null) 'sign_name': signerName,
      if (typeSignId != null) 'type_sign_id': typeSignId,
      if (signDate != null) 'sign_date': signDate,
      if (unitCode2 != null) 'unit_code': unitCode2,
    });
  }

  SignerTableCompanion copyWith(
      {Value<String>? profileGuid,
      Value<String?>? textDetailGuid,
      Value<String?>? objectGuid,
      Value<int>? statusView,
      Value<int>? statusSign,
      Value<String?>? signerName,
      Value<int>? typeSignId,
      Value<String?>? signDate,
      Value<String?>? unitCode2}) {
    return SignerTableCompanion(
      profileGuid: profileGuid ?? this.profileGuid,
      textDetailGuid: textDetailGuid ?? this.textDetailGuid,
      objectGuid: objectGuid ?? this.objectGuid,
      statusView: statusView ?? this.statusView,
      statusSign: statusSign ?? this.statusSign,
      signerName: signerName ?? this.signerName,
      typeSignId: typeSignId ?? this.typeSignId,
      signDate: signDate ?? this.signDate,
      unitCode2: unitCode2 ?? this.unitCode2,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileGuid.present) {
      map['profile_guid'] = Variable<String>(profileGuid.value);
    }
    if (textDetailGuid.present) {
      map['text_detail_guid'] = Variable<String>(textDetailGuid.value);
    }
    if (objectGuid.present) {
      map['objectGuid'] = Variable<String>(objectGuid.value);
    }
    if (statusView.present) {
      map['status_view'] = Variable<int>(statusView.value);
    }
    if (statusSign.present) {
      map['status_sign'] = Variable<int>(statusSign.value);
    }
    if (signerName.present) {
      map['sign_name'] = Variable<String>(signerName.value);
    }
    if (typeSignId.present) {
      map['type_sign_id'] = Variable<int>(typeSignId.value);
    }
    if (signDate.present) {
      map['sign_date'] = Variable<String>(signDate.value);
    }
    if (unitCode2.present) {
      map['unit_code'] = Variable<String>(unitCode2.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignerTableCompanion(')
          ..write('profileGuid: $profileGuid, ')
          ..write('textDetailGuid: $textDetailGuid, ')
          ..write('objectGuid: $objectGuid, ')
          ..write('statusView: $statusView, ')
          ..write('statusSign: $statusSign, ')
          ..write('signerName: $signerName, ')
          ..write('typeSignId: $typeSignId, ')
          ..write('signDate: $signDate, ')
          ..write('unitCode2: $unitCode2')
          ..write(')'))
        .toString();
  }
}

class $SignerTableTable extends SignerTable
    with TableInfo<$SignerTableTable, Signer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileGuidMeta =
      const VerificationMeta('profileGuid');
  @override
  late final GeneratedColumn<String> profileGuid = GeneratedColumn<String>(
      'profile_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textDetailGuidMeta =
      const VerificationMeta('textDetailGuid');
  @override
  late final GeneratedColumn<String> textDetailGuid = GeneratedColumn<String>(
      'text_detail_guid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _objectGuidMeta =
      const VerificationMeta('objectGuid');
  @override
  late final GeneratedColumn<String> objectGuid = GeneratedColumn<String>(
      'objectGuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusViewMeta =
      const VerificationMeta('statusView');
  @override
  late final GeneratedColumn<int> statusView = GeneratedColumn<int>(
      'status_view', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusSignMeta =
      const VerificationMeta('statusSign');
  @override
  late final GeneratedColumn<int> statusSign = GeneratedColumn<int>(
      'status_sign', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _signerNameMeta =
      const VerificationMeta('signerName');
  @override
  late final GeneratedColumn<String> signerName = GeneratedColumn<String>(
      'sign_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeSignIdMeta =
      const VerificationMeta('typeSignId');
  @override
  late final GeneratedColumn<int> typeSignId = GeneratedColumn<int>(
      'type_sign_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _signDateMeta =
      const VerificationMeta('signDate');
  @override
  late final GeneratedColumn<String> signDate = GeneratedColumn<String>(
      'sign_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitCode2Meta =
      const VerificationMeta('unitCode2');
  @override
  late final GeneratedColumn<String> unitCode2 = GeneratedColumn<String>(
      'unit_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        profileGuid,
        textDetailGuid,
        objectGuid,
        statusView,
        statusSign,
        signerName,
        typeSignId,
        signDate,
        unitCode2
      ];
  @override
  String get aliasedName => _alias ?? 'signer_table';
  @override
  String get actualTableName => 'signer_table';
  @override
  VerificationContext validateIntegrity(Insertable<Signer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_guid')) {
      context.handle(
          _profileGuidMeta,
          profileGuid.isAcceptableOrUnknown(
              data['profile_guid']!, _profileGuidMeta));
    } else if (isInserting) {
      context.missing(_profileGuidMeta);
    }
    if (data.containsKey('text_detail_guid')) {
      context.handle(
          _textDetailGuidMeta,
          textDetailGuid.isAcceptableOrUnknown(
              data['text_detail_guid']!, _textDetailGuidMeta));
    }
    if (data.containsKey('objectGuid')) {
      context.handle(
          _objectGuidMeta,
          objectGuid.isAcceptableOrUnknown(
              data['objectGuid']!, _objectGuidMeta));
    }
    if (data.containsKey('status_view')) {
      context.handle(
          _statusViewMeta,
          statusView.isAcceptableOrUnknown(
              data['status_view']!, _statusViewMeta));
    } else if (isInserting) {
      context.missing(_statusViewMeta);
    }
    if (data.containsKey('status_sign')) {
      context.handle(
          _statusSignMeta,
          statusSign.isAcceptableOrUnknown(
              data['status_sign']!, _statusSignMeta));
    } else if (isInserting) {
      context.missing(_statusSignMeta);
    }
    if (data.containsKey('sign_name')) {
      context.handle(
          _signerNameMeta,
          signerName.isAcceptableOrUnknown(
              data['sign_name']!, _signerNameMeta));
    }
    if (data.containsKey('type_sign_id')) {
      context.handle(
          _typeSignIdMeta,
          typeSignId.isAcceptableOrUnknown(
              data['type_sign_id']!, _typeSignIdMeta));
    } else if (isInserting) {
      context.missing(_typeSignIdMeta);
    }
    if (data.containsKey('sign_date')) {
      context.handle(_signDateMeta,
          signDate.isAcceptableOrUnknown(data['sign_date']!, _signDateMeta));
    }
    if (data.containsKey('unit_code')) {
      context.handle(_unitCode2Meta,
          unitCode2.isAcceptableOrUnknown(data['unit_code']!, _unitCode2Meta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {objectGuid};
  @override
  Signer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Signer(
      objectGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}objectGuid']),
      statusSign: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status_sign'])!,
      signerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sign_name']),
      statusView: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status_view'])!,
      typeSignId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_sign_id'])!,
      signDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sign_date']),
      unitCode2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_code']),
      profileGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_guid'])!,
      textDetailGuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_detail_guid']),
    );
  }

  @override
  $SignerTableTable createAlias(String alias) {
    return $SignerTableTable(attachedDatabase, alias);
  }
}

class TextDetailTableCompanion extends UpdateCompanion<TextDetail> {
  final Value<String> profileGuid;
  final Value<String> objectGuid;
  final Value<String> fileName;
  const TextDetailTableCompanion({
    this.profileGuid = const Value.absent(),
    this.objectGuid = const Value.absent(),
    this.fileName = const Value.absent(),
  });
  TextDetailTableCompanion.insert({
    required String profileGuid,
    required String objectGuid,
    required String fileName,
  })  : profileGuid = Value(profileGuid),
        objectGuid = Value(objectGuid),
        fileName = Value(fileName);
  static Insertable<TextDetail> custom({
    Expression<String>? profileGuid,
    Expression<String>? objectGuid,
    Expression<String>? fileName,
  }) {
    return RawValuesInsertable({
      if (profileGuid != null) 'profile_guid': profileGuid,
      if (objectGuid != null) 'objectGuid': objectGuid,
      if (fileName != null) 'status_view': fileName,
    });
  }

  TextDetailTableCompanion copyWith(
      {Value<String>? profileGuid,
      Value<String>? objectGuid,
      Value<String>? fileName}) {
    return TextDetailTableCompanion(
      profileGuid: profileGuid ?? this.profileGuid,
      objectGuid: objectGuid ?? this.objectGuid,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileGuid.present) {
      map['profile_guid'] = Variable<String>(profileGuid.value);
    }
    if (objectGuid.present) {
      map['objectGuid'] = Variable<String>(objectGuid.value);
    }
    if (fileName.present) {
      map['status_view'] = Variable<String>(fileName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextDetailTableCompanion(')
          ..write('profileGuid: $profileGuid, ')
          ..write('objectGuid: $objectGuid, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }
}

class $TextDetailTableTable extends TextDetailTable
    with TableInfo<$TextDetailTableTable, TextDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TextDetailTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileGuidMeta =
      const VerificationMeta('profileGuid');
  @override
  late final GeneratedColumn<String> profileGuid = GeneratedColumn<String>(
      'profile_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _objectGuidMeta =
      const VerificationMeta('objectGuid');
  @override
  late final GeneratedColumn<String> objectGuid = GeneratedColumn<String>(
      'objectGuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'status_view', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [profileGuid, objectGuid, fileName];
  @override
  String get aliasedName => _alias ?? 'text_detail_table';
  @override
  String get actualTableName => 'text_detail_table';
  @override
  VerificationContext validateIntegrity(Insertable<TextDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_guid')) {
      context.handle(
          _profileGuidMeta,
          profileGuid.isAcceptableOrUnknown(
              data['profile_guid']!, _profileGuidMeta));
    } else if (isInserting) {
      context.missing(_profileGuidMeta);
    }
    if (data.containsKey('objectGuid')) {
      context.handle(
          _objectGuidMeta,
          objectGuid.isAcceptableOrUnknown(
              data['objectGuid']!, _objectGuidMeta));
    } else if (isInserting) {
      context.missing(_objectGuidMeta);
    }
    if (data.containsKey('status_view')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['status_view']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {objectGuid};
  @override
  TextDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TextDetail(
      objectGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}objectGuid'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_view'])!,
      profileGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_guid'])!,
    );
  }

  @override
  $TextDetailTableTable createAlias(String alias) {
    return $TextDetailTableTable(attachedDatabase, alias);
  }
}

class TextSignerTableData extends DataClass
    implements Insertable<TextSignerTableData> {
  final String profileTextGuid;
  final String? profileSignerGuid;
  final int? status;
  const TextSignerTableData(
      {required this.profileTextGuid, this.profileSignerGuid, this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_text_guid'] = Variable<String>(profileTextGuid);
    if (!nullToAbsent || profileSignerGuid != null) {
      map['profile_signer_guid'] = Variable<String>(profileSignerGuid);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    return map;
  }

  TextSignerTableCompanion toCompanion(bool nullToAbsent) {
    return TextSignerTableCompanion(
      profileTextGuid: Value(profileTextGuid),
      profileSignerGuid: profileSignerGuid == null && nullToAbsent
          ? const Value.absent()
          : Value(profileSignerGuid),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory TextSignerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TextSignerTableData(
      profileTextGuid: serializer.fromJson<String>(json['profileTextGuid']),
      profileSignerGuid:
          serializer.fromJson<String?>(json['profileSignerGuid']),
      status: serializer.fromJson<int?>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileTextGuid': serializer.toJson<String>(profileTextGuid),
      'profileSignerGuid': serializer.toJson<String?>(profileSignerGuid),
      'status': serializer.toJson<int?>(status),
    };
  }

  TextSignerTableData copyWith(
          {String? profileTextGuid,
          Value<String?> profileSignerGuid = const Value.absent(),
          Value<int?> status = const Value.absent()}) =>
      TextSignerTableData(
        profileTextGuid: profileTextGuid ?? this.profileTextGuid,
        profileSignerGuid: profileSignerGuid.present
            ? profileSignerGuid.value
            : this.profileSignerGuid,
        status: status.present ? status.value : this.status,
      );
  @override
  String toString() {
    return (StringBuffer('TextSignerTableData(')
          ..write('profileTextGuid: $profileTextGuid, ')
          ..write('profileSignerGuid: $profileSignerGuid, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileTextGuid, profileSignerGuid, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextSignerTableData &&
          other.profileTextGuid == this.profileTextGuid &&
          other.profileSignerGuid == this.profileSignerGuid &&
          other.status == this.status);
}

class TextSignerTableCompanion extends UpdateCompanion<TextSignerTableData> {
  final Value<String> profileTextGuid;
  final Value<String?> profileSignerGuid;
  final Value<int?> status;
  const TextSignerTableCompanion({
    this.profileTextGuid = const Value.absent(),
    this.profileSignerGuid = const Value.absent(),
    this.status = const Value.absent(),
  });
  TextSignerTableCompanion.insert({
    required String profileTextGuid,
    this.profileSignerGuid = const Value.absent(),
    this.status = const Value.absent(),
  }) : profileTextGuid = Value(profileTextGuid);
  static Insertable<TextSignerTableData> custom({
    Expression<String>? profileTextGuid,
    Expression<String>? profileSignerGuid,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (profileTextGuid != null) 'profile_text_guid': profileTextGuid,
      if (profileSignerGuid != null) 'profile_signer_guid': profileSignerGuid,
      if (status != null) 'status': status,
    });
  }

  TextSignerTableCompanion copyWith(
      {Value<String>? profileTextGuid,
      Value<String?>? profileSignerGuid,
      Value<int?>? status}) {
    return TextSignerTableCompanion(
      profileTextGuid: profileTextGuid ?? this.profileTextGuid,
      profileSignerGuid: profileSignerGuid ?? this.profileSignerGuid,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileTextGuid.present) {
      map['profile_text_guid'] = Variable<String>(profileTextGuid.value);
    }
    if (profileSignerGuid.present) {
      map['profile_signer_guid'] = Variable<String>(profileSignerGuid.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextSignerTableCompanion(')
          ..write('profileTextGuid: $profileTextGuid, ')
          ..write('profileSignerGuid: $profileSignerGuid, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TextSignerTableTable extends TextSignerTable
    with TableInfo<$TextSignerTableTable, TextSignerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TextSignerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileTextGuidMeta =
      const VerificationMeta('profileTextGuid');
  @override
  late final GeneratedColumn<String> profileTextGuid = GeneratedColumn<String>(
      'profile_text_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _profileSignerGuidMeta =
      const VerificationMeta('profileSignerGuid');
  @override
  late final GeneratedColumn<String> profileSignerGuid =
      GeneratedColumn<String>('profile_signer_guid', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [profileTextGuid, profileSignerGuid, status];
  @override
  String get aliasedName => _alias ?? 'text_signer_table';
  @override
  String get actualTableName => 'text_signer_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TextSignerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_text_guid')) {
      context.handle(
          _profileTextGuidMeta,
          profileTextGuid.isAcceptableOrUnknown(
              data['profile_text_guid']!, _profileTextGuidMeta));
    } else if (isInserting) {
      context.missing(_profileTextGuidMeta);
    }
    if (data.containsKey('profile_signer_guid')) {
      context.handle(
          _profileSignerGuidMeta,
          profileSignerGuid.isAcceptableOrUnknown(
              data['profile_signer_guid']!, _profileSignerGuidMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileTextGuid, profileSignerGuid};
  @override
  TextSignerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TextSignerTableData(
      profileTextGuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_text_guid'])!,
      profileSignerGuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_signer_guid']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
    );
  }

  @override
  $TextSignerTableTable createAlias(String alias) {
    return $TextSignerTableTable(attachedDatabase, alias);
  }
}

class UserInfoTableCompanion extends UpdateCompanion<UserInfo> {
  final Value<int?> userId;
  final Value<String?> userName;
  final Value<bool?> isRememberPassword;
  final Value<String?> token;
  final Value<int?> unitId;
  final Value<String?> unitCode;
  final Value<String?> phone;
  final Value<String?> fullName;
  final Value<String?> userNameShow;
  final Value<String?> email;
  final Value<bool?> isActive;
  final Value<String?> unitName;
  final Value<String?> objectGuid;
  final Value<DateTime?> timeAdd;
  const UserInfoTableCompanion({
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.isRememberPassword = const Value.absent(),
    this.token = const Value.absent(),
    this.unitId = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.phone = const Value.absent(),
    this.fullName = const Value.absent(),
    this.userNameShow = const Value.absent(),
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.unitName = const Value.absent(),
    this.objectGuid = const Value.absent(),
    this.timeAdd = const Value.absent(),
  });
  UserInfoTableCompanion.insert({
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.isRememberPassword = const Value.absent(),
    this.token = const Value.absent(),
    this.unitId = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.phone = const Value.absent(),
    this.fullName = const Value.absent(),
    this.userNameShow = const Value.absent(),
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.unitName = const Value.absent(),
    this.objectGuid = const Value.absent(),
    this.timeAdd = const Value.absent(),
  });
  static Insertable<UserInfo> custom({
    Expression<int>? userId,
    Expression<String>? userName,
    Expression<bool>? isRememberPassword,
    Expression<String>? token,
    Expression<int>? unitId,
    Expression<String>? unitCode,
    Expression<String>? phone,
    Expression<String>? fullName,
    Expression<String>? userNameShow,
    Expression<String>? email,
    Expression<bool>? isActive,
    Expression<String>? unitName,
    Expression<String>? objectGuid,
    Expression<DateTime>? timeAdd,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (isRememberPassword != null)
        'is_remember_password': isRememberPassword,
      if (token != null) 'token': token,
      if (unitId != null) 'unit_id': unitId,
      if (unitCode != null) 'unit_code': unitCode,
      if (phone != null) 'phone': phone,
      if (fullName != null) 'full_name': fullName,
      if (userNameShow != null) 'user_name_show': userNameShow,
      if (email != null) 'email': email,
      if (isActive != null) 'is_active': isActive,
      if (unitName != null) 'unit_name': unitName,
      if (objectGuid != null) 'object_guid': objectGuid,
      if (timeAdd != null) 'time_add': timeAdd,
    });
  }

  UserInfoTableCompanion copyWith(
      {Value<int?>? userId,
      Value<String?>? userName,
      Value<bool?>? isRememberPassword,
      Value<String?>? token,
      Value<int?>? unitId,
      Value<String?>? unitCode,
      Value<String?>? phone,
      Value<String?>? fullName,
      Value<String?>? userNameShow,
      Value<String?>? email,
      Value<bool?>? isActive,
      Value<String?>? unitName,
      Value<String?>? objectGuid,
      Value<DateTime?>? timeAdd}) {
    return UserInfoTableCompanion(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      isRememberPassword: isRememberPassword ?? this.isRememberPassword,
      token: token ?? this.token,
      unitId: unitId ?? this.unitId,
      unitCode: unitCode ?? this.unitCode,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      userNameShow: userNameShow ?? this.userNameShow,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      unitName: unitName ?? this.unitName,
      objectGuid: objectGuid ?? this.objectGuid,
      timeAdd: timeAdd ?? this.timeAdd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (isRememberPassword.present) {
      map['is_remember_password'] = Variable<bool>(isRememberPassword.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (unitCode.present) {
      map['unit_code'] = Variable<String>(unitCode.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (userNameShow.present) {
      map['user_name_show'] = Variable<String>(userNameShow.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (objectGuid.present) {
      map['object_guid'] = Variable<String>(objectGuid.value);
    }
    if (timeAdd.present) {
      map['time_add'] = Variable<DateTime>(timeAdd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserInfoTableCompanion(')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('isRememberPassword: $isRememberPassword, ')
          ..write('token: $token, ')
          ..write('unitId: $unitId, ')
          ..write('unitCode: $unitCode, ')
          ..write('phone: $phone, ')
          ..write('fullName: $fullName, ')
          ..write('userNameShow: $userNameShow, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('unitName: $unitName, ')
          ..write('objectGuid: $objectGuid, ')
          ..write('timeAdd: $timeAdd')
          ..write(')'))
        .toString();
  }
}

class $UserInfoTableTable extends UserInfoTable
    with TableInfo<$UserInfoTableTable, UserInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isRememberPasswordMeta =
      const VerificationMeta('isRememberPassword');
  @override
  late final GeneratedColumn<bool> isRememberPassword =
      GeneratedColumn<bool>('is_remember_password', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_remember_password" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitCodeMeta =
      const VerificationMeta('unitCode');
  @override
  late final GeneratedColumn<String> unitCode = GeneratedColumn<String>(
      'unit_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userNameShowMeta =
      const VerificationMeta('userNameShow');
  @override
  late final GeneratedColumn<String> userNameShow = GeneratedColumn<String>(
      'user_name_show', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive =
      GeneratedColumn<bool>('is_active', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _unitNameMeta =
      const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _objectGuidMeta =
      const VerificationMeta('objectGuid');
  @override
  late final GeneratedColumn<String> objectGuid = GeneratedColumn<String>(
      'object_guid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeAddMeta =
      const VerificationMeta('timeAdd');
  @override
  late final GeneratedColumn<DateTime> timeAdd = GeneratedColumn<DateTime>(
      'time_add', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        userName,
        isRememberPassword,
        token,
        unitId,
        unitCode,
        phone,
        fullName,
        userNameShow,
        email,
        isActive,
        unitName,
        objectGuid,
        timeAdd
      ];
  @override
  String get aliasedName => _alias ?? 'user_info_table';
  @override
  String get actualTableName => 'user_info_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    }
    if (data.containsKey('is_remember_password')) {
      context.handle(
          _isRememberPasswordMeta,
          isRememberPassword.isAcceptableOrUnknown(
              data['is_remember_password']!, _isRememberPasswordMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('unit_code')) {
      context.handle(_unitCodeMeta,
          unitCode.isAcceptableOrUnknown(data['unit_code']!, _unitCodeMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    }
    if (data.containsKey('user_name_show')) {
      context.handle(
          _userNameShowMeta,
          userNameShow.isAcceptableOrUnknown(
              data['user_name_show']!, _userNameShowMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    }
    if (data.containsKey('object_guid')) {
      context.handle(
          _objectGuidMeta,
          objectGuid.isAcceptableOrUnknown(
              data['object_guid']!, _objectGuidMeta));
    }
    if (data.containsKey('time_add')) {
      context.handle(_timeAddMeta,
          timeAdd.isAcceptableOrUnknown(data['time_add']!, _timeAddMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserInfo(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name']),
      isRememberPassword: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_remember_password']),
      token: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}token']),
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id']),
      unitCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_code']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name']),
      userNameShow: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name_show']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active']),
      objectGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}object_guid']),
      unitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name']),
    );
  }

  @override
  $UserInfoTableTable createAlias(String alias) {
    return $UserInfoTableTable(attachedDatabase, alias);
  }
}

class CreatorTableCompanion extends UpdateCompanion<Creator> {
  final Value<String?> contractGuid;
  final Value<int> id;
  final Value<String?> userName;
  final Value<String?> fullName;
  const CreatorTableCompanion({
    this.contractGuid = const Value.absent(),
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.fullName = const Value.absent(),
  });
  CreatorTableCompanion.insert({
    this.contractGuid = const Value.absent(),
    required int id,
    this.userName = const Value.absent(),
    this.fullName = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Creator> custom({
    Expression<String>? contractGuid,
    Expression<int>? id,
    Expression<String>? userName,
    Expression<String>? fullName,
  }) {
    return RawValuesInsertable({
      if (contractGuid != null) 'contract_guid': contractGuid,
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (fullName != null) 'full_name': fullName,
    });
  }

  CreatorTableCompanion copyWith(
      {Value<String?>? contractGuid,
      Value<int>? id,
      Value<String?>? userName,
      Value<String?>? fullName}) {
    return CreatorTableCompanion(
      contractGuid: contractGuid ?? this.contractGuid,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contractGuid.present) {
      map['contract_guid'] = Variable<String>(contractGuid.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreatorTableCompanion(')
          ..write('contractGuid: $contractGuid, ')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('fullName: $fullName')
          ..write(')'))
        .toString();
  }
}

class $CreatorTableTable extends CreatorTable
    with TableInfo<$CreatorTableTable, Creator> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreatorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contractGuidMeta =
      const VerificationMeta('contractGuid');
  @override
  late final GeneratedColumn<String> contractGuid = GeneratedColumn<String>(
      'contract_guid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [contractGuid, id, userName, fullName];
  @override
  String get aliasedName => _alias ?? 'creator_table';
  @override
  String get actualTableName => 'creator_table';
  @override
  VerificationContext validateIntegrity(Insertable<Creator> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('contract_guid')) {
      context.handle(
          _contractGuidMeta,
          contractGuid.isAcceptableOrUnknown(
              data['contract_guid']!, _contractGuidMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contractGuid, id};
  @override
  Creator map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Creator(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name']),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name']),
      contractGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_guid']),
    );
  }

  @override
  $CreatorTableTable createAlias(String alias) {
    return $CreatorTableTable(attachedDatabase, alias);
  }
}

class NotificationTableCompanion extends UpdateCompanion<NotificationEntity> {
  final Value<String> notifyId;
  final Value<String> objectGuid;
  final Value<String?> userId;
  final Value<int> notifyTypeID;
  final Value<String> notifyName;
  final Value<String> textColor;
  final Value<String> title;
  final Value<String> body;
  final Value<int> profileId;
  final Value<int> profileTabId;
  final Value<String> profileGuid;
  final Value<int> status;
  final Value<int> sendCount;
  final Value<String> sendDate;
  final Value<String> lastUpdate;
  final Value<String> createDate;
  final Value<int> totalUnread;
  const NotificationTableCompanion({
    this.notifyId = const Value.absent(),
    this.objectGuid = const Value.absent(),
    this.userId = const Value.absent(),
    this.notifyTypeID = const Value.absent(),
    this.notifyName = const Value.absent(),
    this.textColor = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.profileId = const Value.absent(),
    this.profileTabId = const Value.absent(),
    this.profileGuid = const Value.absent(),
    this.status = const Value.absent(),
    this.sendCount = const Value.absent(),
    this.sendDate = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.createDate = const Value.absent(),
    this.totalUnread = const Value.absent(),
  });
  NotificationTableCompanion.insert({
    required String notifyId,
    required String objectGuid,
    this.userId = const Value.absent(),
    required int notifyTypeID,
    required String notifyName,
    required String textColor,
    required String title,
    required String body,
    required int profileId,
    required int profileTabId,
    required String profileGuid,
    required int status,
    required int sendCount,
    required String sendDate,
    required String lastUpdate,
    required String createDate,
    required int totalUnread,
  })  : notifyId = Value(notifyId),
        objectGuid = Value(objectGuid),
        notifyTypeID = Value(notifyTypeID),
        notifyName = Value(notifyName),
        textColor = Value(textColor),
        title = Value(title),
        body = Value(body),
        profileId = Value(profileId),
        profileTabId = Value(profileTabId),
        profileGuid = Value(profileGuid),
        status = Value(status),
        sendCount = Value(sendCount),
        sendDate = Value(sendDate),
        lastUpdate = Value(lastUpdate),
        createDate = Value(createDate),
        totalUnread = Value(totalUnread);
  static Insertable<NotificationEntity> custom({
    Expression<String>? notifyId,
    Expression<String>? objectGuid,
    Expression<String>? userId,
    Expression<int>? notifyTypeID,
    Expression<String>? notifyName,
    Expression<String>? textColor,
    Expression<String>? title,
    Expression<String>? body,
    Expression<int>? profileId,
    Expression<int>? profileTabId,
    Expression<String>? profileGuid,
    Expression<int>? status,
    Expression<int>? sendCount,
    Expression<String>? sendDate,
    Expression<String>? lastUpdate,
    Expression<String>? createDate,
    Expression<int>? totalUnread,
  }) {
    return RawValuesInsertable({
      if (notifyId != null) 'notify_id': notifyId,
      if (objectGuid != null) 'object_guid': objectGuid,
      if (userId != null) 'user_id': userId,
      if (notifyTypeID != null) 'notify_type_i_d': notifyTypeID,
      if (notifyName != null) 'notify_name': notifyName,
      if (textColor != null) 'text_color': textColor,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (profileId != null) 'profile_id': profileId,
      if (profileTabId != null) 'profile_tab_id': profileTabId,
      if (profileGuid != null) 'profile_guid': profileGuid,
      if (status != null) 'status': status,
      if (sendCount != null) 'send_count': sendCount,
      if (sendDate != null) 'send_date': sendDate,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (createDate != null) 'create_date': createDate,
      if (totalUnread != null) 'total_unread': totalUnread,
    });
  }

  NotificationTableCompanion copyWith(
      {Value<String>? notifyId,
      Value<String>? objectGuid,
      Value<String?>? userId,
      Value<int>? notifyTypeID,
      Value<String>? notifyName,
      Value<String>? textColor,
      Value<String>? title,
      Value<String>? body,
      Value<int>? profileId,
      Value<int>? profileTabId,
      Value<String>? profileGuid,
      Value<int>? status,
      Value<int>? sendCount,
      Value<String>? sendDate,
      Value<String>? lastUpdate,
      Value<String>? createDate,
      Value<int>? totalUnread}) {
    return NotificationTableCompanion(
      notifyId: notifyId ?? this.notifyId,
      objectGuid: objectGuid ?? this.objectGuid,
      userId: userId ?? this.userId,
      notifyTypeID: notifyTypeID ?? this.notifyTypeID,
      notifyName: notifyName ?? this.notifyName,
      textColor: textColor ?? this.textColor,
      title: title ?? this.title,
      body: body ?? this.body,
      profileId: profileId ?? this.profileId,
      profileTabId: profileTabId ?? this.profileTabId,
      profileGuid: profileGuid ?? this.profileGuid,
      status: status ?? this.status,
      sendCount: sendCount ?? this.sendCount,
      sendDate: sendDate ?? this.sendDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      createDate: createDate ?? this.createDate,
      totalUnread: totalUnread ?? this.totalUnread,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (notifyId.present) {
      map['notify_id'] = Variable<String>(notifyId.value);
    }
    if (objectGuid.present) {
      map['object_guid'] = Variable<String>(objectGuid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (notifyTypeID.present) {
      map['notify_type_i_d'] = Variable<int>(notifyTypeID.value);
    }
    if (notifyName.present) {
      map['notify_name'] = Variable<String>(notifyName.value);
    }
    if (textColor.present) {
      map['text_color'] = Variable<String>(textColor.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (profileTabId.present) {
      map['profile_tab_id'] = Variable<int>(profileTabId.value);
    }
    if (profileGuid.present) {
      map['profile_guid'] = Variable<String>(profileGuid.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (sendCount.present) {
      map['send_count'] = Variable<int>(sendCount.value);
    }
    if (sendDate.present) {
      map['send_date'] = Variable<String>(sendDate.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<String>(lastUpdate.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<String>(createDate.value);
    }
    if (totalUnread.present) {
      map['total_unread'] = Variable<int>(totalUnread.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationTableCompanion(')
          ..write('notifyId: $notifyId, ')
          ..write('objectGuid: $objectGuid, ')
          ..write('userId: $userId, ')
          ..write('notifyTypeID: $notifyTypeID, ')
          ..write('notifyName: $notifyName, ')
          ..write('textColor: $textColor, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('profileId: $profileId, ')
          ..write('profileTabId: $profileTabId, ')
          ..write('profileGuid: $profileGuid, ')
          ..write('status: $status, ')
          ..write('sendCount: $sendCount, ')
          ..write('sendDate: $sendDate, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('createDate: $createDate, ')
          ..write('totalUnread: $totalUnread')
          ..write(')'))
        .toString();
  }
}

class $NotificationTableTable extends NotificationTable
    with TableInfo<$NotificationTableTable, NotificationEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _notifyIdMeta =
      const VerificationMeta('notifyId');
  @override
  late final GeneratedColumn<String> notifyId = GeneratedColumn<String>(
      'notify_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _objectGuidMeta =
      const VerificationMeta('objectGuid');
  @override
  late final GeneratedColumn<String> objectGuid = GeneratedColumn<String>(
      'object_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notifyTypeIDMeta =
      const VerificationMeta('notifyTypeID');
  @override
  late final GeneratedColumn<int> notifyTypeID = GeneratedColumn<int>(
      'notify_type_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notifyNameMeta =
      const VerificationMeta('notifyName');
  @override
  late final GeneratedColumn<String> notifyName = GeneratedColumn<String>(
      'notify_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textColorMeta =
      const VerificationMeta('textColor');
  @override
  late final GeneratedColumn<String> textColor = GeneratedColumn<String>(
      'text_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _profileTabIdMeta =
      const VerificationMeta('profileTabId');
  @override
  late final GeneratedColumn<int> profileTabId = GeneratedColumn<int>(
      'profile_tab_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _profileGuidMeta =
      const VerificationMeta('profileGuid');
  @override
  late final GeneratedColumn<String> profileGuid = GeneratedColumn<String>(
      'profile_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sendCountMeta =
      const VerificationMeta('sendCount');
  @override
  late final GeneratedColumn<int> sendCount = GeneratedColumn<int>(
      'send_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sendDateMeta =
      const VerificationMeta('sendDate');
  @override
  late final GeneratedColumn<String> sendDate = GeneratedColumn<String>(
      'send_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<String> lastUpdate = GeneratedColumn<String>(
      'last_update', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createDateMeta =
      const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<String> createDate = GeneratedColumn<String>(
      'create_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalUnreadMeta =
      const VerificationMeta('totalUnread');
  @override
  late final GeneratedColumn<int> totalUnread = GeneratedColumn<int>(
      'total_unread', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        notifyId,
        objectGuid,
        userId,
        notifyTypeID,
        notifyName,
        textColor,
        title,
        body,
        profileId,
        profileTabId,
        profileGuid,
        status,
        sendCount,
        sendDate,
        lastUpdate,
        createDate,
        totalUnread
      ];
  @override
  String get aliasedName => _alias ?? 'notification_table';
  @override
  String get actualTableName => 'notification_table';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('notify_id')) {
      context.handle(_notifyIdMeta,
          notifyId.isAcceptableOrUnknown(data['notify_id']!, _notifyIdMeta));
    } else if (isInserting) {
      context.missing(_notifyIdMeta);
    }
    if (data.containsKey('object_guid')) {
      context.handle(
          _objectGuidMeta,
          objectGuid.isAcceptableOrUnknown(
              data['object_guid']!, _objectGuidMeta));
    } else if (isInserting) {
      context.missing(_objectGuidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('notify_type_i_d')) {
      context.handle(
          _notifyTypeIDMeta,
          notifyTypeID.isAcceptableOrUnknown(
              data['notify_type_i_d']!, _notifyTypeIDMeta));
    } else if (isInserting) {
      context.missing(_notifyTypeIDMeta);
    }
    if (data.containsKey('notify_name')) {
      context.handle(
          _notifyNameMeta,
          notifyName.isAcceptableOrUnknown(
              data['notify_name']!, _notifyNameMeta));
    } else if (isInserting) {
      context.missing(_notifyNameMeta);
    }
    if (data.containsKey('text_color')) {
      context.handle(_textColorMeta,
          textColor.isAcceptableOrUnknown(data['text_color']!, _textColorMeta));
    } else if (isInserting) {
      context.missing(_textColorMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('profile_tab_id')) {
      context.handle(
          _profileTabIdMeta,
          profileTabId.isAcceptableOrUnknown(
              data['profile_tab_id']!, _profileTabIdMeta));
    } else if (isInserting) {
      context.missing(_profileTabIdMeta);
    }
    if (data.containsKey('profile_guid')) {
      context.handle(
          _profileGuidMeta,
          profileGuid.isAcceptableOrUnknown(
              data['profile_guid']!, _profileGuidMeta));
    } else if (isInserting) {
      context.missing(_profileGuidMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('send_count')) {
      context.handle(_sendCountMeta,
          sendCount.isAcceptableOrUnknown(data['send_count']!, _sendCountMeta));
    } else if (isInserting) {
      context.missing(_sendCountMeta);
    }
    if (data.containsKey('send_date')) {
      context.handle(_sendDateMeta,
          sendDate.isAcceptableOrUnknown(data['send_date']!, _sendDateMeta));
    } else if (isInserting) {
      context.missing(_sendDateMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    if (data.containsKey('total_unread')) {
      context.handle(
          _totalUnreadMeta,
          totalUnread.isAcceptableOrUnknown(
              data['total_unread']!, _totalUnreadMeta));
    } else if (isInserting) {
      context.missing(_totalUnreadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {notifyId};
  @override
  NotificationEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationEntity(
      notifyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notify_id'])!,
      objectGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}object_guid'])!,
      notifyTypeID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notify_type_i_d'])!,
      notifyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notify_name'])!,
      textColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_color'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_id'])!,
      profileGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_guid'])!,
      profileTabId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_tab_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      sendCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_count'])!,
      sendDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}send_date'])!,
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_update'])!,
      createDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_date'])!,
      totalUnread: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_unread'])!,
    );
  }

  @override
  $NotificationTableTable createAlias(String alias) {
    return $NotificationTableTable(attachedDatabase, alias);
  }
}

class ButtonShowTableCompanion extends UpdateCompanion<ButtonShow> {
  final Value<String?> contractGuid;
  final Value<bool> copyPageSign;
  final Value<bool> edit;
  final Value<bool> restore;
  final Value<bool> sign;
  final Value<bool> download;
  final Value<bool> viewHistory;
  final Value<bool> cancelTranferSign;
  const ButtonShowTableCompanion({
    this.contractGuid = const Value.absent(),
    this.copyPageSign = const Value.absent(),
    this.edit = const Value.absent(),
    this.restore = const Value.absent(),
    this.sign = const Value.absent(),
    this.download = const Value.absent(),
    this.viewHistory = const Value.absent(),
    this.cancelTranferSign = const Value.absent(),
  });
  ButtonShowTableCompanion.insert({
    this.contractGuid = const Value.absent(),
    required bool copyPageSign,
    required bool edit,
    required bool restore,
    required bool sign,
    required bool download,
    required bool viewHistory,
    required bool cancelTranferSign,
  })  : copyPageSign = Value(copyPageSign),
        edit = Value(edit),
        restore = Value(restore),
        sign = Value(sign),
        download = Value(download),
        viewHistory = Value(viewHistory),
        cancelTranferSign = Value(cancelTranferSign);
  static Insertable<ButtonShow> custom({
    Expression<String>? contractGuid,
    Expression<bool>? copyPageSign,
    Expression<bool>? edit,
    Expression<bool>? restore,
    Expression<bool>? sign,
    Expression<bool>? download,
    Expression<bool>? viewHistory,
    Expression<bool>? cancelTranferSign,
  }) {
    return RawValuesInsertable({
      if (contractGuid != null) 'contract_guid': contractGuid,
      if (copyPageSign != null) 'copy_page_sign': copyPageSign,
      if (edit != null) 'edit': edit,
      if (restore != null) 'restore': restore,
      if (sign != null) 'sign': sign,
      if (download != null) 'download': download,
      if (viewHistory != null) 'view_history': viewHistory,
      if (cancelTranferSign != null) 'cancel_tranfer_sign': cancelTranferSign,
    });
  }

  ButtonShowTableCompanion copyWith(
      {Value<String?>? contractGuid,
      Value<bool>? copyPageSign,
      Value<bool>? edit,
      Value<bool>? restore,
      Value<bool>? sign,
      Value<bool>? download,
      Value<bool>? viewHistory,
      Value<bool>? cancelTranferSign}) {
    return ButtonShowTableCompanion(
      contractGuid: contractGuid ?? this.contractGuid,
      copyPageSign: copyPageSign ?? this.copyPageSign,
      edit: edit ?? this.edit,
      restore: restore ?? this.restore,
      sign: sign ?? this.sign,
      download: download ?? this.download,
      viewHistory: viewHistory ?? this.viewHistory,
      cancelTranferSign: cancelTranferSign ?? this.cancelTranferSign,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contractGuid.present) {
      map['contract_guid'] = Variable<String>(contractGuid.value);
    }
    if (copyPageSign.present) {
      map['copy_page_sign'] = Variable<bool>(copyPageSign.value);
    }
    if (edit.present) {
      map['edit'] = Variable<bool>(edit.value);
    }
    if (restore.present) {
      map['restore'] = Variable<bool>(restore.value);
    }
    if (sign.present) {
      map['sign'] = Variable<bool>(sign.value);
    }
    if (download.present) {
      map['download'] = Variable<bool>(download.value);
    }
    if (viewHistory.present) {
      map['view_history'] = Variable<bool>(viewHistory.value);
    }
    if (cancelTranferSign.present) {
      map['cancel_tranfer_sign'] = Variable<bool>(cancelTranferSign.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ButtonShowTableCompanion(')
          ..write('contractGuid: $contractGuid, ')
          ..write('copyPageSign: $copyPageSign, ')
          ..write('edit: $edit, ')
          ..write('restore: $restore, ')
          ..write('sign: $sign, ')
          ..write('download: $download, ')
          ..write('viewHistory: $viewHistory, ')
          ..write('cancelTranferSign: $cancelTranferSign')
          ..write(')'))
        .toString();
  }
}

class $ButtonShowTableTable extends ButtonShowTable
    with TableInfo<$ButtonShowTableTable, ButtonShow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ButtonShowTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contractGuidMeta =
      const VerificationMeta('contractGuid');
  @override
  late final GeneratedColumn<String> contractGuid = GeneratedColumn<String>(
      'contract_guid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _copyPageSignMeta =
      const VerificationMeta('copyPageSign');
  @override
  late final GeneratedColumn<bool> copyPageSign =
      GeneratedColumn<bool>('copy_page_sign', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("copy_page_sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _editMeta = const VerificationMeta('edit');
  @override
  late final GeneratedColumn<bool> edit =
      GeneratedColumn<bool>('edit', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("edit" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _restoreMeta =
      const VerificationMeta('restore');
  @override
  late final GeneratedColumn<bool> restore =
      GeneratedColumn<bool>('restore', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("restore" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _signMeta = const VerificationMeta('sign');
  @override
  late final GeneratedColumn<bool> sign =
      GeneratedColumn<bool>('sign', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _downloadMeta =
      const VerificationMeta('download');
  @override
  late final GeneratedColumn<bool> download =
      GeneratedColumn<bool>('download', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("download" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _viewHistoryMeta =
      const VerificationMeta('viewHistory');
  @override
  late final GeneratedColumn<bool> viewHistory =
      GeneratedColumn<bool>('view_history', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("view_history" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _cancelTranferSignMeta =
      const VerificationMeta('cancelTranferSign');
  @override
  late final GeneratedColumn<bool> cancelTranferSign =
      GeneratedColumn<bool>('cancel_tranfer_sign', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("cancel_tranfer_sign" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [
        contractGuid,
        copyPageSign,
        edit,
        restore,
        sign,
        download,
        viewHistory,
        cancelTranferSign
      ];
  @override
  String get aliasedName => _alias ?? 'button_show_table';
  @override
  String get actualTableName => 'button_show_table';
  @override
  VerificationContext validateIntegrity(Insertable<ButtonShow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('contract_guid')) {
      context.handle(
          _contractGuidMeta,
          contractGuid.isAcceptableOrUnknown(
              data['contract_guid']!, _contractGuidMeta));
    }
    if (data.containsKey('copy_page_sign')) {
      context.handle(
          _copyPageSignMeta,
          copyPageSign.isAcceptableOrUnknown(
              data['copy_page_sign']!, _copyPageSignMeta));
    } else if (isInserting) {
      context.missing(_copyPageSignMeta);
    }
    if (data.containsKey('edit')) {
      context.handle(
          _editMeta, edit.isAcceptableOrUnknown(data['edit']!, _editMeta));
    } else if (isInserting) {
      context.missing(_editMeta);
    }
    if (data.containsKey('restore')) {
      context.handle(_restoreMeta,
          restore.isAcceptableOrUnknown(data['restore']!, _restoreMeta));
    } else if (isInserting) {
      context.missing(_restoreMeta);
    }
    if (data.containsKey('sign')) {
      context.handle(
          _signMeta, sign.isAcceptableOrUnknown(data['sign']!, _signMeta));
    } else if (isInserting) {
      context.missing(_signMeta);
    }
    if (data.containsKey('download')) {
      context.handle(_downloadMeta,
          download.isAcceptableOrUnknown(data['download']!, _downloadMeta));
    } else if (isInserting) {
      context.missing(_downloadMeta);
    }
    if (data.containsKey('view_history')) {
      context.handle(
          _viewHistoryMeta,
          viewHistory.isAcceptableOrUnknown(
              data['view_history']!, _viewHistoryMeta));
    } else if (isInserting) {
      context.missing(_viewHistoryMeta);
    }
    if (data.containsKey('cancel_tranfer_sign')) {
      context.handle(
          _cancelTranferSignMeta,
          cancelTranferSign.isAcceptableOrUnknown(
              data['cancel_tranfer_sign']!, _cancelTranferSignMeta));
    } else if (isInserting) {
      context.missing(_cancelTranferSignMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contractGuid};
  @override
  ButtonShow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ButtonShow(
      copyPageSign: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}copy_page_sign'])!,
      edit: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}edit'])!,
      restore: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}restore'])!,
      sign: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sign'])!,
      download: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}download'])!,
      viewHistory: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}view_history'])!,
      cancelTranferSign: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}cancel_tranfer_sign'])!,
      contractGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_guid']),
    );
  }

  @override
  $ButtonShowTableTable createAlias(String alias) {
    return $ButtonShowTableTable(attachedDatabase, alias);
  }
}

class LogInfoTableCompanion extends UpdateCompanion<LogInfo> {
  final Value<String?> timeLog;
  final Value<String?> uuid;
  final Value<String?> logTag;
  final Value<String?> logContent;
  const LogInfoTableCompanion({
    this.timeLog = const Value.absent(),
    this.uuid = const Value.absent(),
    this.logTag = const Value.absent(),
    this.logContent = const Value.absent(),
  });
  LogInfoTableCompanion.insert({
    this.timeLog = const Value.absent(),
    this.uuid = const Value.absent(),
    this.logTag = const Value.absent(),
    this.logContent = const Value.absent(),
  });
  static Insertable<LogInfo> custom({
    Expression<String>? timeLog,
    Expression<String>? uuid,
    Expression<String>? logTag,
    Expression<String>? logContent,
  }) {
    return RawValuesInsertable({
      if (timeLog != null) 'time_log': timeLog,
      if (uuid != null) 'uuid': uuid,
      if (logTag != null) 'log_tag': logTag,
      if (logContent != null) 'log_content': logContent,
    });
  }

  LogInfoTableCompanion copyWith(
      {Value<String?>? timeLog,
      Value<String?>? uuid,
      Value<String?>? logTag,
      Value<String?>? logContent}) {
    return LogInfoTableCompanion(
      timeLog: timeLog ?? this.timeLog,
      uuid: uuid ?? this.uuid,
      logTag: logTag ?? this.logTag,
      logContent: logContent ?? this.logContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (timeLog.present) {
      map['time_log'] = Variable<String>(timeLog.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (logTag.present) {
      map['log_tag'] = Variable<String>(logTag.value);
    }
    if (logContent.present) {
      map['log_content'] = Variable<String>(logContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogInfoTableCompanion(')
          ..write('timeLog: $timeLog, ')
          ..write('uuid: $uuid, ')
          ..write('logTag: $logTag, ')
          ..write('logContent: $logContent')
          ..write(')'))
        .toString();
  }
}

class $LogInfoTableTable extends LogInfoTable
    with TableInfo<$LogInfoTableTable, LogInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeLogMeta =
      const VerificationMeta('timeLog');
  @override
  late final GeneratedColumn<String> timeLog = GeneratedColumn<String>(
      'time_log', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logTagMeta = const VerificationMeta('logTag');
  @override
  late final GeneratedColumn<String> logTag = GeneratedColumn<String>(
      'log_tag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logContentMeta =
      const VerificationMeta('logContent');
  @override
  late final GeneratedColumn<String> logContent = GeneratedColumn<String>(
      'log_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [timeLog, uuid, logTag, logContent];
  @override
  String get aliasedName => _alias ?? 'log_info';
  @override
  String get actualTableName => 'log_info';
  @override
  VerificationContext validateIntegrity(Insertable<LogInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time_log')) {
      context.handle(_timeLogMeta,
          timeLog.isAcceptableOrUnknown(data['time_log']!, _timeLogMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('log_tag')) {
      context.handle(_logTagMeta,
          logTag.isAcceptableOrUnknown(data['log_tag']!, _logTagMeta));
    }
    if (data.containsKey('log_content')) {
      context.handle(
          _logContentMeta,
          logContent.isAcceptableOrUnknown(
              data['log_content']!, _logContentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LogInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogInfo(
      timeLog: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_log']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid']),
      logTag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}log_tag']),
      logContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}log_content']),
    );
  }

  @override
  $LogInfoTableTable createAlias(String alias) {
    return $LogInfoTableTable(attachedDatabase, alias);
  }
}

abstract class _$EContractDb extends GeneratedDatabase {
  _$EContractDb(QueryExecutor e) : super(e);
  late final $ContractDocsFromTableTable contractDocsFromTable =
      $ContractDocsFromTableTable(this);
  late final $ContractDocsToTableTable contractDocsToTable =
      $ContractDocsToTableTable(this);
  late final $SignerTableTable signerTable = $SignerTableTable(this);
  late final $TextDetailTableTable textDetailTable =
      $TextDetailTableTable(this);
  late final $TextSignerTableTable textSignerTable =
      $TextSignerTableTable(this);
  late final $UserInfoTableTable userInfoTable = $UserInfoTableTable(this);
  late final $CreatorTableTable creatorTable = $CreatorTableTable(this);
  late final $NotificationTableTable notificationTable =
      $NotificationTableTable(this);
  late final $ButtonShowTableTable buttonShowTable =
      $ButtonShowTableTable(this);
  late final $LogInfoTableTable logInfoTable = $LogInfoTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contractDocsFromTable,
        contractDocsToTable,
        signerTable,
        textDetailTable,
        textSignerTable,
        userInfoTable,
        creatorTable,
        notificationTable,
        buttonShowTable,
        logInfoTable
      ];
}
