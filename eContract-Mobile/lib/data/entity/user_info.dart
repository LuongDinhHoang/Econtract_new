import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:equatable/equatable.dart';

class UserInfo extends Equatable implements Insertable<UserInfo> {
  final int? userId;
  final String? userName;
  final bool? isRememberPassword;
  final String? token;
  final int? unitId;
  final String? unitCode;
  final String? phone;
  final String? fullName;
  final String? userNameShow;
  final String? email;
  final bool? isActive;
  final String? unitName;
  final String? objectGuid;
  final DateTime? addTime;
  final String? refreshToken;

  const UserInfo( {
      this.userId,
      this.userName,
      this.isRememberPassword,
      this.token,
      this.unitId,
      this.unitCode,
      this.phone,
      this.fullName,
      this.userNameShow,
      this.email,
      this.isActive,
      this.objectGuid,
      this.unitName,
      this.addTime,
      this.refreshToken});

  UserInfo.fromJson(Map<String, dynamic> json,DateTime time)
      : userId = json["userId"],
        userName = json["username"],
        isRememberPassword = json["isRememberPassword"],
        token = json["token"],
        unitId = json["unitId"],
        unitCode = json["unitCode"],
        phone = json["phone"],
        fullName = json["fullName"],
        userNameShow = json["userNameShow"],
        email = json["email"],
        isActive = json["isActive"],
        unitName = json["unitName"],
        objectGuid = json["objectGuid"],
        addTime = time,
        refreshToken = json["refreshToken"];


      Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'isRememberPassword': isRememberPassword! ? 1 : 0,
      'token': token,
      'unitId': unitId,
      'unitCode': unitCode,
      'phone': phone,
      'fullName': fullName,
      'userNameShow': userNameShow,
      'email': email,
      'isActive': isActive! ? 1 : 0,
      'unitName': unitName,
      'objectGuid': objectGuid,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return "User{userId: $userId, userName: $userName, phone $phone}";
  }

  @override
  List<Object?> get props => [userId];

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return UserInfoTableCompanion(
      fullName: Value(fullName),
      token: Value(token),
      email: Value(email),
      isActive: Value(isActive),
      isRememberPassword: Value(isRememberPassword),
      phone: Value(phone),
      unitCode: Value(unitCode),
      unitId: Value(unitId),
      unitName: Value(unitName),
      userId: Value(userId),
      userName: Value(userName),
      userNameShow: Value(userNameShow),
      objectGuid: Value(objectGuid),
      timeAdd : Value(addTime),
    ).toColumns(nullToAbsent);
  }
}
