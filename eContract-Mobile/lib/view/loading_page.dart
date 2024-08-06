import 'dart:async';

import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/entity/support_info.dart';
import '../data/repository.dart';
import '../utils/constants/shared_preferences_key.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoadingPage());
  }

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer? _timer;
  double percent = 0.0;

  @override
  void initState() {
    //set việc chạy thanh progressbar tại đây set biến percent
    _timer = Timer.periodic(const Duration(milliseconds: 60), (_) {
      setState(() {
        percent += 0.02;
        if (percent >= 1) {
          // hết thời gian thanh progress bar chạy hết
          percent = 1;
          _timer?.cancel();
        }
      });
    });
    getApiSupport();
    //Bkav HoangLD khoá xoay màn hình loading
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }
  Future<void> getApiSupport() async {
    await context.read<Repository>().getListSupport();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Utils.bkavCheckOrientation(
        context, Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAsset.loadingBackground),
                  fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: logoWidget()),
                  // SizedBox(height: height / 40),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width / 1.32 + 19,
                          height: 6,
                          child: LinearPercentIndicator(
                            lineHeight: 6,
                            animationDuration: 3000,
                            percent: percent,
                            backgroundColor: Colors.transparent,
                            barRadius: const Radius.circular(8),
                            progressColor: AppColor.cyan,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width / 1.32,
                          height: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.cyan, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: height / 1.55),
/*              Image(
                image: const AssetImage(ImageAsset.flashPicture),
                height: height / 2.77,
                width: width,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 5)*/
            ],
          ),
        ),
      ),
    );
  }
}
