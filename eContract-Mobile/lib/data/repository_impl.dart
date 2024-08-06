import 'dart:async';
import 'dart:convert';
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
import 'package:e_contract/data/entity/support_info.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/fake_data/fake_repository_impl.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/data/network_data/api_provider.dart';
import 'package:e_contract/data/network_data/api_reponse.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/contract/sign_form_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entity/notification_entity.dart';
import 'entity/sign_hsm.dart';
import 'entity/signer.dart';

class RepositoryImpl with Repository {
  final ApiProvider _apiProvider = ApiProvider();
  final FakeDataSource _fakeData = FakeDataSource();
  final bool isFakeData = FakeDataSource.isFake;
  String? _tokenUser;

  // HanhNTHe: làm cache ho so di
  List<ContractDocFrom> listFromCache = [];

  // HanhNTHe: làm cache ho so den
  List<ContractDocTo> listToCache = [];

  // HanhNTHe: list cach danh sach thong bao
  List<NotificationEntity> listNotifyCache = [];

  @override
  bool authenticated() {
    if (isFakeData) return _fakeData.authenticated();
    return false;
  }

  @override
  Future<UserInfo> getUserInfo() async {
    if (isFakeData) return _fakeData.getUserInfo();
    String fullName = (await SharedPrefs.instance()).getString(SharedPreferencesKey.fullName) ?? "";
    String token = (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "";
    String userName = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "";
    UserInfo userInfo =
        UserInfo(fullName: fullName, token: token, userName: userName);
    // debugPrint("getUserInfo $fullName");
    return userInfo;
  }

  @override
  Future<bool> checkExpToken() async {
    if (isFakeData) return _fakeData.checkExpToken();
    ApiResponse response = await _apiProvider.checkToken(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization");
    if (response.status != -1) return false;
    DateTime now = DateTime.now();
    DateTime tokenDeadLine = DateTime.parse(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenDeadline) ??
            now.subtract(const Duration(seconds: 1)).toString());
    // so sanh xem neu thoi gian hien tai la sau han token thi he han
    // return true: token het han
    return now.isAfter(tokenDeadLine);
  }

  @override
  Future<String> getTimeToServer() async {
    if (isFakeData) return _fakeData.getTimeToServer();
    ApiResponse response = await _apiProvider.getTimeToServer(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization");
    // debugPrint(" getTimeToServer response ${response.isOk} ${response.object}============= ");
    if (response.isOk) {
      // debugPrint(
      //     " getTimeToServer ================ ${response.object["dateTime"]}");
      Logger.logActivity(
          " lay thoi gian chuan tu server  ${response.object["dateTime"]}");
      return response.object["dateTime"];
    }
    return "";
  }

  @override
  Future<ApiResponse> loginWithPassword(String username, String password,
      bool isRemember, BuildContext context ,String objectGuid,) async {
    if (isFakeData) {
      return _fakeData.loginWithPassword(
          username, password, isRemember, context ,objectGuid);
    }
    // if (await Utils.checkInternetConnection() == false) {
    //  await Future.delayed(const Duration(seconds: 3), () {
    //     DiaLogManager.displayDialog(context, S.of(context).title_no_internet,
    //         S.of(context).content_dialog_no_internet, () {}, () {
    //           Get.back();
    //         }, "S.of(context).close_dialog", "");
    //   });
    //  return ApiResponse(511, "", false, true);
    // }
    String uuidSave = (await SharedPrefs.instance()).getString(SharedPreferencesKey.keyUUID) ?? SharedPreferencesKey.defaultUuid;
    ApiResponse response =
        await _apiProvider.login(username, password, isRemember, null ,objectGuid, uuidSave);
    print(response.isOk);
    print(response.status);

    if (response.isOk) {
      if(response.status == 0){
        UserInfo userInfo = UserInfo.fromJson(response.object["dataEC"],DateTime.now());
        _tokenUser = userInfo.token;
        print(_tokenUser);
        (await SharedPrefs.instance()).setString(SharedPreferencesKey.token, userInfo.token!);
        (await SharedPrefs.instance()).setString(
            SharedPreferencesKey.tokenDeadline,
            isRemember
                ? (DateTime.now()).add(const Duration(days: 7)).toString()
                : (DateTime.now()).add(const Duration(hours: 4)).toString());
        (await SharedPrefs.instance()).setString(SharedPreferencesKey.userName, username.toLowerCase());
        (await SharedPrefs.instance()).setInt(SharedPreferencesKey.userId, userInfo.userId ?? -1);
        (await SharedPrefs.instance()).setString(SharedPreferencesKey.refreshToken, userInfo.refreshToken??"");

        Logger.logActivity(" login ok ${userInfo.userId}");

        _apiProvider.updateTokenInfo(userInfo.objectGuid!, userInfo.token!);


        await EContractDb.instance.createOrUpdateUser(userInfo);
        // -end
        (await SharedPrefs.instance()).setString(SharedPreferencesKey.fullName, userInfo.fullName ?? "");
        savePassLogin(userInfo.userName!, password);
        Logger.logActivity("loginWithPassword ${userInfo.token} ${userInfo.userName}");
      }
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return ApiResponse(200, "", false, true);
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return ApiResponse(500, "", false, false);
    }
    return response;
  }

  String getToken() {
    if (_tokenUser != null && _tokenUser!.isNotEmpty) {
      return _tokenUser!;
    }
    return "";
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<void> savePassLogin(String key, String value) async {
    if (isFakeData) {
      return _fakeData.savePassLogin(key, value);
    }
    const storage = FlutterSecureStorage();
    key = key.toLowerCase();
    await storage.write(
        key: key.toLowerCase(),
        value: value,
        aOptions: _getAndroidOptions(),
        iOptions: IOSOptions(
            accountName: key));
  }

  @override
  Future<void> removePassLogin(String key) async {
    if (isFakeData) {
      return _fakeData.removePassLogin(key);
    }
    const storage = FlutterSecureStorage();
    key = key.toLowerCase();
    await storage.delete(
        key: key,
        aOptions: _getAndroidOptions(),
        iOptions: IOSOptions(
            accountName: key));
  }

  @override
  Future<String?> getPassLogin(
      String key, BiometricType biometricType, BuildContext context) async {
    if (isFakeData) {
      return _fakeData.getPassLogin(key, biometricType, context);
    }
    // neu nguoi dung khong duoc phep dang nhap bang local auth
    bool statusFingerprint =
        await Utils.statusFingerprint(key: key.toLowerCase());
    bool statusFaceID = await Utils.statusFaceID(key: key.toLowerCase());
    Logger.logActivity(" statusFingerprint $status status face id $statusFaceID");
    if (biometricType == BiometricType.face && !statusFaceID) {
      return "";
    }
    if (biometricType == BiometricType.fingerprint && !statusFingerprint) {
      return "";
    }
    const storage = FlutterSecureStorage();
    key = key.toLowerCase();
    String authenticate = "";
    if (biometricType == BiometricType.face) {
      authenticate = "FaceID";
    } else if (biometricType == BiometricType.fingerprint) {
      authenticate = "FingerPrint";
    }
    if (authenticate.isEmpty) {
      return authenticate;
    }
    //HoangLD kiem tra lai cac trang thai
    Object statusAuthenticated =
        await Utils.checkAuthenticateBiometric(authenticate);
    if (statusAuthenticated == GetPasswordBiometricStatus.successful) {
      return await storage.read(
          key: key.toLowerCase(),
          aOptions: _getAndroidOptions(),
          iOptions: IOSOptions(
              accountName: key));
    } else if (statusAuthenticated == GetPasswordBiometricStatus.failure) {
      return null;
    } else if (statusAuthenticated == GetPasswordBiometricStatus.moreThan3) {
      return "${GetPasswordBiometricStatus.moreThan3}";
    }
    return "";
  }

  @override
  Future<bool> logout() async {
    if (isFakeData) {
      return _fakeData.logout();
    }
    // thuc hien xoa luon token duoc luu trong thiết bị
    String token =
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization";
    (await SharedPrefs.instance()).remove(SharedPreferencesKey.token);
    (await SharedPrefs.instance()).remove(SharedPreferencesKey.tokenDeadline);
    (await SharedPrefs.instance()).remove(SharedPreferencesKey.refreshToken);

    //Bkav DucLQ
    listFromCache.clear();
    listToCache.clear();
    //Bkav HoangLD fix bug BECM-516
    listNotifyCache.clear();

    // call api logout
    ApiResponse response = await _apiProvider.logout(token);
    return response.isOk;
  }
  @override
  Future<bool> updateLastTimeOpenApp() async {
    if (isFakeData) {
      return _fakeData.updateLastTimeOpenApp();
    }
    // call api update time
    ApiResponse response = await _apiProvider.updateLastTimeOpen();
    return response.isOk;
  }
  @override
  Future<int> getBagNumberApp() async {
    if (isFakeData) {
      return _fakeData.getBagNumberApp();
    }
    ApiResponse response = await _apiProvider.getBagNumber();
    return response.object;
  }

  @override
  Stream<List<ContractDocFrom>> parseResultSearCh(
      String keySearch,
      int categoryId,
      String objectId,
      BuildContext blocContext,
      int profileTabID,
      int pagesize) async* {
    if (isFakeData) {
      yield* _fakeData.parseResultSearCh(
          keySearch, categoryId, objectId, blocContext, profileTabID, pagesize);
      return;
    }
    if (listFromCache.isNotEmpty) yield listFromCache;
    // HanhNTHe lay gia tri tu database
    //int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    String userId = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "";
    listFromCache = await EContractDb.instance.getContractsFrom(userId).get();
    if (listFromCache.isNotEmpty) {
      for (var element in listFromCache) {
        Creator creator = await EContractDb.instance
            .singleCreator(element.contractGuid ?? "")
            .getSingle();
        element.creator = creator;
        List<Signer> signers = await EContractDb.instance
            .getSigners(element.contractGuid ?? "")
            .get();
        element.setListSigner(signers);
        ButtonShow buttonShow = await EContractDb.instance
            .singleButtonShow(element.contractGuid ?? "")
            .getSingle();
        element.buttonShow = buttonShow;
      }
      yield listFromCache;

      // Lay danh sac van ban
      for (var element in listFromCache) {
        List<TextDetail> listTextDetail = [];
        // HanhNTHe lay gia tri tu database
        listTextDetail = await EContractDb.instance
            .getTextDetails(element.contractGuid ?? "")
            .get();
        if (listTextDetail.isNotEmpty) {
          for (var signer in listTextDetail) {
            List<Signer> signers = await EContractDb.instance
                .getSignersInText(signer.objectGuid)
                .get();
            signer.setListSigner(signers);
          }
          // debugPrint(
          //     "getDetailContractFrom end get database ${listTextDetail.first.fileName}  ${listTextDetail.length}");
        }
        // -end
        element.listextDetail = listTextDetail;
      }

      yield listFromCache;
    }
    // - end
    ApiResponse response = await _apiProvider.getResultSearchContract(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        keySearch,
        categoryId,
        objectId,
        profileTabID,
        pagesize);
    List<ContractDocFrom> listContract = [];
    if (response.isOk) {
      listContract =
          parseListContractsFrom(jsonEncode(response.object['data']), userId);
    }
    if (listContract != listFromCache) {
      listFromCache = listContract;
      yield listFromCache;
    }
    insertContractFromDb(listContract);
  }
  
  void insertContractFromDb(List<ContractDocFrom> listContract) async {
    // save data
    await EContractDb.instance.insertMultipleContractFromEntries(listContract);
    for (var element in listContract) {
      EContractDb.instance.createOrUpdateCreator(element.creator!);
      await EContractDb.instance.insertMultipleSignersEntries(element.signers ?? []);
      EContractDb.instance.createOrUpdateButtonShow(element.buttonShow!);
      await EContractDb.instance
          .insertMultipleTextDetailEntries(element.listextDetail ?? []);
      for (var signer in element.listextDetail ?? []) {
        await EContractDb.instance
            .insertMultipleSignersEntries(signer.profileItemSigner);
      }
    }
    // -end
  }

  /// Bkav HanhNTHe: convert list ho so di
  List<ContractDocFrom> parseListContractsFrom(String data, String userId) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

    return parsed
        .map<ContractDocFrom>((json) => ContractDocFrom.fromJson(json, userId))
        .toList();
  }

  @override
  Stream<List<ContractDocTo>> getListContractsTo(int pageSize) async* {
    if (isFakeData) {
      yield* _fakeData.getListContractsTo(pageSize);
      return;
    }
    if (listToCache.isNotEmpty) yield listToCache;
    // HanhNTHe lay gia tri tu database
    //int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    String userId = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "";
    listToCache = await EContractDb.instance.getContractsTo(userId).get();
    if (listToCache.isNotEmpty) {
      for (var element in listToCache) {
        try {
          Creator creator = await EContractDb.instance
              .singleCreator(element.contractGuid ?? "")
              .getSingle();
          element.creator = creator;
          List<Signer> signers = await EContractDb.instance
              .getSigners(element.contractGuid ?? "")
              .get();
          element.setListSigner(signers);
          ButtonShow buttonShow = await EContractDb.instance
              .singleButtonShow(element.contractGuid ?? "")
              .getSingle();
          element.buttonShow = buttonShow;
        } catch (e){
          Logger.logError("Error get button show ${e.toString()}");
        }
      }
      // debugPrint(" HanhNTHe: getList ContractFrom end --------1 ");
      yield listToCache;

      // Lay danh sac van ban
      for (var element in listToCache) {
        List<TextDetail> listTextDetail = [];
        // HanhNTHe lay gia tri tu database
        listTextDetail = await EContractDb.instance
            .getTextDetails(element.contractGuid ?? "")
            .get();
        if (listTextDetail.isNotEmpty) {
          for (var signer in listTextDetail) {
            List<Signer> signers = await EContractDb.instance
                .getSignersInText(signer.objectGuid)
                .get();
            signer.setListSigner(signers);
          }
          // debugPrint(
          //     "getDetailContractFrom end get database ${listTextDetail.first.fileName}  ${listTextDetail.length}");
        }
        // -end
        element.listextDetail = listTextDetail;
      }

      // debugPrint(" HanhNTHe: getList ContractFrom end 2------------------- ");
      yield listToCache;
    }

    ApiResponse response = await _apiProvider.getListContracts(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        pageSize,
        2);
    List<ContractDocTo> listContract = [];
    if (response.isOk) {
      listContract =
          parseListContractsTo(jsonEncode(response.object['data']), userId);
    }
    // debugPrint(" HanhNTHe: getList getListContractsTo end listContract .end ${DateTime.parse(listContract.last.lastUpdate?? "").day}  ${DateTime.parse(listContract.last.lastUpdate?? "").month}");
    if (listContract != listToCache) {
      listToCache = listContract;
      yield listToCache;
    }
    insertContractToDb(listContract);
  }

  void insertContractToDb(List<ContractDocTo> listContract) async {
    // save data
    await EContractDb.instance.insertMultipleContractToEntries(listContract);
    for (var element in listContract) {
      EContractDb.instance.createOrUpdateCreator(element.creator!);
      await EContractDb.instance
          .insertMultipleSignersEntries(element.signers ?? []);
      EContractDb.instance.createOrUpdateButtonShow(element.buttonShow!);
      await EContractDb.instance
          .insertMultipleTextDetailEntries(element.listextDetail ?? []);
      for (var signer in element.listextDetail ?? []) {
        await EContractDb.instance
            .insertMultipleSignersEntries(signer.profileItemSigner);
      }
    }
// -end
  }

  /// Bkav HanhNTHe: convert list ho so den
  List<ContractDocTo> parseListContractsTo(String data, String userId) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    return parsed
        .map<ContractDocTo>((json) => ContractDocTo.fromJson(json, userId))
        .toList();
  }

  @override
  Stream<List<TextDetail>> getDetailContract(String objectGuid) async* {
    if (isFakeData) {
      yield* _fakeData.getDetailContract(objectGuid);
      return;
    }

    List<TextDetail> listTextDetail = [];
    // HanhNTHe lay gia tri tu database
    listTextDetail =
        await EContractDb.instance.getTextDetails(objectGuid).get();
    if (listTextDetail.isNotEmpty) {
      for (var element in listTextDetail) {
        List<Signer> signers = await EContractDb.instance
            .getSignersInText(element.objectGuid)
            .get();
        element.setListSigner(signers);
      }
      yield listTextDetail;
    }
    // -end

    ApiResponse response = await _apiProvider.getDetailContract(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        objectGuid);
    if (response.isOk) {
      listTextDetail = parseListTextDetail(
          jsonEncode(response.object['ltProfileTextDetail']), objectGuid);
    }
    yield listTextDetail;

    // save data
    await EContractDb.instance.insertMultipleTextDetailEntries(listTextDetail);
    for (var element in listTextDetail) {
      await EContractDb.instance
          .insertMultipleSignersEntries(element.profileItemSigner);
    }
    // -end
  }

  @override
  Future<ContractDocFrom> getDetailContractApp(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.getDetailContractApp(objectGuid);
    }

    ApiResponse response = await _apiProvider.getDetailContractApp(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        objectGuid);
    if (response.isOk) {
      return parseListContractsFrom(jsonEncode(response.object["data"]),
          (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "")
          .first;
    } else if(response.isError){
      if(response.status != -1){
        DiaLogManager.showDialogHTTPError(
            status: response.isError ? 200 : response.status,
            resultStatus: response.status,
            resultObject: response.object);
      }
    }
    return ContractDocFrom();
  }

  @override
  Future<List<SelectSign>> getListTypeSignApp(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.getListTypeSignApp(objectGuid);
    }

    ApiResponse response = await _apiProvider.getListTypeSignOfProfile(objectGuid);
    if (response.isOk) {
      return parseListTypeSign(jsonEncode(response.object));
    } else if(response.isError){
      if(response.status != -1){
        DiaLogManager.showDialogHTTPError(
            status: response.isError ? 200 : response.status,
            resultStatus: response.status,
            resultObject: response.object);
      }
    }
    return [];
  }

