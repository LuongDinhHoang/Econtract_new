import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/contract_doc_from.dart';

@UseRowClass(ContractDocFrom)
class ContractDocsFromTable extends Table {
  @override
  String get tableName => 'contract_docs_from_table';

  TextColumn get userId => text().nullable()();

  TextColumn get contractGuid => text().named('contract_guid')();

  TextColumn get contractName => text().nullable().named('contract_name')();

  TextColumn get lastUpdate => text().nullable().named('last_update')();

  TextColumn get sampleContractName =>
      text().nullable().named('sample_contract_name')();

  IntColumn get contractStatus =>
      integer().nullable().named('contract_status')();

  TextColumn get signDeadline => text().nullable().named('sign_deadline')();

  TextColumn get createdDate => text().nullable().named('created_date')();

  TextColumn get timeRefusingSign =>
      text().nullable().named('time_refusing_sign')();

  TextColumn get timeCancelled => text().nullable().named('time_cancelled')();

  TextColumn get timeCompleted => text().nullable().named('time_completed')();

  BoolColumn get isUseProfileType =>
      boolean().nullable().named("is_use_profile_type")();

  TextColumn get sourceName => text().nullable().named('source_name')();

  IntColumn get sourceId => integer().nullable().named('source_id')();

  TextColumn get code => text().nullable().named('code')();

  TextColumn get profileTypeName =>
      text().nullable().named('profile_type_name')();

  TextColumn get profileTypeGuid =>
      text().nullable().named('profile_type_guid')();

  IntColumn get profileTypeId =>
      integer().nullable().named('profile_type_id')();

  IntColumn get creatorId => integer().nullable().named('creator_id')();

  TextColumn get creatorUserName =>
      text().nullable().named('creator_user_name')();

  TextColumn get creatorFullName =>
      text().nullable().named('creator_full_name')();

  BoolColumn get isShowButtonSign =>
      boolean().nullable().named('show_button_sign')();

  BoolColumn get isShowButtonCopysign =>
      boolean().nullable().named('show_button_copy_sign')();

  BoolColumn get isShowButtonHistory =>
      boolean().nullable().named('show_button_history')();

  TextColumn get typeSign =>
      text().nullable().named('type_sign')();

  @override
  Set<Column>? get primaryKey => {contractGuid};
}
