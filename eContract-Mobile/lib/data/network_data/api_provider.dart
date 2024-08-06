import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_contract/data/network_data/api_reponse.dart';
import 'package:e_contract/data/network_data/dio_utils.dart';
import 'package:e_contract/utils/constants/api_constains.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:dio/src/response.dart';
import 'package:http/http.dart' as http;
import 'package:e_contract/flavors.dart';


/// Cac log lay du lieu tu api
class ApiProvider {


  final domainApi = F.domainApi;

  final Duration timeOut = const Duration(seconds: 20);
  final http.Response timeOutResult =
      http.Response("", 600); // statusCode = 600

  Future<ApiResponse> login(
      String userName, String password, bool isRemember, String? token ,String objectGuid, String clientID) async {
    Logger.loggerDebug("login username $userName pass: $password");
    // goi ham log in tai day
    try {
      var dio = await DioUtil.createDio();
      if(objectGuid ==""){
        Response response = await dio.post(ApiConstants.unEncodedPathLogin,
            data: {
              "username": userName,
              "password": password,
              "clientID":clientID,
              "token": "string",
              "isRememberPassword": isRemember,
              "recaptchaResponse": "string",
            });
        return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
      }else{
        Response response = await dio.post(ApiConstants.unEncodedPathLogin,
            data: {
              "username": userName,
              "password": password,
              "clientID":clientID,
              "token": "string",
              "isRememberPassword": isRemember,
              "recaptchaResponse": "string",
              "unitGuid":objectGuid
            });
        return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
      }

    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("login error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(511, "", false, true);
      }
    }
      // var client = http.Client();
      // final reponse = await client
      //     .post(
      //         Uri.https(
      //             domainApi, ApiConstants.unEncodedPathLogin),
      //         headers: {"Content-Type": "application/json"},
      //         body: jsonEncode(<String, dynamic>{
      //           "username": userName,
      //           "password": password,
      //           "token": "string",
      //           "isRememberPassword": isRemember,
      //           "recaptchaResponse": "string"
      //         }))
      //     .timeout(timeOut, onTimeout: () => timeOutResult);
      // int statusCode = reponse.statusCode;
      // if (statusCode == 200) {
      //   var body = json.decode(reponse.body);
      //   return ApiResponse.fromJson(body);
      // } else {
      //   Logger.logError("login error statusCode: $statusCode");
      //   return ApiResponse(
      //       reponse.statusCode, "Error statusCode ($statusCode)", false, false);
      // }
  }