  @override
  Future<InitAccessToken> getAccessTokenEKYC(String objectGuid, String tokenEKYC) async {
    if (isFakeData) {
      return _fakeData.getAccessTokenEKYC(objectGuid ,tokenEKYC);
    }

    ApiResponse response = await _apiProvider.getAccessTokenEKYC(objectGuid, tokenEKYC);
    if (response.isOk) {
      return InitAccessToken.fromJson(response.object);
    } else {
      if(response.status == 9){
        return const InitAccessToken("",0,"");
      } else if(response.status != -1){
        DiaLogManager.showDialogHTTPError(
            status: response.isError ? 200 : response.status,
            resultStatus: response.status,
            resultObject: response.object);
        return const InitAccessToken("",0,"");
      }else {
        return const InitAccessToken("", 0, "");
      }

    }
  }

  @override
  Future<ContractSignInfo> signEKYC(String objectGuid, String transactionId) async {
    if (isFakeData) {
      return _fakeData.signEKYC(objectGuid, transactionId);
    }
    var tokenEKYC = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenEKYC)??"";
    ApiResponse response = await _apiProvider.signEKYC(objectGuid, transactionId, tokenEKYC);
    if (response.isOk) {
      return ContractSignInfo(response.object["profileCode"], response.object["signerName"], response.object["signDate"], "","");
    } else {
      if(response.status != -1){
        DiaLogManager.showDialogHTTPError(
            status: response.isError ? 200 : response.status,
            resultStatus: response.status,
            resultObject: response.object);
        return ContractSignInfo("", "", "", jsonEncode(response.object),"");
      }
      return ContractSignInfo("", "", "", jsonEncode(response.object),"");
    }
  }

  /// Bkav HanhNTHe: convert list van ban trong 1 chi tiet ho so
  List<TextDetail> parseListTextDetail(String data, String profileId) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

    return parsed
        .map<TextDetail>((json) => TextDetail.fromJson(json, profileId))
        .toList();
  }

  ///Bkav Nhungltk: get document content
  @override
  Future<String> getDocumentContent(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.getDocumentContent(objectGuid);
    }
    ApiResponse response = await _apiProvider.getDoccumentContent(
        (await SharedPrefs.instance()).getString(
              SharedPreferencesKey.token,
            ) ??
            "Authorization",
        objectGuid);
    if (response.isOk) {
      String stringEncodeBase64 = response.object;
      return stringEncodeBase64;
    } else if(response.isError){
      if(response.status != -1){
        DiaLogManager.showDialogHTTPError(
            status: response.isError ? 200 : response.status,
            resultStatus: response.status,
            resultObject: response.object);
      }
    }
    return '';
  }

  @override
  Future<List<HistoryModel>> showHistoryAContract(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.showHistoryAContract(objectGuid);
    }
    ApiResponse response = await _apiProvider.showHistoryAContract(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        objectGuid);
    if (response.isOk) {
      return parseListHistory(jsonEncode(response.object['data']));
    } else if(response.isError){
      DiaLogManager.showDialogHTTPError(
          status: response.isError ? 200 : response.status,
          resultStatus: response.status,
          resultObject: response.object);
    }
    return [];
  }

  /// Bkav HanhNTHe: convert list history
  List<HistoryModel> parseListHistory(String data) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

    return parsed
        .map<HistoryModel>((json) => HistoryModel.fromJson(json))
        .toList();
  }
  List<SelectSign> parseListTypeSign(String data) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

    return parsed
        .map<SelectSign>((json) => SelectSign.fromJson(json))
        .toList();
  }

  @override
  Future<List<CopyAddressModel>> showCopyAddressContract(
      String objectGuid) async {
    if (isFakeData) {
      return _fakeData.showCopyAddressContract(objectGuid);
    }
    ApiResponse response = await _apiProvider.showCopyAddress(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        objectGuid);
    if (response.isOk) {
      return parseListCopyAddress(
          jsonEncode(response.object['ltProfilePageSign']));
    } else if(response.isError){
      DiaLogManager.showDialogHTTPError(
          status: response.isError ? 200 : response.status,
          resultStatus: response.status,
          resultObject: response.object);
    }
    return [];
  }

  /// Bkav HanhNTHe: convert list history
  List<CopyAddressModel> parseListCopyAddress(String data) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

    return parsed
        .map<CopyAddressModel>((json) => CopyAddressModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<GroupContractSearch>> getSuggestSearchFrom(
      String keySearch, bool isFrom) async {
    if (isFakeData) {
      return _fakeData.getSuggestSearchFrom(keySearch, isFrom);
    }
    ApiResponse response = await _apiProvider.suggestSearchContract(
        (await SharedPrefs.instance()).getString(
              SharedPreferencesKey.token,
            ) ??
            "Authorization",
        keySearch,
        isFrom);
    if (response.isOk) {
      return groupContractSearch(
          listContractSearch(jsonEncode(response.object)));
    }
    return [];
  }

  List<ContractSearch> listContractSearch(String data) {
    final parseRespone = jsonDecode(data).cast<Map<String, dynamic>>();
    return parseRespone
        .map<ContractSearch>((json) => ContractSearch.fromJson(json))
        .toList();
  }

  List<GroupContractSearch> groupContractSearch(
      List<ContractSearch> listContractSearch) {
    List<ObjectSearch> listObject = [];
    List<GroupContractSearch> listGroupContract = [];
    List<int> listId =
        listContractSearch.map((e) => e.categoryId).toSet().toList();
    for (int i = 0; i < listId.length; i++) {
      listObject = listContractSearch
          .where((element) => element.categoryId == listId[i])
          .map<ObjectSearch>((e) =>
              ObjectSearch(objectId: e.objectId, objectName: e.objectName))
          .toList();
      listGroupContract.add(GroupContractSearch(
          categoryId: listId[i],
          categoryName: listContractSearch
              .firstWhere((element) => element.categoryId == listId[i])
              .categoryName,
          list: listObject));
    }
    return listGroupContract;
  }

  @override
  Future<List<ContractDocTo>> parseResultSearChTo(
      String keySearch,
      int categoryId,
      String objectId,
      BuildContext blocContext,
      int profileTabID,
      int pagesize) async {
    if (isFakeData) {
      return _fakeData.parseResultSearChTo(
          keySearch, categoryId, objectId, blocContext, profileTabID, pagesize);
    }
    //int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    String userId = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "";
    ApiResponse response = await _apiProvider.getResultSearchContract(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        keySearch,
        categoryId,
        objectId,
        profileTabID,
        pagesize);
    String object = jsonEncode(response.object['data']);
    if (response.isOk) {
      return parseListContractsTo(object, userId);
    }
    return [];
  }

  @override
  Future<List<ContractDocFrom>> getListContractContinue(
      String lastUpdate, int profileTabID, BuildContext blocContext,{ String keySearch = "",
  int categoryId = 0, String objectId = "0"}) async {
    if (isFakeData) {
      return _fakeData.getListContractContinue(
          lastUpdate, profileTabID, blocContext);
    }
    //int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    String userId = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "";
    ApiResponse response = await _apiProvider.getListContractContinue(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        lastUpdate,
        profileTabID, keySearch, categoryId, objectId);
    if (response.isOk) {
      String object = jsonEncode(response.object['data']);
      List<ContractDocFrom> list = parseListContractsFrom(object, userId);
      // debugPrint(" getListContractContinue lastUpdate === $lastUpdate  legnht list ${list.length}   legnht end ${list.last.contractGuid}");
      // save lai vao db de dung offline
      // EContractDb.instance.insertMultipleContractFromEntries(list);
      // for (var element in list) {
      //   EContractDb.instance.createOrUpdateCreator(element.creator!);
      //   EContractDb.instance.createOrUpdateButtonShow(element.buttonShow!);
      //   EContractDb.instance
      //       .insertMultipleSignersEntries(element.signers ?? []);
      //   EContractDb.instance
      //       .insertMultipleTextDetailEntries(element.listextDetail ?? []);
      //   for (var signer in element.listextDetail ?? []) {
      //     EContractDb.instance
      //         .insertMultipleSignersEntries(signer.profileItemSigner);
      //   }
      // }
      // save lai vao db de dung end
      return list;
    }
    return [];
  }

  @override
  Future<List<ContractDocTo>> getListContractToContinue(
      String lastUpdate, int profileTabID, BuildContext blocContext, { String keySearch = "",
        int categoryId = 0, String objectId = "0"}) async {
    if (isFakeData) {
      return _fakeData.getListContractToContinue(
          lastUpdate, profileTabID, blocContext);
    }
    //int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    String userId = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "";
    ApiResponse response = await _apiProvider.getListContractContinue(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        lastUpdate,
        profileTabID, keySearch, categoryId, objectId);
    if (response.isOk) {
      String object = jsonEncode(response.object['data']);
      // if(parseListContractsTo(object, userId).isNotEmpty){
      //   (await SharedPrefs.instance()).setString(SharedPreferencesKey.lastUpdate, parseListContractsTo(object, userId).last.lastUpdate??"");
      // }
      return parseListContractsTo(object, userId);
    }
    return [];
  }

  @override
  Future<SignContractInfo> sendOTP(String profileGuid, int type) async {
    if (isFakeData) {
      return _fakeData.sendOTP(profileGuid,type);
    }
    ApiResponse response = await _apiProvider.sendOTP(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        profileGuid, type);
    // if (!response.isOk || response.status == -1 || response.status == 1) {
    //    DiaLogManager.showDialogHTTPError(
    //       status: response.isOk ? 200 : response.status,
    //       resultStatus: response.status,
    //       resultObject: response.object);
    //   return const SignContractInfo(
    //       otpExpriedTime: "", otpDue: 0, phoneNumber: "", errorMessage: "");
    // }
    // if (response.isOk && response.status == 0) {
    //   return SignContractInfo.fromJson(response.object);
    // }

    if (response.isOk) {
      return SignContractInfo.fromJson(response.object);
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return const SignContractInfo(
            otpExpriedTime: "", otpDue: 0, phoneNumber: "", errorMessage: "");
      } else {
        return SignContractInfo(
            otpExpriedTime: "",
            otpDue: 0,
            phoneNumber: "",
            errorMessage: jsonEncode(response.object));
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return const SignContractInfo(
          otpExpriedTime: "", otpDue: 0, phoneNumber: "", errorMessage: "");
    }
  }
  @override
  Future<ContractSignInfo> sendOtpByTokenHsm(String profileGuid, String tokenHsm) async {
    if (isFakeData) {
      return _fakeData.sendOtpByTokenHsm(profileGuid,tokenHsm);
    }
    ApiResponse response = await _apiProvider.sendOtpByTokenHsm(
        tokenHsm,
        profileGuid);

    if (response.isOk) {
      return ContractSignInfo(response.object["profileCode"], response.object["signerName"], response.object["signDate"], "","");
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return ContractSignInfo("", "", "", "","");
      } else {
        return ContractSignInfo("", "", "", jsonEncode(response.object),"");
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return ContractSignInfo("", "", "", "","");
    }
  }

  @override
  Future<ContractSignInfo> confirmOTP(
      String profileGuid, String otp, bool isFrom, int type) async {
    if (isFakeData) {
      return _fakeData.confirmOTP(profileGuid, otp, isFrom, type);
    }
    ApiResponse response = await _apiProvider.confirmOTP(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        profileGuid,
        otp,
        isFrom,
        type);
    if (response.isOk) {
      //Bkav HoangLD vì hình thức ký là otp thì không trả về tokenHSM nên tách các trường hợp
      if(type == ContractConstants.hsmSign){
        return ContractSignInfo.fromJson(response.object);
      }else{
        return ContractSignInfo(response.object["profileCode"], response.object["signerName"], response.object["signDate"], "","");
      }
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return ContractSignInfo("", "", "", "","");
      } else {
        return ContractSignInfo("", "", "", jsonEncode(response.object),"");
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return ContractSignInfo("", "", "", "","");
    }
  }

  @override
  Future<ContractSignInfo> confirmOTPEKYC(
      String profileGuid, String otp) async {
    if (isFakeData) {
      return _fakeData.confirmOTPEKYC(profileGuid, otp);
    }
    ApiResponse response = await _apiProvider.confirmOTPEKYC(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        profileGuid,
        otp);
    if (response.isOk) {
      return ContractSignInfo("", "", "", "",response.object['tokenEKYC']);
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return ContractSignInfo("", "", "", "","");
      } else {
        return ContractSignInfo("", "", "", jsonEncode(response.object),"");
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return ContractSignInfo("", "", "", "","");
    }
  }

  @override
  Future<ApiResponse> postRejectReason(
      String objectGuid, String reasonReject) async {
    if (isFakeData) {
      return _fakeData.postRejectReason(objectGuid, reasonReject);
    }
    ApiResponse response = await _apiProvider.reject(objectGuid, reasonReject,
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization");
    return response;
  }

  @override
  Stream<List<NotificationEntity>> getListNotification(int currentPage) async* {
    if (isFakeData) {
      yield* _fakeData.getListNotification(currentPage);
      return;
    }
    yield listNotifyCache;
    // HanhNTHe lay gia tri tu database
    List<NotificationEntity> notificationsData = [];
    // neu la lay moi thi lay 20 du lieu tu data ra hien thi
    //int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    String userId = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "";
    int pageSize = 20;
    notificationsData = await EContractDb.instance
        .getNotifications(userId, (currentPage - 1) * pageSize, pageSize)
        .get();
    yield notificationsData;

    ApiResponse response = await _apiProvider.getListNotification(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        currentPage,
        pageSize);

    List<NotificationEntity> notificationsApi = [];
    if (response.isOk) {
      String object = jsonEncode(response.object);
      notificationsApi = parseListNotification(object ,userId);
    }

    if (notificationsApi.isNotEmpty) {
      listNotifyCache = notificationsApi;
      yield notificationsApi;
    } else if (notificationsData.isNotEmpty) {
      listNotifyCache = notificationsData;
      yield notificationsData;
    } else {
      // trong truong hop ca data va api khong co du lieu
      yield [];
    }

    // save data
    await EContractDb.instance.insertMultipleNotificationEntries(notificationsApi);
    // -end
  }

  List<NotificationEntity> parseListNotification(String data ,String userId) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    return parsed
        .map<NotificationEntity>((json) => NotificationEntity.fromJson(json,userId))
        .toList();
  }

  @override
  Future<SupportInfo> getListSupport() async {
    if (isFakeData) {
      return _fakeData.getListSupport();
    }
    ApiResponse response = await _apiProvider.getListSupport(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization");
    if (response.isOk) {
      (await SharedPrefs.instance()).setBool(SharedPreferencesKey.callApiError, true);
      (await SharedPrefs.instance()).setStringList(SharedPreferencesKey.listSupport, SupportInfo.fromJson(response.object).url);
      return SupportInfo.fromJson(response.object);
    } else {
      (await SharedPrefs.instance()).setBool(SharedPreferencesKey.callApiError, false);
    }
    // Bkav HanhNTHe: khong can hien thi dialog vi chay ngam
    // else {
    //    DiaLogManager.showDialogHTTPError(
    //       status: response.isError ? 200 : response.status,
    //       resultStatus: response.status,
    //       resultObject: response.object);
    // }
    return const SupportInfo([]);
  }

  @override
  Future<void> updateNotificationStatusViewed(
      {NotificationEntity? notificationEntity,
      String? notifyGuid,
      int? total}) async {
    if (isFakeData) {
      return _fakeData.updateNotificationStatusViewed();
    }
    ApiResponse response = await _apiProvider.updateNotifyStatusViewed(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        notificationEntity != null
            ? notificationEntity.objectGuid
            : notifyGuid ?? "");
    if (response.isOk /*&& notificationEntity != null*/) {

    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
      }
    }
    EContractDb.instance.updateClickNotification(
        notificationEntity != null
            ? notificationEntity.objectGuid
            : notifyGuid ?? "");
    if (total != null) {
      EContractDb.instance.updateTotalUnReadNumber(
          (await SharedPrefs.instance()).getString(SharedPreferencesKey.userNameUnit) ?? "", total);
    }
    return;
  }

  @override
  Future<void> updateNotificationStatusReceived(String notifyGuid) async {
    if (isFakeData) {
      return _fakeData.updateNotificationStatusReceived(notifyGuid);
    }
    ApiResponse response = await _apiProvider.updateNotifyStatusReceive(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        notifyGuid);
    if(!response.isOk){
      Logger.logError("Loi cap nhat thong bao status ${response.status} object: ${response.object}");
    }
    return;
  }

  @override
  Future<ChangePasswordInfo> changePassword(
      String passwordOld, String passwordNew) async {
    if (isFakeData) {
      return _fakeData.changePassword(passwordOld, passwordNew);
    }
    ApiResponse response = await _apiProvider.changePassword(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        passwordOld,
        passwordNew);
    if (response.status == -1) {
      DiaLogManager.showDialogHTTPError(
          status: 200,
          resultStatus: response.status,
          resultObject: response.object);
      return ChangePasswordInfo(reasonError: "", isOk: response.isOk);
    }
    return ChangePasswordInfo(
        reasonError: response.object, isOk: response.isOk);
  }

  @override
  Future<void> updateTokenFirebase() async {
    if (isFakeData) {
      return _fakeData.updateTokenFirebase();
    }
    int userId = (await SharedPrefs.instance()).getInt(SharedPreferencesKey.userId) ?? -1;
    UserInfo userInfo =
        await EContractDb.instance.singleUser(userId).getSingle();
    _apiProvider.updateTokenInfo(userInfo.objectGuid ?? "",
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "");
  }

  @override
  Stream<bool> countDownTimer(bool countTimeDown) async* {
    yield countTimeDown;
  }

  @override
  Future<bool> sendLogApp(
      File fileLogError, File fileLogActivity, File fileLogOther) async {
    if (isFakeData) {
      return _fakeData.sendLogApp(fileLogError, fileLogActivity, fileLogOther);
    }
    ApiResponse response = await _apiProvider.sendLogApp(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenFirebase) ?? "",
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.keyUUID) ?? "",
        fileLogError,
        fileLogActivity,
        fileLogOther);
    //Bkav HoangLD Dialog báo lỗi  send log
    if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
      }
    }
    return response.isOk;
  }

  @override
  Future<SignHSMContractInfo> signHSM(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.signHSM(objectGuid);
    }
    ApiResponse response = await _apiProvider.signHSM(
        (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "Authorization",
        objectGuid);
    if (response.isOk) {
      return SignHSMContractInfo(status: response.status,
          reasonError: response.object, isOk: response.isOk);
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return SignHSMContractInfo(status: response.status,
            reasonError: response.object, isOk: response.isOk);
      } else {
        return SignHSMContractInfo(status: response.status,
            reasonError: response.object, isOk: response.isOk);
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return SignHSMContractInfo(status: response.status,
          reasonError: response.object, isOk: response.isOk);
    }
  }

  @override
  Future<String> signRemoteSigning(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.signRemoteSigning(objectGuid);
    }
    ApiResponse response = await _apiProvider.remoteSigningRequestSign(objectGuid);
    if (response.isOk) {
      return response.object['transactionGuid'];
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return "";
      } else {
        return "";
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return "";
    }
  }

  @override
  Future<RemoteSigningSuccess?> getResultRemoteSigning(String transactionGuid) async {
    if (isFakeData) {
      return _fakeData.getResultRemoteSigning(transactionGuid);
    }
    ApiResponse response = await _apiProvider.remoteSigningResultSign(transactionGuid);
    if (response.isOk) {
      return RemoteSigningSuccess.fromJson(response.object);
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
    }
    return null;
  }

  @override
  Future<int> cancelRemoteSigning(String transactionGuid) async{
    if (isFakeData) {
      return _fakeData.cancelRemoteSigning(transactionGuid);
    }
    ApiResponse response = await _apiProvider.remoteSigningCancelSign(transactionGuid);
    if (response.isOk) {
      return -1 ;
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return -1;
      } else {
        return -1;
      }
    } else {
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return -1;
    }
  }

  @override
  Future<RemoteSigningSuccess?> signRemoteSigningTemp(String objectGuid) async {
    if (isFakeData) {
      return _fakeData.signRemoteSigningTemp(objectGuid);
    }
    ApiResponse response = await _apiProvider.remoteSigningSignTemp(objectGuid);
    if (response.isOk) {
      // print(" signRemoteSigningTemp ${response.object}");
      if(response.object['status'] == 0){
        return RemoteSigningSuccess.fromJson(response.object);
      } else if(response.object['status'] == 1) {
        if(SignFormPage.isDialogShow){
          Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
          SignFormPage.isDialogShow = false;
        }
        // show dialog hien thi loi
        DiaLogManager.displayCancelRemoteSigningDialog(
            NavigationService.navigatorKey.currentContext!, false, () {},
            isError: true, msg: response.object['msg']);
      } else if (response.object['status'] == 5) {
        // Loi nguoi dung k bam xac thuc tren he thong ky
        return RemoteSigningSuccess(
            signerName: "",
            signDate: "",
            profileCode: "",
            transactionRemoteSignStatus: 5);
      } else if (response.object['status'] == 6) {
        // Loi nguoi dung tu choi xac thuc ky tren remote signing
        return RemoteSigningSuccess(
            signerName: "",
            signDate: "",
            profileCode: "",
            transactionRemoteSignStatus: 6);
      }
    } else if (response.isError) {
      if (SignFormPage.isDialogShow) {
        Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
        SignFormPage.isDialogShow = false;
      }
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
        return null;
      }
    } else {
      if(SignFormPage.isDialogShow){
        Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
        SignFormPage.isDialogShow = false;
      }
      DiaLogManager.showDialogHTTPError(
          status: response.status,
          resultStatus: response.status,
          resultObject: response.object);
      return null;
    }
    return null;
  }

  @override
  Future<int> getTimeCallRS() async {
    if (isFakeData) {
      return _fakeData.getTimeCallRS();
    }
    ApiResponse response = await _apiProvider.remoteSigningGetTime();
    // print(' getTimeCallRS ${response.object.toString()}');
    if (response.isOk) {
      return response.object;
    } else if (response.isError) {
      if (response.status == -1 || response.status == 1) {
        DiaLogManager.showDialogHTTPError(
            status: 200,
            resultStatus: response.status,
            resultObject: response.object);
      } else {
        DiaLogManager.showDialogHTTPError(
            status: response.status,
            resultStatus: response.status,
            resultObject: response.object);
      }
    }
    return -1;
  }
}
