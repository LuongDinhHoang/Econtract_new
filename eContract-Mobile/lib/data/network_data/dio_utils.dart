import 'package:dio/dio.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/flavors.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/utils/constants/api_constains.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

///HoangLD : thu vien dio de call api
class DioUtil {
  static String domainApi = F.domainApi;

  static String baseUrl = 'https://$domainApi';
  static const Duration timeOut = Duration(milliseconds: 20000);

  static Future<Dio> createDio({bool? isSignRemoteSign /* do ky bang remote signing khong co timeout */}) async {
    var dio = Dio();
    var tokenDio = Dio();

    //final prefs = await SharedPreferences.getInstance();
    String token = (await SharedPrefs.instance()).getString(SharedPreferencesKey.token) ?? "";
    dio.options.baseUrl = baseUrl;
    dio.interceptors.clear();
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = token;
        options.contentType = Headers.jsonContentType;
        if(isSignRemoteSign == null){
          options.sendTimeout = timeOut;
          options.connectTimeout = timeOut;
          options.receiveTimeout = timeOut;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async{
        //Bkav HoangLD check Api status = -1 thì thực hiện refreshToken mới
        if(response.data["status"] == -1){
          //final prefs = await SharedPreferences.getInstance();
          final refreshToken = (await SharedPrefs.instance()).getString(SharedPreferencesKey.refreshToken)??"";
          final uuid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.keyUUID);
          if(refreshToken != ""){
            try {
              final responseToken = await tokenDio.post(
                  baseUrl + ApiConstants.unEncodeGetAccessToken,
                  data: {
                    "refreshToken": refreshToken,
                    "clientID": uuid
                  },
                  options: Options(contentType: Headers.jsonContentType));
              var options = response.requestOptions;
              if(responseToken.data["status"] != 0){
                //Bkav HoangLD : nếu responseToken thất bị thì đăng xuất khỏi app
                Utils.logOutApp();
              }else{
                //Bkav HoangLD : nếu responseToken thành công thì thực hiện resquest lại api cũ
                options.headers['Authorization'] = token =
                responseToken.data["object"]['accessToken'];
/*            prefs.setString(SharedPreferencesKey.refreshToken,
                response.data['refresh_token'] ?? "");*/
                (await SharedPrefs.instance()).setString(SharedPreferencesKey.token, token);
                await tokenDio.fetch(options).then(
                      (r) => handler.resolve(r),
                  onError: (e) {
                    handler.reject(e);
                  },
                );
              }
            } on DioError catch (e) {
              Utils.logOutApp();
              return handler.next(response);
            }
          }else{
            //Utils.logOutApp();
          }
        }
        return handler.next(response);
      },
      onError: (error, handler) async {
        //trường hợp không có mạng mà call api tì hiển thị dialog thu lai
        if (await Utils.checkInternetConnection() == false) {
        DiaLogManager.displayLoadingDialog(NavigationService.navigatorKey.currentContext!);
        await Future.delayed(const Duration(seconds: 3), () {
            DiaLogManager.displayDialog(
                NavigationService.navigatorKey.currentContext!,
                S.of(NavigationService.navigatorKey.currentContext!).title_dialog_loss_internet,
                S.of(NavigationService.navigatorKey.currentContext!).content_dialog_loss_internet, () async {
              Get.back();
              await dio.fetch(error.requestOptions).then(
                    (r) => handler.resolve(r),
                onError: (e) {
                  handler.reject(e);
                },
              );

            }, () {
              Get.back();
            }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog,
                S.of(NavigationService.navigatorKey.currentContext!).action_dialog_internet);
          });
        }
        return handler.next(error);
      },
    ));
    return dio;
  }
}
