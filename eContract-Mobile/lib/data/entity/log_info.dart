import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/data/local_data/data_local_table/log_info_table.dart';
import 'package:equatable/equatable.dart';

class LogInfo extends Equatable implements Insertable<LogInfo>{
  final String? timeLog;
  final String? uuid;
  final String? logTag;
  final String? logContent;
  const LogInfo({
    this.timeLog,
    this.uuid,
    this.logTag,
    this.logContent
  });

  @override
  List<Object?> get props => [logTag, logContent, uuid];

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return LogInfoTableCompanion(
      timeLog: Value(timeLog),
        uuid: Value(uuid),
        logTag: Value(logTag),
    logContent: Value(logContent)).toColumns(nullToAbsent);
  }

}