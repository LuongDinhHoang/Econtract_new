import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/view/contract/show_document_page.dart';
import 'package:flutter/material.dart';

/// Bkav HanhNTHe: ky Ho so
class SignContractPage extends StatelessWidget {
  //Bkav Nhungltk
  final String profileGuid;// objectGuid cua ho so
  final String objectGuid;// objectGuid cua ProfileTextDetail
  final int indexSection;
  final int fromPage;
  final List<TextDetail>? listText;
  final String profileName;
  final bool ? signSuccess;
  final bool isFrom;
  final List<String> typeSign;
  bool isExpired;
  String timeExpired;

  static Route route(String profileGuid, String objectGuid, int index, int from, List<TextDetail> list, String ? profileName,
      bool ? confirmOTPSuccess, bool isFrom, List<String> typeSign, bool isExpired, String timeExpired) {
    return Utils.pageRouteBuilder(SignContractPage.init(
      profileGuid: profileGuid,
      objectGuid: objectGuid,
      indexSection: index,
      fromPage: from,
      listText: list,
      profileName: profileName ?? "",
      signSuccess: confirmOTPSuccess,
      isFrom: isFrom,
      typeSign: typeSign,
      isExpired: isExpired,
      timeExpired: timeExpired,
    ), true);
  }

   SignContractPage.init(
      {Key? key,
        required this.profileGuid,
      required this.objectGuid,
      required this.indexSection,
      required this.fromPage,
        required this.profileName,
        this.signSuccess,
      this.listText,
      required this.isFrom,
      required this.typeSign,
        required this.isExpired,
        required this.timeExpired
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show Sign Contract Page");
    return ShowDocumentPage.init(
      profileGuid: profileGuid,
      objectGuid: objectGuid,
      indexSelected: indexSection,
      fileName: profileName,
      isSignDocumentPage: true,
      openSignPageTo: fromPage,
      listText: listText,
      isShowButtonSign: false,
      signSuccess: signSuccess,
      isFrom: isFrom,
      typeSign: typeSign,
      isExpired: isExpired,
      timeExpired: timeExpired,
    );
  }
}
