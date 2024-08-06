import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/notification_entity.dart';

@UseRowClass(NotificationEntity)
class NotificationTable extends Table {
  @override
  String get tableName => 'notification_table';

  TextColumn get notifyId => text()();

  TextColumn get objectGuid => text()();

  TextColumn get userId => text().nullable()();

  IntColumn get notifyTypeID => integer()();

  TextColumn get notifyName => text()();

  TextColumn get textColor => text()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  IntColumn get profileId => integer()();

  IntColumn get profileTabId => integer()();

  TextColumn get profileGuid => text()();

  IntColumn get status => integer()();

  IntColumn get sendCount => integer()();

  TextColumn get sendDate => text()();

  TextColumn get lastUpdate => text()();

  TextColumn get createDate => text()();

  IntColumn get totalUnread => integer()();

  @override
  Set<Column>? get primaryKey => {notifyId};
}
