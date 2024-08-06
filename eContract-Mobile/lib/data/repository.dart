import 'dart:async';
import 'dart:io';

import 'package:e_contract/data/entity/contract_doc_from.dart';
import 'package:e_contract/data/entity/contract_doc_to.dart';
import 'package:e_contract/data/entity/copy_address_model.dart';
import 'package:e_contract/data/entity/history_model.dart';
import 'package:e_contract/data/entity/initAccessToken.dart';
import 'package:e_contract/data/entity/notification_entity.dart';
import 'package:e_contract/data/entity/remote_signing_success.dart';
import 'package:e_contract/data/entity/select_sign.dart';
import 'package:e_contract/data/entity/sign_contract.dart';
import 'package:e_contract/data/entity/sign_hsm.dart';
import 'package:e_contract/data/entity/support_info.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/network_data/api_reponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

import 'entity/change_password_info.dart';
import 'entity/contract_search.dart';

/// Bkav DucLQ cac trang thai xac thuc cua tai khoan
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

///
/// Bkav HoangLD cac trang thai khi lay mat khau dang nhap tai khoan bang biometric
enum GetPasswordBiometricStatus { successful, failure, moreThan3, none }

///
abstract class Repository {
  final controllerAuthentication = StreamController<AuthenticationStatus>.broadcast();
  final controllerCheckTime = StreamController<bool>.broadcast();

