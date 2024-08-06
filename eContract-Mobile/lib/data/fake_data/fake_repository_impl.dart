import 'dart:async';
import 'dart:io';

import 'package:e_contract/data/entity/button_show.dart';
import 'package:e_contract/data/entity/change_password_info.dart';
import 'package:e_contract/data/entity/contract_doc_from.dart';
import 'package:e_contract/data/entity/contract_doc_to.dart';
import 'package:e_contract/data/entity/contract_search.dart';
import 'package:e_contract/data/entity/copy_address_model.dart';
import 'package:e_contract/data/entity/creator.dart';
import 'package:e_contract/data/entity/history_model.dart';
import 'package:e_contract/data/entity/initAccessToken.dart';
import 'package:e_contract/data/entity/remote_signing_success.dart';
import 'package:e_contract/data/entity/select_sign.dart';
import 'package:e_contract/data/entity/sign_contract.dart';
import 'package:e_contract/data/entity/sign_hsm.dart';
import 'package:e_contract/data/entity/signer.dart';
import 'package:e_contract/data/entity/support_info.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/network_data/api_reponse.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/notification_entity.dart';

class FakeDataSource extends Repository {
  static bool get isFake => false;

  @override
  bool authenticated() {
    return false;
  }

  @override
  Future<UserInfo> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> checkExpToken() async {
    return true;
  }

  @override
  Future<String> getTimeToServer() async {
    return "";
  }

  @override
  Future<ApiResponse> loginWithPassword(
      String username, String password, bool isRemember,BuildContext context,String objectGuid) async {
    return ApiResponse(1, "fake ket qua ", true, true);
  }

