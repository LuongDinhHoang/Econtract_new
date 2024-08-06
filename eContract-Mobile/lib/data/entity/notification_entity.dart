import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';

///Bkav TungDV Notification Model
class NotificationEntity extends Insertable<NotificationEntity> {
  String notifyId;
  String objectGuid;
  String? userId;
  int notifyTypeID;
  String notifyName;
  String textColor;
  String title;
  String body;
  int profileId;
  String profileGuid;
  int profileTabId;
  int status;
  int sendCount;
  String sendDate;
  String lastUpdate;
  String createDate;
  int totalUnread;

  NotificationEntity(
      {required this.notifyId,
      required this.objectGuid,
      required this.notifyTypeID,
      required this.notifyName,
      required this.textColor,
      required this.title,
      required this.body,
      required this.profileId,
      required this.profileGuid,
      required this.profileTabId,
      required this.status,
      required this.sendCount,
      required this.sendDate,
      required this.lastUpdate,
      required this.createDate,
        required this.totalUnread});

  NotificationEntity.fromJson(Map<String, dynamic> json, this.userId)
      : notifyId = "${json['notifyId']}",
        objectGuid = json["objectGuid"],
        notifyTypeID = json["notifyTypeID"],
        notifyName = json['notifyName'],
        textColor = json["textColor"],
        title = json["title"],
        body = json["body"],
        profileId = json['profileId'],
        profileGuid = json['profileGuid'],
        profileTabId = json['profileTabId'],
        status = json["status"],
        sendCount = json["sendCount"],
        sendDate = json["sendDate"] ?? "",
        lastUpdate = json["lastUpdate"] ?? "",
        createDate = json["createDate"],
        totalUnread = json["totalUnread"];

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return NotificationTableCompanion(
      userId: Value(userId),
      objectGuid: Value(objectGuid),
      lastUpdate: Value(lastUpdate),
      title: Value(title),
      status: Value(status),
      body: Value(body),
      createDate: Value(createDate),
      notifyId: Value(notifyId),
      notifyName: Value(notifyName),
      notifyTypeID: Value(notifyTypeID),
      profileId: Value(profileId),
      sendCount: Value(sendCount),
      sendDate: Value(sendDate),
      textColor: Value(textColor),
      profileGuid: Value(profileGuid),
      profileTabId: Value(profileTabId),
      totalUnread: Value(totalUnread)
    ).toColumns(nullToAbsent);
  }
}
