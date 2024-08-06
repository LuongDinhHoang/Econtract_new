import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:e_contract/data/entity/button_show.dart';
import 'package:e_contract/data/entity/contract_doc_from.dart';
import 'package:e_contract/data/entity/contract_docs.dart';
import 'package:e_contract/data/entity/creator.dart';
import 'package:e_contract/data/entity/log_info.dart';
import 'package:e_contract/data/entity/notification_entity.dart';
import 'package:e_contract/data/entity/signer.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/local_data/data_local_table/button_show_table.dart';
import 'package:e_contract/data/local_data/data_local_table/contract_docs_from_table.dart';
import 'package:e_contract/data/local_data/data_local_table/contract_docs_to_table.dart';
import 'package:e_contract/data/local_data/data_local_table/creator_table.dart';
import 'package:e_contract/data/local_data/data_local_table/log_info_table.dart';
import 'package:e_contract/data/local_data/data_local_table/notification_table.dart';
import 'package:e_contract/data/local_data/data_local_table/signer_table.dart';
import 'package:e_contract/data/local_data/data_local_table/text_detail_table.dart';
import 'package:e_contract/data/local_data/data_local_table/text_signer_table.dart';
import 'package:e_contract/data/local_data/data_local_table/user_infor_table.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/contract_doc_to.dart';

part 'contract_db.g.dart';

///Bkav ToanTDd: class quản lý database của app, sử dụng thư viện drift
///sử dụng : [flutter packages pub run build_runner build] để gen ra các file cần thiết khi sửa
///sử dụng : [flutter packages pub run build_runner watch] để gen tự động mỗi khi thay đổi code
@DriftDatabase(tables: [
  ContractDocsFromTable,
  ContractDocsToTable,
  SignerTable,
  TextDetailTable,
  TextSignerTable,
  UserInfoTable,
  CreatorTable,
  NotificationTable,
  ButtonShowTable,
  LogInfoTable
])
class EContractDb extends _$EContractDb {
  EContractDb._internal() : super(_openConnection());

  static final EContractDb instance = EContractDb._internal();

  @override
  int get schemaVersion => 10;

  //Các truy vấn liên quan đến user

  ///lấy ra toàn bộ user
  Future<List<UserInfo>> get allUserEntries {
    return (select(userInfoTable)
      ..orderBy([
            (u) => OrderingTerm(expression: u.timeAdd, mode: OrderingMode.desc)
      ])).get();
  }
  ///lấy ra toàn bộ user có token
  Future<List<UserInfo>> get userEntriesHasToken =>
      (select(userInfoTable)..where((tbl) => tbl.token.isNotNull())).get();

  ///Truy vấn user với [userId]
  ///dùng getSingle() để thực thi ngay câu lệnh
  ///dùng watchSingle() để lắng nghe các thay đổi khi csdl thay đổi
  SingleSelectable<UserInfo> singleUser(int userId) {
    return select(userInfoTable)..where((tbl) => tbl.userId.equals(userId));
  }

  ///Xóa user
  Future deleteUser(int userId) {
    // delete the oldest nine tasks
    return (delete(userInfoTable)..where((t) => t.userId.equals(userId))).go();
  }

  ///Thêm mới 1 [user] vào csdl
  ///Nếu đã có trong csdl, thì cập nhật
  Future<void> createOrUpdateUser(UserInfo user) {
    return into(userInfoTable).insertOnConflictUpdate(user);
  }

  //Bkav ToanTDd: các truy vấn liên quan đến nhà
  //TODO nghiên cứu xem có cần chia nhỏ ra thành DAO không?

  ///Truy vấn lấy danh sách ho so với người dùng có [userId]
  ///dùng get() để thực hiện ngay truy vấn
  ///dùng watch() để lắng nghe các thay đổi khi csdl thay đổi
  MultiSelectable<ContractDocFrom> getContractsFrom(String userId) {
    return select(contractDocsFromTable)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([
        (u) => OrderingTerm(expression: u.lastUpdate, mode: OrderingMode.desc)
      ]);
  }

  SingleSelectable<ContractDocFrom> singleContractFrom(String objectGuid) {
    return select(contractDocsFromTable)
      ..where((tbl) => tbl.contractGuid.equals(objectGuid));
  }

