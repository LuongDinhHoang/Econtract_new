import 'package:e_contract/utils/constants/api_constains.dart';

enum Flavor {
  DEV,
  PRODUCT,
  DEMO,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get domainApi  {
    switch (appFlavor) {
      case Flavor.DEV:
        return ApiConstants.domainDev;
      case Flavor.PRODUCT:
        return ApiConstants.domainProduct;
      case Flavor.DEMO:
        return ApiConstants.domainDemo;
      default:
        return ApiConstants.domainProduct;
    }
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Bkav eContract Dev';
      case Flavor.PRODUCT:
        return 'Bkav eContract';
      case Flavor.DEMO:
        return 'Bkav eContract Demo';
      default:
        return 'title';
    }
  }

}