  bool checkedNetwork = false;
  bool checkPermissionNotification = false;

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 2, milliseconds: 800));
    bool isExpToken = await checkExpToken();
    if(!isExpToken){
      updateTokenFirebase();
    }
    yield isExpToken
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;
    yield* controllerAuthentication.stream;
  }

  Stream<bool> get checkTime async* {
    await Future.delayed(const Duration(seconds: 2));
    //Bkav HanhNTHe: check time server
    String time = await getTimeToServer();
    if (time == "") {
      // neu co loi tra ve thi k lam gi het
      yield false;
      return;
    }
    // debugPrint(
    //     " time ok la bao nh ????????????? $time toLocal ${DateTime.parse(time).toLocal().toString()} toUTC time  ${DateTime.parse(time).toUtc().toString()}");
    DateTime now = DateTime.now();
    // debugPrint(
    //     " time ok la bao nh ????????????? $now toLocal ${now.toLocal().toString()} toUTC time  ${now.toUtc().toString()} different ${DateTime.parse(time).toUtc().difference(now.toUtc()).inMinutes.abs() > 10}");
    // HanhNTHe: so sanh neu time lech now 10p thi tra ve isDifferent = true
    yield DateTime.parse(time).toUtc().difference(now.toUtc()).inMinutes.abs() >
        10;
    yield* controllerCheckTime.stream;
  }

  void dispose() {
    controllerAuthentication.close();
    controllerCheckTime.close();
  }

  ///Bkav DucLQ ham check trang thai xac thuc cua tai khoan
  bool authenticated();

  Future<UserInfo> getUserInfo();

  /// Bkav HanhNTHe: check hạn token để duy trì đăng nhập
  /// return true: token het han
  /// return false: token con han
  Future<bool> checkExpToken();

  /// Bkav HanhNTHe: lay thoi gian tu server de thuc hien kich ban so sanh time
  /// giua dien thoai va server
  Future<String> getTimeToServer();

  /// Bkav HanhNTHe: ham login
  Future<ApiResponse> loginWithPassword(
      String username, String password, bool isRemember, BuildContext context ,String objectGuid);

  Future<String?> getPassLogin(String key, BiometricType biometricType,BuildContext context);

  Future<void> savePassLogin(String key, String value);

  Future<void> removePassLogin(String key);

  Future<bool> logout();

  Future<bool> updateLastTimeOpenApp();

  Future<int> getBagNumberApp();

  /// Bkav HanhNTHe: get danh sach ho so den
  Stream<List<ContractDocTo>> getListContractsTo(int pageSize);

  /// Bkav HanhNTHe: get chi tiet 1 ho so
  Stream<List<TextDetail>> getDetailContract(String objectGuid);

  /// Bkav HanhNTHe: get chi tiet 1 ho so co day du cac thong tin
  Future<ContractDocFrom> getDetailContractApp(String objectGuid);

  ///Bkav HoangLD : get list type ký
  Future<List<SelectSign>> getListTypeSignApp(String objectGuid);

  ///Bkav HoangLD : get accesstoken
  Future<InitAccessToken> getAccessTokenEKYC(String objectGuid, String tokenEKYC);

  ///Bkav HoangLD : sign EKYC
  Future<ContractSignInfo> signEKYC(String objectGuid, String transactionId);

  ///Bkav Nhungltk: get content deccument
  Future<String> getDocumentContent(String objectGuid);

  /// Bkav HanhNTHe: show history cua 1 contract
  Future<List<HistoryModel>> showHistoryAContract(String objectGuid);

  /// Bkav HanhNTHe: show copy address a contract
  Future<List<CopyAddressModel>> showCopyAddressContract(String objectGuid);

  ///Bkav Nhungltk: goi y tim kiem
  Future<List<GroupContractSearch>> getSuggestSearchFrom(String keySearch, bool isFrom);

  ///Bkav Nhungltk: get ket qua search dshs di
  Stream<List<ContractDocFrom>> parseResultSearCh(String keySearch, int categoryId, String objectId, BuildContext blocContext, int profileTabID, int pagesize);

  ///Bkav Nhungltk: get ket qua search dshs den
  Future<List<ContractDocTo>> parseResultSearChTo(String keySearch, int categoryId, String objectId, BuildContext blocContext, int profileTabID, int pagesize);

  ///Bkav Nhungltk: lay 20 ho so di tiep theo theo lastupdate khi vuot len
  Future<List<ContractDocFrom>> getListContractContinue(String lastUpdate, int profileTabID, BuildContext blocContext, { String keySearch = "",
      int categoryId = 0, String objectId = "0"});

  ///Bkav Nhungltk: lay 20 ho so den tiep theo theo lastupdate khi vuot len
  Future<List<ContractDocTo>> getListContractToContinue(String lastUpdate, int profileTabID, BuildContext blocContext ,{ String keySearch = "",
    int categoryId = 0, String objectId = "0"});

  ///Bkav Nhungltk: send OTP code
  Future<SignContractInfo> sendOTP(String profileGuid, int type);

  ///Bkav HoangLD: send OTP by tokenHSM
  Future<ContractSignInfo> sendOtpByTokenHsm(String profileGuid, String tokenHsm);

  ///Bkav Nhungltk: confirm OTP code
  Future<ContractSignInfo> confirmOTP(String profileGuid, String otp, bool isFrom, int type);

  ///Bkav HoangLD: confirm OTPEKYC code
  Future<ContractSignInfo> confirmOTPEKYC(String profileGuid, String otp);

  ///Bkav TungDV: post lý do từ chối ký hồ sơ
  Future<ApiResponse> postRejectReason(String objectGuid, String reasonReject);

  ///Bkav TungDV: post lý do từ chối ký hồ sơ
  Stream<List<NotificationEntity>> getListNotification(int currentPage);

  ///Bkav HanhNTHe: api update status thong bao = user seen
  Future<void> updateNotificationStatusViewed(
      {NotificationEntity? notificationEntity, String? notifyGuid, int? total});

  ///Bkav HanhNTHe: api update status thong bao = app da nha
  Future<void> updateNotificationStatusReceived(String notifyGuid);

  ///Bkav HoangLD: change password
  Future<ChangePasswordInfo> changePassword(String passwordOld, String passwordNew);

  Future<void> updateTokenFirebase ();

  Stream<bool> countDownTimer(bool countTimeDown);

  ///Bkav HoangCV: get list Support
  Future<SupportInfo> getListSupport();

  Future<bool> sendLogApp(File fileLogError, File fileLogActivity, File fileLogOther);

  ///Bkav HoangLD : signHSM
  Future<SignHSMContractInfo> signHSM(String objectGuid);

  ///Bkav HoangLD : sign remote signing, return TransactionGuid
  Future<String> signRemoteSigning(String objectGuid);

  ///Bkav HoangLD : call api lang nghe ket qua remote signing
  Future<RemoteSigningSuccess?> getResultRemoteSigning(String transactionGuid);

  ///Bkav HoangLD : call api lang nghe ket qua remote signing
  Future<int> cancelRemoteSigning(String transactionGuid);

  Future<RemoteSigningSuccess?> signRemoteSigningTemp(String objectGuid);

  Future<int> getTimeCallRS();
}
