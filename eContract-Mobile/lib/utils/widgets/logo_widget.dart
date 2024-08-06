import 'package:e_contract/resource/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget logoWidget() {
  return  Align(
    alignment: Alignment.center,
    child: SvgPicture.asset(
        IconAsset.icLogoBkav),
  );
}
