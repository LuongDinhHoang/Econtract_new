import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/user_info.dart';

@UseRowClass(UserInfo)
class UserInfoTable extends Table {
  @override
  String get tableName => 'user_info_table';

  IntColumn get userId => integer().nullable().named("user_id")();

  TextColumn get userName => text().nullable()();

  BoolColumn get isRememberPassword => boolean().nullable()();

  TextColumn get token => text().nullable()();

  IntColumn get unitId => integer().nullable().named("unit_id")();

  TextColumn get unitCode => text().nullable()();

  TextColumn get phone => text().nullable()();

  TextColumn get fullName => text().nullable()();

  TextColumn get userNameShow => text().nullable()();

  TextColumn get email => text().nullable()();

  BoolColumn get isActive => boolean().nullable()();

  TextColumn get unitName => text().nullable()();

  TextColumn get objectGuid => text().nullable()();

  DateTimeColumn get timeAdd => dateTime().nullable()();


  @override
  Set<Column>? get primaryKey => {userId};
}
