import 'package:drift/drift.dart';
import 'package:e_contract/data/entity/log_info.dart';

@UseRowClass(LogInfo)
class LogInfoTable extends Table{
  @override
  String get tableName => 'log_info';

  TextColumn get timeLog=> text().nullable()();

  TextColumn get uuid => text().nullable()();

  TextColumn get logTag => text().nullable()();

  TextColumn get logContent => text().nullable()();

}