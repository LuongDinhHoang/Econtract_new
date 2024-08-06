import 'package:drift/drift.dart';

class TextSignerTable extends Table {
  @override
  String get tableName => 'text_signer_table';

  TextColumn get profileTextGuid => text().named('profile_text_guid')();

  TextColumn get profileSignerGuid =>
      text().nullable().named('profile_signer_guid')();

  IntColumn get status => integer().nullable().named('status')();

  @override
  Set<Column>? get primaryKey => {profileTextGuid, profileSignerGuid};
}
