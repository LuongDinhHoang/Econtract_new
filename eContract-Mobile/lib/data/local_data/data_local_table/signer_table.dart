import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/signer.dart';

@UseRowClass(Signer)
class SignerTable extends Table {
  @override
  String get tableName => 'signer_table';

  TextColumn get profileGuid => text().named('profile_guid')();

  TextColumn get textDetailGuid => text().nullable().named('text_detail_guid')();

  TextColumn get objectGuid => text().nullable().named('objectGuid')();

  IntColumn get statusView => integer().named('status_view')();

  IntColumn get statusSign => integer().named('status_sign')();

  TextColumn get signerName => text().nullable().named('sign_name')();

  IntColumn get typeSignId => integer().named('type_sign_id')();

  TextColumn get signDate => text().nullable().named('sign_date')();

  TextColumn get unitCode2 => text().nullable().named('unit_code')();

  @override
  Set<Column>? get primaryKey => {objectGuid};
}