  Future<ApiResponse> logout(String token) async {
    // goi ham log out tai day
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathLogout);
      return ApiResponse(response.data["status"], response.data["object"], false, false);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(511, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("logout error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.get(
    //       Uri.https(domainApi, ApiConstants.unEncodedPathLogout),
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Authorization": token
    //       }).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("logout error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("logout exception: (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  /// Bkav HoangLD API update time
  Future<ApiResponse> updateLastTimeOpen() async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodeUpdateLastTimeOpen);
      return ApiResponse(response.data["status"], response.data["object"], false, false);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(511, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("logout error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }
  /// Bkav HoangLD API bag number
  Future<ApiResponse> getBagNumber() async {
    try {
      //final prefs = await SharedPreferences.getInstance();
      final tokenFirebase = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenFirebase);
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodeGetBagNumber,
          data: {
        "tokenFirebase": tokenFirebase
      });
      return ApiResponse(response.data["status"], response.data["object"], false, false);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(511, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("logout error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }
  /// Bkav HanhNTHe: get danh sach ho so di
  Future<ApiResponse> getListContracts(
      String token, int pageSize, int profileTabId) async {
    // goi ham lay danh sach ho so di tai day
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathEasySearchApp,
          data: {
            "profileTabId": profileTabId,
            "keySearch": "",
            "categoryId": 0,
            "objectId": "",
            "currentPage": 1,
            "pageSize": 20
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getListContracts error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client
    //       .post(
    //           Uri.https(domainApi,
    //               ApiConstants.unEncodePathEasySearchApp),
    //           //Bkav Nhungltk: update API moi
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "profileTabId": profileTabId,
    //             "keySearch": "",
    //             "categoryId": 0,
    //             "objectId": "",
    //             "currentPage": 1,
    //             "pageSize": 20
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getListContracts error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getListContracts exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  /// HoangLD : lấy ra danh sách ký
  Future<ApiResponse> getListTypeSignOfProfile( String objectGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathGetTypeList,
          queryParameters: {
            "ObjectGuid": objectGuid,
            "IsApp": true
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getDetailContract error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
  }

  /// HoangLD : lấy accessTokenEKYC
  Future<ApiResponse> getAccessTokenEKYC( String objectGuid, String tokenEKYC) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodeGetAccessTokenEKYC,
          queryParameters: {
            "ProfileGuid": objectGuid,
            "TokenEKYC": tokenEKYC
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getAccessTokenEKYC error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  /// Bkav HoangLD : Api ký ekyc
  Future<ApiResponse> signEKYC(
      String objectGuid, String transactionId, String tokenEKYC) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodeSignEKYC,
          data: {
            "profileGuid": objectGuid,
            "TokenEKYC": tokenEKYC,
            "transactionId": transactionId
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("signEKYC error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  /// Bkav HanhNTHe: xem chi tiet 1 ho so
  Future<ApiResponse> getDetailContract(String token, String objectGuid) async {
    // goi ham lay danh sach ho so di tai day
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathViewDetail,
          queryParameters: {
            "objectGuid": objectGuid
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getDetailContract error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.get(
    //     Uri.https(domainApi, ApiConstants.unEncodedPathViewDetail,
    //         {"objectGuid": objectGuid}),
    //     headers: {
    //       "Content-Type": "application/json",
    //       "Authorization": token,
    //       // "objectGuid": objectGuid
    //     },
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   // debugPrint(" getDetailContract $statusCode");
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getDetailContract error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getDetailContract exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  /// Bkav HanhNTHe: xem chi tiet 1 ho so day du theo api app
  Future<ApiResponse> getDetailContractApp(
      String token, String objectGuid) async {
    // goi ham lay danh sach ho so di tai day
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathViewDetailApp,
          queryParameters: {
            "profileGuid": objectGuid
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getDetailContractApp error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.get(
    //     Uri.https(
    //         domainApi,
    //         ApiConstants.unEncodedPathViewDetailApp,
    //         {"profileGuid": objectGuid}),
    //     headers: {
    //       "Content-Type": "application/json",
    //       "Authorization": token,
    //       // "objectGuid": objectGuid
    //     },
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   // debugPrint(" getDetailContract $statusCode");
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getDetailContractApp error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getDetailContractApp exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  ///Bkav Nhungltk: xem noi dung van ban
  Future<ApiResponse> getDoccumentContent(
      String token, String objectGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodePathProfileText,
          queryParameters: {
            'profileTextGuid': objectGuid
      });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getDoccumentContent error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
    // try {
    //   var client = http.Client();
    //   final parameter = {'profileTextGuid': objectGuid};
    //   final repose = await client.get(
    //     Uri.https(domainApi, ApiConstants.unEncodePathProfileText,
    //         parameter),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = repose.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(repose.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getDoccumentContent error statusCode ($statusCode)");
    //     return ApiResponse(
    //         repose.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getDoccumentContent exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  /// Bkav HanhNTHe: xem lich su cua 1 ho so
  Future<ApiResponse> showHistoryAContract(
      String token, String objectGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathHistoryAProfile,
          data: {
            "objectGuid": objectGuid,
            "pageNumber": 1,
            "pageSize": 20
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("showHistoryAContract error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
    // try {
    //   var client = http.Client();
    //   final repose = await client
    //       .post(
    //           Uri.https(domainApi,
    //               ApiConstants.unEncodePathHistoryAProfile),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "objectGuid": objectGuid,
    //             "pageNumber": 1,
    //             "pageSize": 20
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = repose.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(repose.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("showHistoryAContract error statusCode ($statusCode)");
    //     return ApiResponse(
    //         repose.statusCode, "Error statusCode ($statusCode)", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("showHistoryAContract exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  /// Bkav HanhNTHe: xem link dia chi de copy
  Future<ApiResponse> showCopyAddress(String token, String objectGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodePathCopyAddress,
          queryParameters : {
            "profileGuid": objectGuid
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("showCopyAddress error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
    // try {
    //   var client = http.Client();
    //   final repose = await client.get(
    //     Uri.https(domainApi, ApiConstants.unEncodePathCopyAddress,
    //         {"profileGuid": objectGuid}),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = repose.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(repose.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("showCopyAddress error statusCode ($statusCode)");
    //     return ApiResponse(
    //         repose.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("showCopyAddress exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> suggestSearchContract(
      String token, String keyWord, bool isForm) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodePathSuggestSearchContractFrom,
          queryParameters : {
            "keySearch": keyWord
      });
      if (!isForm) {
        response = await dio.get(ApiConstants.unEncodePathSuggestSearchContractTo,
            queryParameters : {
              "keySearch": keyWord
            });
      }
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("suggestSearchContract error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   var repose = await client.get(
    //     Uri.https(
    //         domainApi,
    //         ApiConstants.unEncodePathSuggestSearchContractFrom,
    //         {"keySearch": keyWord}),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   if (!isForm) {
    //     repose = await client.get(
    //       Uri.https(
    //           domainApi,
    //           ApiConstants.unEncodePathSuggestSearchContractTo,
    //           {"keySearch": keyWord}),
    //       headers: {"Content-Type": "application/json", "Authorization": token},
    //     );
    //   }
    //   int statusCode = repose.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(repose.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("suggestSearchContract error statusCode ($statusCode)");
    //     return ApiResponse(
    //         repose.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("suggestSearchContract exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> checkToken(String token) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathEasySearchApp,
          data: {
            "profileTabId": 1,
            "keySearch": "",
            "categoryId": 1,
            "objectId": "",
            "currentPage": 1,
            "pageSize": 1
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("checkToken error statusCode: ${e.response!.statusCode}");
        return ApiResponse(-1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(-1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //
    //   final response = await client
    //       .post(
    //           Uri.https(domainApi,
    //               ApiConstants.unEncodePathEasySearchApp),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "profileTabId": 1,
    //             "keySearch": "",
    //             "categoryId": 1,
    //             "objectId": "",
    //             "currentPage": 1,
    //             "pageSize": 1
    //           }))
    //       .timeout(const Duration(seconds: 3));
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("checkToken error statusCode ($statusCode)");
    //     return ApiResponse(-1, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("checkToken exception (${e.toString()})");
    //   return ApiResponse(-1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> getResultSearchContract(String token, String keySearch,
      int categoryId, String objectId, int profileTabID, int pagesize) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathEasySearchApp,
          data: {
            "profileTabId": profileTabID,
            "keySearch": keySearch,
            "categoryId": categoryId,
            "objectId": objectId,
            "currentPage": 1,
            "pageSize": pagesize
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getResultSearchContract error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //
    //   final response = await client
    //       .post(
    //           Uri.https(domainApi,
    //               ApiConstants.unEncodePathEasySearchApp),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "profileTabId": profileTabID,
    //             "keySearch": keySearch,
    //             "categoryId": categoryId,
    //             "objectId": objectId,
    //             "currentPage": 1,
    //             "pageSize": pagesize
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getResultSearchContract error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getResultSearchContract exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> getListContractContinue(
      String token, String lastUpdate, int profileTabID, String keySearch,
        int categoryId, String objectId) async {
    try {
      var dio = await DioUtil.createDio();
      Response response;
      if(lastUpdate ==""){
         response = await dio.post(ApiConstants.unEncodePathGetlistByLastUpdateApp,
            data: {
              "keySearch": keySearch,
              "categoryId": categoryId,
              "objectId": objectId,
              "profileTabId": profileTabID,
              "currentPage": 1,
              "pageSize": 20,
            });
      }else{
         response = await dio.post(ApiConstants.unEncodePathGetlistByLastUpdateApp,
            data: {
              "keySearch": keySearch,
              "categoryId": categoryId,
              "objectId": objectId,
              "profileTabId": profileTabID,
              "currentPage": 1,
              "pageSize": 20,
              "lastUpdate": lastUpdate
            });
      }
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getListContractContinue error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client
    //       .post(
    //           Uri.https(domainApi,
    //               ApiConstants.unEncodePathGetlistByLastUpdateApp),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "profileTabId": profileTabID,
    //             "currentPage": 1,
    //             "pageSize": 20,
    //             "lastUpdate": lastUpdate
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getListContractContinue error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getListContractContinue excetion (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  ///Bkav Nhungltk: send OTP
  Future<ApiResponse> sendOTP(String token, String profileGuid, int type) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathSendOtp,
          data: {
            "profileGuid": profileGuid,
            "type": type,
            "captchaCode": ""
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("sendOTP error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client
    //       .post(
    //           Uri.https(
    //               domainApi, ApiConstants.unEncodePathSendOtp),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "profileGuid": profileGuid,
    //             "type": 1,
    //             "captchaCode": ""
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("sendOTP error statusCde ($statusCode)");
    //     return ApiResponse(response.statusCode, "$statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("sendOTP exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }
  ///Bkav HoangLD: send OTP by tokenHSM
  Future<ApiResponse> sendOtpByTokenHsm(String tokenHSM ,String profileGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathSendOtpByTokenHsm,
          data: {
            "profileGuid": profileGuid,
            "tokenHSM": tokenHSM,
            "captchaCode": ""
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("sendOTP error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }
  ///Bkav HoangLD: signHSM
  Future<ApiResponse> signHSM(String token, String profileGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathSendOtp,
          data: {
            "objectGuid": profileGuid,
            "type": 2,
            "captchaCode": ""
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("signHSM error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client
    //       .post(
    //       Uri.https(
    //           domainApi, ApiConstants.unEncodePathSignHSM),
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Authorization": token
    //       },
    //       body: jsonEncode(<String, dynamic>{
    //         "objectGuid": profileGuid,
    //         "type": 1,
    //         "captchaCode": ""
    //       }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("signHSM error statusCde ($statusCode)");
    //     return ApiResponse(response.statusCode, "$statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("signHSM exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> confirmOTP(
      String token, String profileGuid, String otp, bool isFrom, int type) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathConfirmOTP,
          data: {
            "profileGuid": profileGuid,
            "type": type,
            "otp": otp,
            "captchaCode": "",
            "isFrom": isFrom
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("confirmOTP error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client
    //       .post(
    //           Uri.https(
    //               domainApi, ApiConstants.unEncodePathConfirmOTP),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "profileGuid": profileGuid,
    //             "type": 1,
    //             "otp": otp,
    //             "captchaCode": "",
    //             "isFrom": isFrom
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("confirmOTP error statusCode ($statusCode)");
    //     return ApiResponse(response.statusCode, "$statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("confirmOTP exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> confirmOTPEKYC(
      String token, String profileGuid, String otp) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodePathConfirmOTPEKYC,
          data: {
            "profileGuid": profileGuid,
            "type": 16,
            "otp": otp,
          });
      debugPrint(
          " response ================ $response");
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("confirmOTP error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  ///Bkav HanhNTHe: api lay thoi gian tu server de so sanh voi thoi gian app
  Future<ApiResponse> getTimeToServer(String token) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodePathGetTimeToSever);
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getTimeToServer error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.get(
    //       Uri.https(
    //           domainApi, ApiConstants.unEncodePathGetTimeToSever),
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Authorization": token
    //       });
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getTimeToServer error statusCode ($statusCode)");
    //     return ApiResponse(1, "$statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getTimeToServer exceiption (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> updateTokenInfo(String userID, String token) async {
    try {
      //final prefs = await SharedPreferences.getInstance();
      final tokenFirebase = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenFirebase);
      final uuid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.keyUUID);
      /*final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final mapDeviceInfo = deviceInfo.toMap();*/
      //Logger.loggerDebug("Bkav DucLQ Device info $jsonEncode(mapDeviceInfo)");
      if(tokenFirebase == null || uuid == null){
        return ApiResponse(1, "token firebase not null", false, false);
      }
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodeUpdateTokenFireBase,
          data: {
            "userGuid": userID,
            "uuid": uuid,
            "tokenFirebase": tokenFirebase,
            "deviceId": "",
            "os": Platform.isIOS ? "IOS" : "Android"
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("updateTokenInfo error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   final tokenFirebase = prefs.getString(SharedPreferencesKey.tokenFirebase);
    //   final uuid = prefs.getString(SharedPreferencesKey.keyUUID);
    //   /*final deviceInfoPlugin = DeviceInfoPlugin();
    //   final deviceInfo = await deviceInfoPlugin.deviceInfo;
    //   final mapDeviceInfo = deviceInfo.toMap();*/
    //   //Logger.loggerDebug("Bkav DucLQ Device info $jsonEncode(mapDeviceInfo)");
    //   if(tokenFirebase == null || uuid == null){
    //     return ApiResponse(1, "token firebase not null", false, false);
    //   }
    //
    //   var client = http.Client();
    //   final response = await client
    //       .post(
    //           Uri.https(domainApi,
    //               ApiConstants.unEncodeUpdateTokenFireBase),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "userGuid": userID,
    //             "uuid": uuid,
    //             "tokenFirebase": tokenFirebase,
    //             "deviceId": "",
    //             "os": Platform.isIOS ? "IOS" : "Android"
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //
    //     ApiResponse  apiResponse = ApiResponse.fromJson(body);
    //     if(!apiResponse.isOk){
    //       Logger.logError("Update token firebase khong thanh cong ${apiResponse.status} object ${apiResponse.object}");
    //     }
    //     return apiResponse;
    //   } else {
    //     Logger.logError("updateTokenInfo error statusCode ($statusCode)");
    //     return ApiResponse(response.statusCode, "$statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("updateTokenInfo exception ()${e.toString()}");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  ///Bkav TungDV: post lý do từ chối ký hồ sơ
  Future<ApiResponse> reject(
      String objectGuid, String reasonReject, String token) async {
    // goi ham Reject in tai day
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodedPathReject,
          data: {
            "objectGuid": objectGuid,
            "reasonReject": reasonReject,
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("reject error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final reponse = await client
    //       .post(
    //           Uri.https(
    //               domainApi, ApiConstants.unEncodedPathReject),
    //           headers: {
    //             "Content-Type": "application/json",
    //             "Authorization": token
    //           },
    //           body: jsonEncode(<String, dynamic>{
    //             "objectGuid": objectGuid,
    //             "reasonReject": reasonReject,
    //           }))
    //       .timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = reponse.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(reponse.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("reject error statusCode ($statusCode)");
    //     return ApiResponse(
    //         reponse.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("reject exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  ///Bkav TungDV Api lấy ds thông báo
  Future<ApiResponse> getListNotification(
      String token, int currentPage, int pageSize) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathGetListNotification,
          queryParameters: {
            'PageSize': '$pageSize',
            'CurrentPage': '$currentPage'
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getListNotification error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   var queryParameters = {
    //     'PageSize': '$pageSize',
    //     'CurrentPage': '$currentPage',
    //   };
    //   final response = await client.get(
    //     Uri.https(domainApi,
    //         ApiConstants.unEncodedPathGetListNotification, queryParameters),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   // debugPrint(" getList Notify ${response.statusCode} ${response.body}");
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("getListNotification error statusCode ($statusCode)");
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("getListNotification exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  ///Bkav HoangCV Api lấy ds hỗ trợ
  Future<ApiResponse> getListSupport(String token,
      ) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathSupport);
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("getListSupport error statusCode: ${e.response!.statusCode}");
        return ApiResponse(e.response!.statusCode!, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.get(
    //     Uri.https(domainApi,
    //         ApiConstants.unEncodedPathSupport),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   ).timeout(timeOut, onTimeout: () => timeOutResult);
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     return ApiResponse(
    //         response.statusCode, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> updateNotifyStatusViewed(
      String token,String notifyGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodedPathUpdateStatusViewed,
        queryParameters: {"NotifyGuid": notifyGuid});
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("updateNotifyStatusViewed error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.post(
    //     Uri.https(
    //         domainApi,
    //         ApiConstants.unEncodedPathUpdateStatusViewed,
    //         {"NotifyGuid": notifyGuid}),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   );
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("updateNotifyStatusViewed error statusCode ($statusCode)");
    //     return ApiResponse(1, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("updateNotifyStatusViewed exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> updateNotifyStatusReceive(
      String token,String notifyGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathUpdateStatusReceive,
          queryParameters: {"NotifyGuid": notifyGuid});
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("updateNotifyStatusReceive error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.post(
    //     Uri.https(
    //         domainApi,
    //         ApiConstants.unEncodedPathUpdateStatusReceive,
    //         {"NotifyGuid": notifyGuid}),
    //     headers: {"Content-Type": "application/json", "Authorization": token},
    //   );
    //   int statusCode = response.statusCode;
    //   Logger.logActivity("updateNotifyStatusReceive ${response.statusCode} ${response.body} --- $notifyGuid");
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("updateNotifyStatusReceive error statusCode ($statusCode)");
    //     return ApiResponse(1, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("updateNotifyStatusReceive exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> changePassword(
      String token, String passwordOld, String passwordNew) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.post(ApiConstants.unEncodedPathChangePassword,
          data: {
            "passwordOld": passwordOld,
            "passwordNew": passwordNew,
          });
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("changePassword error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
    // try {
    //   var client = http.Client();
    //   final response = await client.post(
    //       Uri.https(
    //           domainApi, ApiConstants.unEncodedPathChangePassword),
    //       headers: {"Content-Type": "application/json", "Authorization": token},
    //       body: jsonEncode(<String, dynamic>{
    //         "passwordOld": passwordOld,
    //         "passwordNew": passwordNew,
    //       }));
    //   int statusCode = response.statusCode;
    //   if (statusCode == 200) {
    //     var body = json.decode(response.body);
    //     return ApiResponse.fromJson(body);
    //   } else {
    //     Logger.logError("changePassword error statusCode ($statusCode)");
    //     return ApiResponse(1, "Error statusCode $statusCode", false, false);
    //   }
    // } catch (e) {
    //   Logger.logError("changePassword exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> sendLogApp(String token, String tokenFirebase, String uuid,  File fileLogError, File fileLogActivity, File fileLogOther) async{
    try {
      var dio = await DioUtil.createDio();
      String logErrorName = fileLogError.path.split('/').last;
      String logActivityName = fileLogActivity.path.split('/').last;
      String logOtherName = fileLogOther.path.split('/').last;

      var formData = FormData.fromMap({
        'Tokenfirebase': tokenFirebase,
        'UUID': uuid
      });
      formData.files.addAll([
        MapEntry("", await MultipartFile.fromFile(fileLogError.path, filename:logErrorName)),
      ]);
      formData.files.addAll([
        MapEntry("", await MultipartFile.fromFile(fileLogActivity.path, filename:logActivityName)),
      ]);      formData.files.addAll([
        MapEntry("", await MultipartFile.fromFile(fileLogOther.path, filename:logOtherName)),
      ]);
      Response response = await dio.post(ApiConstants.unEncodedPathInsertLog,
          data: formData);
      return ApiResponse(response.data["status"], response.data["object"], response.data["isOk"], response.data["isError"]);
    }on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("sendLogApp error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, true);
      } else {
        return ApiResponse(1, "", false, false);
      }
    }
    // try{
    //   var request = http.MultipartRequest('POST', Uri.https(domainApi, ApiConstants.unEncodedPathInsertLog));
    //   request.fields.addAll({
    //     'Tokenfirebase': tokenFirebase,
    //     'UUID': uuid
    //   });
    //   request.files.add(await http.MultipartFile.fromPath("", fileLogError.path));
    //   request.files.add(await http.MultipartFile.fromPath("", fileLogActivity.path));
    //   request.files.add(await http.MultipartFile.fromPath("", fileLogOther.path));
    //   request.headers.addAll({"Content-Type": "application/json", "Authorization": token});
    //   http.StreamedResponse reponse= await request.send();
    //   int statusCode= reponse.statusCode;
    //   Logger.loggerDebug("nhungltk send log: ${await reponse.stream.bytesToString()}");
    //   Logger.loggerDebug("$reponse");
    //   if(statusCode== 200){
    //     String object= await reponse.stream.bytesToString();
    //     return ApiResponse.fromJson(json.decode(object));
    //   }else{
    //     Logger.logError("sendLogApp error statusCode ($statusCode)");
    //     return ApiResponse(1, "Error statusCode $statusCode", false, false);
    //   }
    // }catch(e){
    //   Logger.logError("sendLogApp exception (${e.toString()})");
    //   return ApiResponse(1, e.toString(), false, false);
    // }
  }

  Future<ApiResponse> remoteSigningRequestSign(String profileGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathRemoteSigning,
          queryParameters: {"ProfileGuid": profileGuid});
      return ApiResponse(response.data["status"], response.data["object"],
          response.data["isOk"], response.data["isError"]);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("changePassword error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  Future<ApiResponse> remoteSigningResultSign(String transactionGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathGetResultSign,
          queryParameters: {"TransactionGuid": transactionGuid});
      return ApiResponse(response.data["status"], response.data["object"],
          response.data["isOk"], response.data["isError"]);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("changePassword error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  Future<ApiResponse> remoteSigningCancelSign(String transactionGuid) async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(ApiConstants.unEncodedPathCancelSign,
          queryParameters: {"TransactionGuid": transactionGuid});
      return ApiResponse(response.data["status"], response.data["object"],
          response.data["isOk"], response.data["isError"]);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500,
            resultStatus: 0,
            resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError("changePassword error statusCode: ${e.response!.statusCode}");
        return ApiResponse(1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  Future<ApiResponse> remoteSigningSignTemp(String profileGuid) async {
    try {
      var dio = await DioUtil.createDio(isSignRemoteSign: true);
      Response response = await dio.get(
          ApiConstants.unEncodedPathRemoteSigningSignTemp,
          queryParameters: {"ProfileGuid": profileGuid});
      // print(" remoteSigningSignTemp api ${response.toString()} $profileGuid");
      return ApiResponse(response.data["status"], response.data["object"],
          response.data["isOk"], response.data["isError"]);
    } on DioError catch (e) {
      // print(" remoteSigningSignTemp error ${e.toString()}");
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500, resultStatus: 0, resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError(
            "changePassword error statusCode: ${e.response!.statusCode}");
        return ApiResponse(
            1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }

  Future<ApiResponse> remoteSigningGetTime() async {
    try {
      var dio = await DioUtil.createDio();
      Response response = await dio.get(
          ApiConstants.unEncodedPathGetTimeCallRS);
      // print(" remoteSigningSignTemp api ${response.toString()} $profileGuid");
      return ApiResponse(response.data["status"], response.data["object"],
          response.data["isOk"], response.data["isError"]);
    } on DioError catch (e) {
      // print(" remoteSigningSignTemp error ${e.toString()}");
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        DiaLogManager.showDialogHTTPError(
            status: 500, resultStatus: 0, resultObject: "");
        return ApiResponse(1, "", false, false);
      }
      if (e.response != null) {
        Logger.logError(
            "changePassword error statusCode: ${e.response!.statusCode}");
        return ApiResponse(
            1, "Error statusCode (${e.response!.statusCode!})", false, false);
      } else {
        return ApiResponse(1, "", false, true);
      }
    }
  }
}
