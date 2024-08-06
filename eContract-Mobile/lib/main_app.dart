import 'dart:io';

import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/data/repository_impl.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/local_notification_service.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:e_contract/view/home/home_page.dart';
import 'package:e_contract/view/loading_page.dart';
import 'package:e_contract/view_model/account/authentication/authentication_bloc.dart';
import 'package:e_contract/view_model/account/authentication/authentication_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  Utils.callApiNotifyReceive(message.data);
  //Bkav HoangLD có thông báo thì hiển thị số lượng thông báo trên icon ở launcher
  FlutterAppBadger.updateBadgeCount(int.parse(message.data["BagNumberLauncher"]));
}


Future<void> initBkav() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (Platform.isIOS) {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  if (Platform.isAndroid) {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'Thông báo eContract', // title
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  // final prefs = await SharedPreferences.getInstance();
  String? uuidSave = (await SharedPrefs.instance()).getString(SharedPreferencesKey.keyUUID);
  Logger.loggerDebug("Bkav DucLQ uuid $uuidSave");

  if (uuidSave == null || uuidSave.isEmpty) {
    var uuid = const Uuid(options: {'econtract': UuidUtil.cryptoRNG});
    uuidSave = uuid.v4();
    await (await SharedPrefs.instance()).setString(SharedPreferencesKey.keyUUID, uuidSave);
    // prefs.setString(SharedPreferencesKey.keyUUID, uuidSave);
    Logger.logActivity(" save UUID:  $uuidSave");
  }

  messaging.getToken().then((tokenFirebase) async {
    if (tokenFirebase != null && tokenFirebase.isNotEmpty) {
      (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenFirebase, tokenFirebase);
      Logger.loggerDebug("Bkav DucLQ Token firebase cua app la $tokenFirebase");
      Logger.logActivity("Token firebase: $tokenFirebase");
    }
  });
  messaging.onTokenRefresh.listen((newToken) async {
    if (newToken.isNotEmpty) {
      (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenFirebase, newToken);
      Logger.loggerDebug("Bkav DucLQ Token firebase cua app la $newToken");
      Logger.logActivity("Token firebase onTokenRefresh: $newToken");
    }
  });

  //Bkav HoangCV: đặt thuộc tính chung cho các màn hình không dùng appbar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // làm trong suốt statusbar
    statusBarIconBrightness: Brightness.light, // icon statusbar màu trắng
  ));

  EContractDb.instance.deleteLog();
}

class EContractApp extends StatelessWidget {
  final Repository repository = RepositoryImpl();

  EContractApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(repository: repository),
        child: _EContractAppView(),
      ),
    );
  }
}

class _EContractAppView extends StatefulWidget {
  @override
  _EContractAppState createState() => _EContractAppState();
}

class _EContractAppState extends State<_EContractAppView> {
  final _navigatorKey = NavigationService.navigatorKey;

  LocalNotificationService localNotificationService =
  LocalNotificationService();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(primaryColor: Colors.cyan),
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                        await HomePage.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil(
                        await LoginPage.route(true), (route) => false);
                    break;
                  default:
                    break;
                }
              },
              child: child);
        },
        onGenerateRoute: (_) => LoadingPage.route());
  }
}
