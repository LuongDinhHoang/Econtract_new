import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/bkav_app_bar.dart';
import 'package:e_contract/view_model/contract/copy_address_a_contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../resource/assets.dart';
import '../../utils/widgets/notification_internet_widget.dart';

class CopyAddressSignPage extends StatelessWidget {
  final String objectGuid;

  const CopyAddressSignPage.init({Key? key, required this.objectGuid})
      : super(key: key);

  static Route route(String id) {
    return Utils.pageRouteBuilder(CopyAddressSignPage.init(objectGuid: id), true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.gray50,
        appBar: BkavAppBar(
          context,
          title: Text(S.of(context).share_link_sign_contract,
              style: StyleBkav.textStyleGray20()),
          showDefaultBackButton: true,
        ),
        body: Utils.bkavCheckOrientation(
            context,
            Container(
              color: Colors.white,
              child: BlocProvider(
                  create: (context) => CopyAddressAContractBloc(
                      repository: context.read<Repository>(),
                      objectGuid: objectGuid),
                  child: BlocBuilder<CopyAddressAContractBloc,
                      CopyAddressAContractState>(builder: (context, state) {
                        Logger.logActivity("CopySignPage copy sign)");
                    return state.isShowProgress
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, position) {
                              return Column(
                                children: [
                                  const NotificationInternet(),
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 17, top: 16, bottom: 10),
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 0,
                                              child: Icon(
                                                  Icons.account_balance_outlined,
                                                  color: AppColor.gray400),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11),
                                                child: Text(
                                                  state.copyAddressList[position]
                                                      .signer,
                                                  style: StyleBkav
                                                      .textStyleBlack16(),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 24),
                                          margin: const EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 0,
                                                child: Icon(Icons.language,
                                                    color: AppColor.gray400),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                  left: 11),
                                                  child: Text(
                                                  state
                                                      .copyAddressList[position]
                                                      .address
                                                      .replaceAll('', '\u200B'),
                                                  style: StyleBkav
                                                      .textStyleBlack14(),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 0,
                                              child: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: AppColor.gray400),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11),
                                                child: Text(
                                                    S.of(context).duration +
                                                        state
                                                            .copyAddressList[
                                                                position]
                                                            .deadline,
                                                    style: StyleBkav
                                                        .textStyleBlack14(),
                                                overflow: TextOverflow.ellipsis,),
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.centerRight,
                                                width: 30,
                                                height: 30,
                                                child: IconButton(
                                                  //HoangLD fix bug BECM-521
                                                  icon: SvgPicture.asset(
                                                      IconAsset.icShare, allowDrawingOutsideViewBox: true),
                                                  onPressed: () {
                                                    final Size size = MediaQuery.of(context).size;
                                                    Share.share(state
                                                        .copyAddressList[
                                                    position]
                                                        .address, subject: S.of(context).share_link_sign_contract,sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2));
                                                    //Bkav Nhungltk: sua chua nang copy => chia se
                                                    /*Share.text(S.of(context).share_link_sign_contract, state
                                                         .copyAddressList[
                                                     position]
                                                         .address, state
                                                         .copyAddressList[
                                                     position]
                                                         .address);*/
                                                  },
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: AppColor.gray50,
                                  )
                                ],
                              );
                            },
                            itemCount: state.copyAddressList.length);
                  })),
            )));
  }
}
