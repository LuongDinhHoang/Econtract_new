import 'package:e_contract/main_app.dart';
import 'package:flutter/material.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.DEV;
  initBkav();
  runApp(EContractApp());
}