  ///Thêm ho so vào DB, nếu đã có trong DB thì update
  Future<void> insertMultipleContractFromEntries(List<ContractDocFrom> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(contractDocsFromTable, values);
    });
  }

  ///Thêm mới 1 [ContractDocs] vào csdl
  ///Nếu đã có trong csdl, thì cập nhật
  Future<void> createOrUpdateContractFrom(ContractDocFrom contractDocs) {
    return into(contractDocsFromTable).insertOnConflictUpdate(contractDocs);
  }

  ///Xóa contract
  void deleteContractFrom(String objectGuid) async {
    delete(contractDocsFromTable)
      ..where((tbl) => tbl.contractGuid.equals(objectGuid))
      ..go();
  }

  ///Truy vấn lấy danh sách ho so với người dùng có [userId]
  ///dùng get() để thực hiện ngay truy vấn
  ///dùng watch() để lắng nghe các thay đổi khi csdl thay đổi
  MultiSelectable<ContractDocTo> getContractsTo(String userId) {
    return select(contractDocsToTable)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([
            (u) => OrderingTerm(expression: u.lastUpdate, mode: OrderingMode.desc)
      ]);
  }

  SingleSelectable<ContractDocTo> singleContractTo(String objectGuid) {
    return select(contractDocsToTable)
      ..where((tbl) => tbl.contractGuid.equals(objectGuid));
  }

  ///Thêm ho so vào DB, nếu đã có trong DB thì update
  Future<void> insertMultipleContractToEntries(List<ContractDocTo> values) async{
     await batch((batch) {
      batch.insertAllOnConflictUpdate(contractDocsToTable, values);
    });
  }

  ///Thêm mới 1 [ContractDocs] vào csdl
  ///Nếu đã có trong csdl, thì cập nhật
  Future<void> createOrUpdateContractTo(ContractDocTo contractDocs) {
    return into(contractDocsToTable).insertOnConflictUpdate(contractDocs);
  }

  ///Xóa
  void deleteContractTo(String objectGuid) async {
    delete(contractDocsToTable)
      ..where((tbl) => tbl.contractGuid.equals(objectGuid))
      ..go();
  }

  /// creator
  SingleSelectable<Creator> singleCreator(String objectGuid) {
    return select(creatorTable)
      ..where((tbl) => tbl.contractGuid.equals(objectGuid));
  }

  Future<void> createOrUpdateCreator(Creator creator) {
    return into(creatorTable).insertOnConflictUpdate(creator);
  }

  /// button show
  SingleSelectable<ButtonShow> singleButtonShow(String objectGuid) {
    return select(buttonShowTable)
      ..where((tbl) => tbl.contractGuid.equals(objectGuid));
  }

  Future<void> createOrUpdateButtonShow(ButtonShow buttonShow) {
    return into(buttonShowTable).insertOnConflictUpdate(buttonShow);
  }

  /// singer
  ///Truy vấn lấy danh sách doi tuong ky với ho so có [profileId]
  MultiSelectable<Signer> getSigners(String profileId) {
    return select(signerTable)
      ..where((tbl) => tbl.profileGuid.equals(profileId));
  }

  ///Truy vấn lấy danh sách doi tuong ky với text có [textId]
  MultiSelectable<Signer> getSignersInText(String textId) {
    return select(signerTable)
      ..where((tbl) => tbl.textDetailGuid.equals(textId));
  }

  ///Thêm ho so vào DB, nếu đã có trong DB thì update
  Future<void> insertMultipleSignersEntries(List<Signer> values) async {
   await batch((batch) {
      batch.insertAllOnConflictUpdate(signerTable, values);
    });
  }

  /// Text detail
  ///Truy vấn lấy danh sách doi tuong ky với ho so có [profileId]
  MultiSelectable<TextDetail> getTextDetails(String profileId) {
    return select(textDetailTable)
      ..where((tbl) => tbl.profileGuid.equals(profileId));
  }

  ///Thêm ho so vào DB, nếu đã có trong DB thì update
  Future<void> insertMultipleTextDetailEntries(List<TextDetail> values) async {
     await batch((batch) {
      batch.insertAllOnConflictUpdate(textDetailTable, values);
    });
  }

  /// Notification
  /// Truy van lay danh sach notification trong data theo [uId]
  MultiSelectable<NotificationEntity> getNotifications(
      String uId, int offset, int pageSize) {
    return select(notificationTable)
      ..where((tbl) => tbl.userId.equals(uId))
      ..orderBy([
        (u) => OrderingTerm(expression: u.createDate, mode: OrderingMode.desc)
      ])
      ..limit(pageSize, offset: offset);
  }

  ///Thêm danh sach thong bao vào DB, nếu đã có trong DB thì update
  Future<void> insertMultipleNotificationEntries(
      List<NotificationEntity> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(notificationTable, values);
    });
  }

  ///Thêm 1 notify thong bao vào DB, nếu đã có trong DB thì update
  void updateNotificationEntity(NotificationEntity values) {
     into(notificationTable).insertOnConflictUpdate(values);
  }

  ///update a value in a column total unread
  void updateTotalUnReadNumber(String uid, int number) async {
    await (update(notificationTable)..where((t) => t.userId.equals(uid))).write(
      NotificationTableCompanion(
        totalUnread: Value(number),
      ),
    );
  }
  void updateClickNotification(String uid) async {
    await (update(notificationTable)..where((t) => t.objectGuid.equals(uid))).write(
      const NotificationTableCompanion(
        status: Value(4),
      ),
    );
  }
  ///Bkav Nhungltk: them log
  void insertLogApp(LogInfo logInfo){
    into(logInfoTable).insert(logInfo);
  }

  ///xoa log
  void deleteLog() async{
    List<LogInfo> logInfo= await select(logInfoTable).get();
/*    int timeMin=0;
    int timeMax=0;*/

/*    for(int i=0; i< logInfo.length; i++){
      timeMax= Utils.convertTimeToMilliseconds(logInfo[logInfo.length-1].timeLog!);
      timeMin= Utils.convertTimeToMilliseconds(logInfo[0].timeLog!);
    }*/
    //Bkav HoangLD thay đổi lại kịch bản xoá log
    for(int i=0; i< logInfo.length; i++){
      if(logInfo[i].logTag == Logger.subtagLogActivity){
        int timeDelete = Utils.checkTimeDeleteLog(logInfo[0].timeLog!);
        if(timeDelete >= 90){
          deleteLogBy(Logger.subtagLogActivity);
        }
        break;
      }
    }
    for(int i=0; i< logInfo.length; i++){
      if(logInfo[i].logTag == Logger.subtagLogOther){
        int timeDelete = Utils.checkTimeDeleteLog(logInfo[0].timeLog!);
        if(timeDelete > 90){
          deleteLogBy(Logger.subtagLogOther);
        }
        break;
      }
    }
    for(int i=0; i< logInfo.length; i++){
      if(logInfo[i].logTag == Logger.subtagLogError){
        int timeDelete = Utils.checkTimeDeleteLog(logInfo[0].timeLog!);
        if(timeDelete > 180){
          deleteLogBy(Logger.subtagLogError);
        }
        break;
      }
    }

/*    ///7 ngay thi xoa log di
    if(timeMax- timeMin> 604800000){
      delete(logInfoTable);
    }*/
  }
  void deleteLogBy(String deleteBy) async {
    delete(logInfoTable)
      ..where((tbl) => tbl.logTag.equals(deleteBy))
      ..go();
  }
  ///select log
  MultiSelectable<LogInfo> selectLog(String subTag){
    return select(logInfoTable)
      ..where((loInfo)=> loInfo.logTag.equals(subTag))
      ..orderBy([
            (u) => OrderingTerm(expression: u.timeLog, mode: OrderingMode.asc)
      ]);
}

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(userInfoTable, userInfoTable.objectGuid);
        } else if (from < 3) {
          await m.addColumn(notificationTable, notificationTable.profileTabId);
          await m.addColumn(notificationTable, notificationTable.profileGuid);
        } else if (from < 4) {
          await m.addColumn(notificationTable, notificationTable.totalUnread);
        }else if(from < 7){
          m.createTable(logInfoTable);
        }else if(from<9){
          await m.drop(userInfoTable);
          await m.createTable(userInfoTable);
        }else if(from<10){
          await m.drop(contractDocsFromTable);
          await m.createTable(contractDocsFromTable);
          await m.drop(contractDocsToTable);
          await m.createTable(contractDocsToTable);
          await m.drop(notificationTable);
          await m.createTable(notificationTable);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File(join(await getDatabasesPath(), 'contract_db.db'));
    return NativeDatabase(file);
  });
}
