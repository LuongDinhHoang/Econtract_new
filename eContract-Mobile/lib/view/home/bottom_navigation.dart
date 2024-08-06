import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/view/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {Key? key,
      required this.currentTab,
      required this.onSelectTab,
      required this.count})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final int count;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _bottomNavigationBarItem(
            icon: currentTab == TabItem.contractFrom
                ? IconAsset.icHoSoDiOn
                : IconAsset.icHoSoDiOff,
            label: S.of(context).contract_from,
            isSelect: currentTab == TabItem.contractFrom,
            index: 0),
        _bottomNavigationBarItem(
            icon: currentTab == TabItem.contractTo
                ? IconAsset.icHoSoDenOn
                : IconAsset.icHoSoDenOff,
            label: S.of(context).contract_to,
            isSelect: currentTab == TabItem.contractTo,
            index: 1),
        _bottomNavigationBarItem(
            icon: currentTab == TabItem.notify
                ? IconAsset.icThongBaoOn
                : IconAsset.icThongBaoOff,
            label: S.of(context).notice,
            isSelect: currentTab == TabItem.notify,
            index: 2),
        _bottomNavigationBarItem(
            icon: currentTab == TabItem.support
                ? IconAsset.icSupportOn
                : IconAsset.icSupportOff,
            label: S.of(context).support,
            isSelect: currentTab == TabItem.support,
            index: 3),
        _bottomNavigationBarItem(
            icon: currentTab == TabItem.setting
                ? IconAsset.icToiOn
                : IconAsset.icToiOff,
            label: S.of(context).setting,
            isSelect: currentTab == TabItem.setting,
            index: 4),

      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: Colors.cyan,
      elevation: 10,
      backgroundColor: Colors.white,
      selectedLabelStyle: StyleBkav.textStyleFW400(AppColor.cyan, 10),
      unselectedLabelStyle: StyleBkav.textStyleFW400(Colors.grey[400], 10),
    );
  }

  _bottomNavigationBarItem(
      {required String icon,
      required String label,
      required bool isSelect,
      required int index}) {
    return BottomNavigationBarItem(
        icon: (index != 2 || (count == 0 && index == 2))
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: 6.0,
                    left: 6.0,
                    right: 6.0,
                    top: ((isSelect && index == 0 || isSelect && index == 1)
                        ? 0.0
                        : (isSelect && index == 2 ||
                                isSelect && index == 3 ||
                                isSelect && index == 4
                            ? 1.0
                            : 8.0))),
                child: SvgPicture.asset(icon))
            : Stack(children: <Widget>[
                Container(
                    width: 40,
                    height: 34,
                    padding: EdgeInsets.only(
                        bottom: 6.0,
                        left: 8.0,
                        right: 8.0,
                        top: isSelect ? 1.0 : 8.0),
                    child: SvgPicture.asset(icon)),
                Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: AppColor.badgeBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
              ]),
        label: label);
  }
}
