import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/text_detail.dart';

@UseRowClass(TextDetail)
class TextDetailTable extends Table {
  @override
  String get tableName => 'text_detail_table';

  TextColumn get profileGuid => text().named('profile_guid')();

  TextColumn get objectGuid =>
      text().named('objectGuid')();

  TextColumn get fileName => text().named('status_view')();

  @override
  Set<Column>? get primaryKey => {objectGuid};
}
