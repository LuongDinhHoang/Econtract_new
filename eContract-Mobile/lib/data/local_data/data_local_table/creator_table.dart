import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/creator.dart';

@UseRowClass(Creator)
class CreatorTable extends Table {
  @override
  String get tableName => 'creator_table';

  TextColumn get contractGuid => text().nullable().named('contract_guid')();

  IntColumn get id => integer().named('id')();

  TextColumn get userName => text().nullable().named('user_name')();

  TextColumn get fullName => text().nullable().named('full_name')();

  @override
  Set<Column>? get primaryKey => {contractGuid, id};
}
