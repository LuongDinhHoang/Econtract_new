import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/button_show.dart';

@UseRowClass(ButtonShow)
class ButtonShowTable extends Table {
  @override
  String get tableName => 'button_show_table';

  TextColumn get contractGuid => text().nullable().named('contract_guid')();

  BoolColumn get copyPageSign => boolean()();

  BoolColumn get edit => boolean()();

  BoolColumn get restore => boolean()();

  BoolColumn get sign => boolean()();

  BoolColumn get download => boolean()();

  BoolColumn get viewHistory => boolean()();

  BoolColumn get cancelTranferSign => boolean()();

  @override
  Set<Column>? get primaryKey => {contractGuid};
}
