import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/view/account/login_page.dart';
import 'package:e_contract/view_model/account/login_users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view_model/contract/contract_support_bloc.dart';

///Bkav HoangLD page chọn các tài khoản đã đăng nhập
class LoginUsersPage extends StatefulWidget {
  const LoginUsersPage({Key? key}) : super(key: key);

  static Future<Route> route() async {
    return Utils.pageRouteBuilder(const LoginUsersPage(), true);
  }

  @override
  State<LoginUsersPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginUsersPage>
    with WidgetsBindingObserver {
  bool _keyboardIsOpen = true;
  bool _isClickSupportMes = false;
  bool _isClickSupportTel = false;
  bool _isClickSupportZalo = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // làm trong suốt statusbar
      statusBarIconBrightness: Brightness.dark, // icon statusbar màu trắng
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _isClickSupportZalo = false;
        _isClickSupportMes = false;
        _isClickSupportTel = false;
      });
    }
  }
  @override
  dispose() {
    //Bkav HoangLD comment lại vì không cần bỏ khoá xoay
/*    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocProvider(
          create: (context) => LoginUsersBloc(),
          child: Scaffold(
            body: Utils.bkavCheckOrientation(
              context,
              SingleChildScrollView(
                  child: Container(
                //Bkav Nhungltk: diem diem giao dien
                alignment: const Alignment(0, -0.65),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageAsset.loginBackground),
                      fit: BoxFit.cover),
                ),
                child: _loginUnitForm(context),
              )),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _fabButton(),
          ),
        ));
  }

  Widget _loginUnitForm(BuildContext context) {
    return BlocListener<LoginUsersBloc, LoginUsersState>(
        listener: (context, state) async {},
        child: Form(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _logoWidgetLogin(),
                  _listViewUnit(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _listViewUnit() {
    return Align(
      child: BlocBuilder<LoginUsersBloc, LoginUsersState>(
          builder: (context, state) {
        return Column(
          children: [
        ScrollConfiguration(
          behavior: BkavBehavior(),
          child: state.usersList.length <= 5
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount:state.usersList.length, /*state.usersList.length*/
                  itemBuilder: (context, position) {
                    return Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    //final SharedPreferences prefs = await SharedPreferences.getInstance();
                                    (await SharedPrefs.instance()).setString(SharedPreferencesKey.userName,state.usersList[position].userName ?? "");
                                    Navigator.of(context, rootNavigator: true)
                                        .pushAndRemoveUntil<void>(
                                        await LoginPage.route(false), (route) => false);
                                  },
                                  child: Row(
                                    children: [
                                      IconButton(
                                        color: AppColor.black22,
                                        icon: SvgPicture.asset(IconAsset.icUsers),
                                        onPressed: () {
                                          setState(() {});
                                        },
                                      ),
                                      Container(
                                        //Bkav Nhungltk: diem diem giao dien
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(state.usersList[position].userName??"",
                                            style: StyleBkav.textStyleBlack14()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0, right: 10 ),
                                child: SizedBox(
                                  height: 30,width:30,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: SvgPicture.asset(IconAsset.icDeleteUsers, allowDrawingOutsideViewBox: true),
                                      onPressed: () async {
                                        await EContractDb.instance.deleteUser(state.usersList[position].userId??0);
                                        context.read<LoginUsersBloc>().add(StartLoginUsers());
                                        if(state.usersList.length == 1){
                                          backToLogin();
                                        }
                                      },
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                        containerLine(isMargin: true),
                      ],
                    );
                  },
                )
              :SizedBox(
              height: 270,
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.usersList.length,
            itemBuilder: (context, position) {
                return Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                //final SharedPreferences prefs = await SharedPreferences.getInstance();
                                (await SharedPrefs.instance()).setString(SharedPreferencesKey.userName,state.usersList[position].userName ?? "");
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil<void>(
                                    await LoginPage.route(false), (route) => false);
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                    color: AppColor.black22,
                                    icon: SvgPicture.asset(IconAsset.icUsers),
                                    onPressed: () {
                                      setState(() {});
                                    },
                                  ),
                                  Container(
                                    //Bkav Nhungltk: diem diem giao dien
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(state.usersList[position].userName??"",
                                        style: StyleBkav.textStyleBlack14()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, right: 10 ),
                            child: SizedBox(
                              height: 30,width:30,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                icon: SvgPicture.asset(IconAsset.icDeleteUsers, allowDrawingOutsideViewBox: true),
                                onPressed: () async {
                                  await EContractDb.instance.deleteUser(state.usersList[position].userId??0);
                                  context.read<LoginUsersBloc>().add(StartLoginUsers());
                                  if(state.usersList.length == 1){
                                    backToLogin();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    containerLine(isMargin: true),
                  ],
                );
            },
          ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  IconButton(
                    color: AppColor.black22,
                    icon: SvgPicture.asset(IconAsset.icAddUsers),
                    onPressed: () async {
                    },
                  ),
                  Container(
                    //Bkav Nhungltk: diem diem giao dien
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(S.of(context).add_user,
                        style: StyleBkav.textStyleBlack14()),
                  ),
                ],
              ),
              onTap: () async {
                backToLogin();
              },
            ),
            containerLine(isMargin: true),
          ],
        );
      }),
    );
  }
  Future<void> backToLogin() async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    (await SharedPrefs.instance()).setBool(SharedPreferencesKey.checkUsers, false);
    (await SharedPrefs.instance()).setString(SharedPreferencesKey.userName,"");
    Navigator.of(context, rootNavigator: true)
        .pushAndRemoveUntil<void>(
        await LoginPage.route(false,isAutofocus: true), (route) => false);
  }

  Widget _logoWidgetLogin() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            IconAsset.icLogoBkav,
            width: 250,
            height: 40,
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            S.of(context).button_login,
            style: StyleBkav.textStyleFW700(AppColor.cyan, 24),
          )
        ],
      ),
    );
  }

  Widget containerLine({bool? isMargin}) {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColor.gray300,
      margin: EdgeInsets.symmetric(horizontal: isMargin != null ? 16 : 0),
    );
  }

  Widget _fabButton() {
    return BlocProvider(
      create: (context) =>
          SupportAContractBloc(repository: context.read<Repository>()),
      child: BlocBuilder<SupportAContractBloc, SupportAContractState>(
          builder: (context, state) {
        return Visibility(
          visible: !_keyboardIsOpen && state.callApiError,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: !_isClickSupportZalo,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        heroTag: "zalo",
                        onPressed: () async {
                          setState(() {
                            _isClickSupportZalo = true;
                          });
                          //Bkav HoangLD thêm await để chờ sự kiện này xong thì setstate lại tránh giật lang
                          await Utils.launchInBrowser(
                              state.listUrlSupport.url[0]);
                          setState(() {
                            _isClickSupportZalo = false;
                          });
                        },
                        child: Image.asset(
                          ImageAsset.imageZalo,
                          height: 26.49,
                          width: 30.07,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isClickSupportZalo,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const CircularProgressIndicator(
                            color: AppColor.cyan),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                  Visibility(
                    visible: !_isClickSupportMes,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          heroTag: "messenger",
                          onPressed: () async {
                            setState(() {
                              _isClickSupportMes = true;
                            });
                            await Utils.launchInBrowser(
                                state.listUrlSupport.url[1]);
                            setState(() {
                              _isClickSupportMes = false;
                            });
                          },
                          child: Image.asset(
                            ImageAsset.imageMessenger,
                            height: 26,
                            width: 26,
                          )),
                    ),
                  ),
                  Visibility(
                    visible: _isClickSupportMes,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        heroTag: "loading",
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const CircularProgressIndicator(
                            color: AppColor.cyan),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                  Visibility(
                    visible: !_isClickSupportTel,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          heroTag: "telephone",
                          onPressed: () async {
                            setState(() {
                              _isClickSupportTel = true;
                            });
                            await Utils.launchInBrowser(
                                state.listUrlSupport.url[4]);
                            setState(() {
                              _isClickSupportTel = false;
                            });
                          },
                          child: Image.asset(
                            ImageAsset.imageTelephone,
                            height: 26,
                            width: 26,
                          )),
                    ),
                  ),
                  Visibility(
                    visible: _isClickSupportTel,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: FloatingActionButton(
                        heroTag: "loading",
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const CircularProgressIndicator(
                            color: AppColor.cyan),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
