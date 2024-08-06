import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/widgets/notification_internet_widget.dart';

class ShowListTextPage extends StatelessWidget {
  final List<TextDetail> listText;
  final int indexSelected;

  const ShowListTextPage(
      {Key? key, required this.listText, required this.indexSelected})
      : super(key: key);

  static Route route(List<TextDetail> list, int index) {
    return Utils.pageRouteBuilder(ShowListTextPage(
      listText: list,
      indexSelected: index,
    ), true);
  }

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show List Text Page");
    return Scaffold(
      appBar: BkavAppBar(
        context,
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).list_text,
          style: StyleBkav.textStyleGray20(),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: SvgPicture.asset(IconAsset.icClose),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
        ],
        showDefaultBackButton: false,
      ),
      body: Utils.bkavCheckOrientation(
        context, Container(
        color: Colors.white,
          child: Column(children: [
            const NotificationInternet(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: listText.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemText(
                      index: index,
                      textInList: listText[index],
                      indexSelected: indexSelected,
                      onTap: () {
                        Navigator.of(context).pop(index);
                      });
                }),
          ],),
        ),
      )
    );
  }

  Widget itemText(
      {required int index,
      required TextDetail textInList,
      required int indexSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                "${index + 1}. ${(textInList.fileName).replaceAll('', '\u200B')}",
                style: StyleBkav.textStyleFW400(
                    indexSelected == index ? AppColor.cyan : Colors.black, 14, height: 1.5),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 1,
              color: AppColor.gray50,
            )
          ],
        ));
  }
}