  @override
  Future<String?> getPassLogin(String key, BiometricType biometricType,BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<void> savePassLogin(String key, String value) {
    // TODO: implement savePassLogin
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {
    //final prefs = await SharedPreferences.getInstance();
    (await SharedPrefs.instance()).remove(SharedPreferencesKey.token);
    return true;
  }

  @override
  Stream<List<TextDetail>> getDetailContract(String objectGuid) async* {
    List<TextDetail> listTextDetail = [];
    List<Signer> signer = [];
    signer.add(Signer(
        statusSign: ContractConstants.signed,
        signerName: "Lý Hoàng Anh",
        statusView: ContractConstants.seen,
        typeSignId: ContractConstants.hsmUnitSign,
        unitCode2: "unitCode2"));
    signer.add(Signer(
        statusSign: ContractConstants.notSigned,
        signerName: "Công ty TNHH Thành Phátfhuwehtuwehfsndfhehanndhehfuwe",
        statusView: ContractConstants.seen,
        typeSignId: ContractConstants.unknown,
        unitCode2: "unitCode2"));
    listTextDetail.add(TextDetail(
        objectGuid: "anfengndsahtuweg-hsfhewhg-ajwufhebg-afje-th1",
        fileName: "đây là page 1",
        profileItemSigner: signer));
    listTextDetail.add(TextDetail(
        objectGuid: "daylastexdetail-th2-nafbergbrbbabfbrg",
        fileName: "đây là page 2",
        profileItemSigner: signer));
    yield listTextDetail;
  }

  @override
  Future<ContractDocFrom> getDetailContractApp(String objectGuid) async {
    throw Exception();
  }
  @override
  Future<List<SelectSign>> getListTypeSignApp(String objectGuid) async {
    throw Exception();
  }

  @override
  Future<String> getDocumentContent(String objectGuid) async {
    return "HanhNTHe $objectGuid";
  }

  @override
  Future<List<HistoryModel>> showHistoryAContract(String objectGuid) async {
    final List<HistoryModel> list = [
      HistoryModel(
          account: "HoangLD",
          logContent: "Ký hồ sơ",
          createDate: "2021-11-15T13:15:30",
          objectGuid: '',
          id: 0,
          userId: 0,
          ip: ""),
      HistoryModel(
          account: "HoangLD",
          logContent: "Ký hồ sơ",
          createDate: "2021-11-15T13:15:30",
          objectGuid: '',
          id: 0,
          userId: 0,
          ip: ""),
      HistoryModel(
          account: "HoangLD",
          logContent: "Ký hồ sơ",
          createDate: "2021-11-15T13:15:30",
          objectGuid: '',
          id: 0,
          userId: 0,
          ip: ""),
      HistoryModel(
          account: "HoangLD",
          logContent: "Ký hồ sơ",
          createDate: "2021-11-15T13:15:30",
          objectGuid: '',
          id: 0,
          userId: 0,
          ip: ""),
    ];
    return list;
  }

  @override
  Future<List<CopyAddressModel>> showCopyAddressContract(
      String objectGuid) async {
    final List<CopyAddressModel> list = [
      CopyAddressModel(
          signer: "Công ty TNHH ABC",
          address:
              "https://abctrading.com.vn/1uzPhHmiUKjKPQIkCqOdm4gWJiQ/edit#",
          deadline: Utils.convertTimeFDTF(time: "2021-11-15T13:15:30", type: ConstFDTFString.m3a) ),
      CopyAddressModel(
          signer: "Công ty TNHH Minh Hung",
          address:
              "https://abctrading.com.vn/1uzPhHmiUKjKPQIkCqOdm4gWJiQ/edit#",
          deadline: "2021-11-15T13:15:30"),
      CopyAddressModel(
          signer: "Công ty TNHH Logistc Global",
          address:
              "https://abctrading.com.vn/1uzPhHmiUKjKPQIkCqOdm4gWJiQ/edit#",
          deadline: "2021-11-15T13:15:30"),
    ];
    return list;
  }

  @override
  Future<List<GroupContractSearch>> getSuggestSearchFrom(String keySearch, bool isFrom) async{
    final List<ObjectSearch> listObject=[
      ObjectSearch(objectId: "341", objectName: "24May_ Hồ sơ tổng hợp Doanh Thu ngày 24 tháng 5"),
      ObjectSearch(objectId: "50", objectName: "Hồ sơ  về các hợp đồng, giao dịch"),
      ObjectSearch(objectId: "263", objectName: "Hồ sơ 6 chữ ký, 2 bên AB, có macrro to test 27.4 vô thời hạn"),
      ObjectSearch(objectId: "106", objectName: "Hồ sơ ACS")
    ];
    final List<GroupContractSearch> list=[
      GroupContractSearch(categoryId: 2, categoryName: "Hồ sơ mẫu", list: listObject)
    ];
    return list;
  }

  @override
  Stream<List<ContractDocFrom>> parseResultSearCh(String keySearch, int categoryId, String objectId, BuildContext blocContext, int profileTabID, int pagesize) async* {
    List<TextDetail> listTextDetail = [];
    List<Signer> signer = [];
    signer.add(Signer(
        statusSign: ContractConstants.signed,
        signerName: "Lý Hoàng Anh",
        statusView: ContractConstants.seen,
        typeSignId: ContractConstants.hsmUnitSign,
        unitCode2: "unitCode2"));
    signer.add(Signer(
        statusSign: ContractConstants.notSigned,
        signerName: "Công ty TNHH Thành Phátfhuwehtuwehfsndfhehanndhehfuwe",
        statusView: ContractConstants.seen,
        typeSignId: ContractConstants.unknown,
        unitCode2: "unitCode2"));
    listTextDetail.add(TextDetail(
        objectGuid: "c9f2b6ff-420b-453b-9d4e-5d27c8594ae9",
        fileName: "đây là page 1",
        profileItemSigner: signer));
    listTextDetail.add(TextDetail(
        objectGuid: "daylastexdetail-th2-nafbergbrbbabfbrg",
        fileName: "đây là page 2",
        profileItemSigner: signer));
    yield [];
  }
  @override
  Stream<List<ContractDocTo>> getListContractsTo(int pageSize) async* {
    /**
     * Bkav HanhNTHe: xu ly call api, database cac thu de co duoc list
     */
    List<Signer> signer2 = [];
    signer2.add(Signer(
        statusSign: ContractConstants.notSigned,
        signerName: "Nguyễn Hùng Dũng",
        statusView: ContractConstants.notSeen,
        typeSignId: ContractConstants.hsmUnitSign,
        unitCode2: "unitCode2"));
    signer2.add(Signer(
        statusSign: ContractConstants.notSigned,
        signerName: "Công ty TNHH Thành Phát",
        statusView: ContractConstants.seen,
        typeSignId: ContractConstants.unknown,
        unitCode2: "unitCode2"));

    List<ContractDocTo> listTo = [
      ContractDocTo(
          contractGuid: "ojfetjshaur-jijr",
          contractStatus: ContractConstants.waitingSign,
          signDeadline: "2021-11-15T13:15:30",
          signers: signer2,
          contractName: "Giao dịch Dmoney",
          profileTypeName: "HĐ hợp tác",
          creator: Creator(fullName: "HanhNTHe", id: 123, userName: "Hanh"),
          buttonShow: ButtonShow(cancelTranferSign: true, sign: true, copyPageSign: true, restore: true, download: true, edit: true, viewHistory: true))
    ];
    yield listTo;
  }

  @override
  Future<List<ContractDocFrom>> getListContractContinue(String lastUpdate, int profileTabID, BuildContext blocContext,{ String keySearch = "",
    int categoryId = 0, String objectId = "0"}) {
    // TODO: implement getListContractContinue
    throw UnimplementedError();
  }

  @override
  Future<List<ContractDocTo>> getListContractToContinue(String lastUpdate, int profileTabID, BuildContext blocContext,{ String keySearch = "",
    int categoryId = 0, String objectId = "0"}) {
    // TODO: implement getListContractToContinue
    throw UnimplementedError();
  }

  @override
  Future<List<ContractDocTo>> parseResultSearChTo(String keySearch, int categoryId, String objectId, BuildContext blocContext, int profileTabID, int pagesize) {
    // TODO: implement parseResultSearChTo
    throw UnimplementedError();
  }

  @override
  Future<SignContractInfo> sendOTP(String profileGuid, int type) async{
    return const SignContractInfo(otpExpriedTime: "10/10/2010", otpDue: 300, phoneNumber: "039****071", errorMessage: "");
  }
  @override
  Future<SignHSMContractInfo> signHSM(String objectGuid) async{
    return const SignHSMContractInfo(status: 200,
        reasonError: "", isOk: true);
  }

  @override
  Future<ContractSignInfo> confirmOTP(String profileGuid, String otp, bool isFrom, int type) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> postRejectReason(String objectGuid, String reasonReject) {
    // TODO: implement postRejectReason
    throw UnimplementedError();
  }

  @override
  Stream<List<NotificationEntity>> getListNotification(int currentPage) async* {
    final List<NotificationEntity> list = [
      NotificationEntity(
        notifyId:"9",
        objectGuid:"c5e5a685-f300-11eca29d-a85e456acfd9",
        notifyTypeID:0,
        notifyName:"Chờ ký Hồ sơ",
        textColor:"#F57C00",
        title:"Chờ ký Hồ sơ",
        body:"nội dung tin chờ ký hồ sơ",
        profileId:112,
        profileGuid: "",
        profileTabId: 1,
        status:3,
        sendCount:0,
        sendDate:"0001-01-01T00:00:00",
        lastUpdate:"0001-01-01T00:00:00",
        createDate:"2022-06-23T21:28:38", totalUnread: 2),
      NotificationEntity(
          notifyId:"9",
          objectGuid:"c5e5a685-f300-11eca29d-a85e456acfd9",
          notifyTypeID:0,
          notifyName:"Chờ ký Hồ sơ",
          textColor:"#F57C00",
          title:"Chờ ký Hồ sơ",
          body:"nội dung tin chờ ký hồ sơ",
          profileId:112,
          profileGuid: "",
          profileTabId: 1,
          status:3,
          sendCount:0,
          sendDate:"0001-01-01T00:00:00",
          lastUpdate:"0001-01-01T00:00:00",
          createDate:"2022-06-23T21:28:38", totalUnread: 2),
      NotificationEntity(
          notifyId:"9",
          objectGuid:"c5e5a685-f300-11eca29d-a85e456acfd9",
          notifyTypeID:0,
          notifyName:"Chờ ký Hồ sơ",
          textColor:"#F57C00",
          title:"Chờ ký Hồ sơ",
          body:"nội dung tin chờ ký hồ sơ",
          profileId:112,
          profileGuid: "",
          profileTabId: 1,
          status:3,
          sendCount:0,
          sendDate:"0001-01-01T00:00:00",
          lastUpdate:"0001-01-01T00:00:00",
          createDate:"2022-06-23T21:28:38", totalUnread: 2),
      NotificationEntity(
          notifyId:"9",
          objectGuid:"c5e5a685-f300-11eca29d-a85e456acfd9",
          notifyTypeID:0,
          notifyName:"Chờ ký Hồ sơ",
          textColor:"#F57C00",
          title:"Chờ ký Hồ sơ",
          body:"nội dung tin chờ ký hồ sơ",
          profileId:112,
          profileGuid: "",
          profileTabId: 1,
          status:3,
          sendCount:0,
          sendDate:"0001-01-01T00:00:00",
          lastUpdate:"0001-01-01T00:00:00",
          createDate:"2022-06-23T21:28:38", totalUnread: 2),
      NotificationEntity(
          notifyId:"9",
          objectGuid:"c5e5a685-f300-11eca29d-a85e456acfd9",
          notifyTypeID:0,
          notifyName:"Chờ ký Hồ sơ",
          textColor:"#F57C00",
          profileGuid: "",
          profileTabId: 1,
          title:"Chờ ký Hồ sơ",
          body:"nội dung tin chờ ký hồ sơ",
          profileId:112,
          status:3,
          sendCount:0,
          sendDate:"0001-01-01T00:00:00",
          lastUpdate:"0001-01-01T00:00:00",
          createDate:"2022-06-23T21:28:38", totalUnread: 2),
    ];
    yield list;
  }

  @override
  Future<ChangePasswordInfo> changePassword(String passwordOld, String passwordNew) async {
    // TODO: implement updateTokenFirebase
    throw UnimplementedError();
  }
  @override
  Future<void> updateTokenFirebase() {
    // TODO: implement updateTokenFirebase
    throw UnimplementedError();
  }

  @override
  Future<void> updateNotificationStatusViewed(
      {NotificationEntity? notificationEntity, String? notifyGuid, int? total}) {
    // TODO: implement updateNotificationStatusViewed
    throw UnimplementedError();
  }

  @override
  Future<void> updateNotificationStatusReceived(String notifyGuid) {
    // TODO: implement updateNotificationStatusViewed
    throw UnimplementedError();
  }

  @override
  Stream<bool> countDownTimer(bool countTimeDown) {
    throw UnimplementedError();
  }

  @override
  Future<SupportInfo> getListSupport() {
    // TODO: implement getListSupport
    throw UnimplementedError();
  }

  @override
  Future<bool> sendLogApp(File fileLogError, File fileLogActivity, File fileLogOther) async{
    return true;
  }

  @override
  Future<void> removePassLogin(String key) {
    // TODO: implement removePassLogin
    throw UnimplementedError();
  }

  @override
  Future<String> signRemoteSigning(String objectGuid) {
    // TODO: implement signRemoteSigning
    throw UnimplementedError();
  }

  @override
  Future<RemoteSigningSuccess?> getResultRemoteSigning(String transactionGuid) {
    // TODO: implement getResultRemoteSigning
    throw UnimplementedError();
  }

  @override
  Future<int> cancelRemoteSigning(String transactionGuid) {
    // TODO: implement cancelRemoteSigning
    throw UnimplementedError();
  }

  @override
  Future<RemoteSigningSuccess?> signRemoteSigningTemp(String objectGuid) {
    // TODO: implement signRemoteSigningTemp
    throw UnimplementedError();
  }

  @override
  Future<int> getTimeCallRS() {
    // TODO: implement getTimeCallRS
    throw UnimplementedError();
  }

  @override
  Future<bool> updateLastTimeOpenApp() {
    // TODO: implement updateLastTimeOpenApp
    throw UnimplementedError();
  }

  @override
  Future<int> getBagNumberApp() {
    // TODO: implement getBagNumberApp
    throw UnimplementedError();
  }

  @override
  Future<ContractSignInfo> sendOtpByTokenHsm(String profileGuid, String tokenHsm) {
    // TODO: implement sendOtpByTokenHsm
    throw UnimplementedError();
  }

  @override
  Future<InitAccessToken> getAccessTokenEKYC(String objectGuid, String tokenEKYC) {
    // TODO: implement getAccessTokenEKYC
    throw UnimplementedError();
  }

  @override
  Future<ContractSignInfo> signEKYC(String objectGuid, String transactionId) {
    // TODO: implement signEKYC
    throw UnimplementedError();
  }

  @override
  Future<ContractSignInfo> confirmOTPEKYC(String profileGuid, String otp) {
    // TODO: implement confirmOTPEKYC
    throw UnimplementedError();
  }

}
