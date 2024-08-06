import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/blink_animation.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/contract/sign_contract_page.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ContractItem extends StatefulWidget {
  final VoidCallback? onTap;
  final ContractUIModel contractUIModel;
  final bool isFrom;
  final VoidCallback? refreshListContract;
  final bool? positionClick;

  const ContractItem(
      {Key? key, this.onTap, required this.contractUIModel, required this.isFrom, required this.refreshListContract, this.positionClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState()=> _ContractItemState();
}
class _ContractItemState extends State<ContractItem>{
  late ContractUIModel contractUIModel;
  bool isShowButtonSign = true;
  late bool isFrom;
  bool positionClick = false;
  @override
  Widget build(BuildContext context) {
    bool positionClick = widget.positionClick??false;
    contractUIModel= widget.contractUIModel;
    isFrom= widget.isFrom;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:const BorderRadius.all(Radius.circular(12)),
              border: Utils.checkHorizontal(context)?positionClick?Border.all(color: Colors.cyan,width: 1):null:null
          ),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Utils.showTitleName(contractUIModel.profileName,
                      contractUIModel.profileTypeName),
                  style: StyleBkav.textStyleBlack16(),
                  maxLines: 1,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ScrollConfiguration(
                      behavior: BkavBehavior(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contractUIModel.listSignerStatus.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = contractUIModel.listSignerStatus.keys
                              .elementAt(index);
                          if (index < 3) {
                            return Utils.bkavTextSignerStyle(
                                context, index, key,
                                value: contractUIModel.listSignerStatus[key],
                                length:
                                contractUIModel.listSignerStatus.length);
                          } else if (index == 3) {
                            return const Text(
                              "...",
                              style: TextStyle(color: AppColor.black22),
                            );
                          }
                          return Container();
                        },
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table(
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            Text("${S.of(context).status} "),
                            Padding(
                              padding: const EdgeInsets.only(top:2.0),
                              child: Utils.showTextContractStatus(
                                  context, contractUIModel.status),
                            )
                          ]
                        )
                      ],
                    ),
                    contractUIModel.status == ContractConstants.waitingSign
                        ? (contractUIModel
                                    .signDeadline[ConstFDTFString.timeResult] !=
                                "")
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Table(
                                  columnWidths: const {
                                    0: IntrinsicColumnWidth(),
                                  },
                                  children: [
                                    TableRow(
                                        children: [
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: S.of(context).date_sign,
                                                  style: StyleBkav.textStyleBlack14()),
                                              TextSpan(
                                                  text:
                                                  " ${contractUIModel.signDeadline[ConstFDTFString.timeResult]}",
                                                  style: StyleBkav.textStyleFW400(
                                                      contractUIModel.signDeadline[
                                                      ConstFDTFString.isExpired]
                                                          ? AppColor.redE5
                                                          : AppColor.black22,
                                                      14)),
                                            ]),
                                            textScaleFactor:
                                            MediaQuery.of(context).textScaleFactor,
                                          ),
                                          contractUIModel.signDeadline[
                                          ConstFDTFString.isWarning] ==
                                              null
                                              ? Container()
                                              : (contractUIModel.signDeadline[
                                          ConstFDTFString.isWarning])
                                              ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: SvgPicture.asset(
                                                  IconAsset.icWarning),
                                            ),
                                          )
                                              : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: BkavBlinkingButton(
                                                    child: SvgPicture.asset(
                                                        IconAsset.icError)),
                                              ))
                                        ]
                                    )
                                  ],
                                ),
                              )
                            : Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    Utils.showDateTime(context, contractUIModel),
                                    overflow: TextOverflow.ellipsis,
                                    style: StyleBkav.textStyleFW400(
                                        (contractUIModel.status ==
                                                    ContractConstants
                                                        .waitingSign &&
                                                contractUIModel.signDeadline[
                                                    ConstFDTFString.isExpired])
                                            ? AppColor.redE5
                                            : AppColor.black22,
                                        14),
                                  ),
                                ),
                                /*contractUIModel.isShowButtonSign
                              ? Container()
                              : Container(
                            child: Utils.showTextContractStatus(
                                context, contractUIModel.status),
                          ),*/
                              ],
                    ),
                        ),
                  ],
                ),
                if (contractUIModel.isShowButtonSign /*contractUIModel.typeSign.contains(ContractConstants.optSign.toString()) ||
                    contractUIModel.typeSign.contains(ContractConstants.usbTokenSign.toString()) || contractUIModel.typeSign.contains(ContractConstants.hsmSign.toString())
                    ||*/
                    && isShowButtonSign) Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async{
                          /*if(contractUIModel.typeSign.contains(ContractConstants.optSign.toString())
                              || contractUIModel.typeSign.contains(ContractConstants.hsmSign.toString())) {*/
                          if(contractUIModel.signDeadline[ConstFDTFString.isExpired]){
                            DiaLogManager.displayDialog(context, "",
                                S.of(context).status_expired + contractUIModel.signDeadline[ConstFDTFString.m3a], () { }, () {Get.back();},
                                S.of(context).close_dialog, "");
                          }else{
                            final result= await  Navigator.of(context, rootNavigator: true).push(
                                SignContractPage.route(
                                    contractUIModel.objectGuid,
                                    contractUIModel.listTextDetail[0].objectGuid,
                                    0,
                                    ContractConstants.signFromHomePage,
                                    contractUIModel.listTextDetail,
                                    contractUIModel.profileName,
                                    false,
                                    isFrom,
                                    contractUIModel.typeSign,
                                    contractUIModel.signDeadline[ConstFDTFString.isExpired],
                                    contractUIModel.signDeadline[ConstFDTFString.m3a]??""));
                            if(result!= null && result[0]== false){
                              widget.refreshListContract!();
                              setState(() {
                                isShowButtonSign= false;
                              });
                            }
                          }
                          /*}else if(contractUIModel.typeSign.contains(ContractConstants.usbTokenSign.toString())){
                            //Bkav Nhungltk: show dialog khong ho tro kys bang usb token
                            DiaLogManager.displayDialog(context, "", S.of(context).content_no_support_usb_token_sign, () { }, () {Get.back();}, S.of(context).close_dialog, "");
                          }*/
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          height: 28,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(6)),
                              border:
                              Border.all(color: /*contractUIModel.typeSign.contains(ContractConstants.optSign.toString())||contractUIModel.status == ContractConstants.waitingSigner || contractUIModel.typeSign.contains(ContractConstants.hsmSign.toString())? */
                              contractUIModel.signDeadline[ConstFDTFString.isExpired]?AppColor.gray200:AppColor.cyan/*:
                              contractUIModel.typeSign.contains(ContractConstants.usbTokenSign.toString())? AppColor.gray200: Colors.white*/, width: 1)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              /*contractUIModel.typeSign.contains(ContractConstants.optSign.toString()) || contractUIModel.typeSign.contains(ContractConstants.hsmSign.toString())||contractUIModel.status == ContractConstants.waitingSigner?*/
                              contractUIModel.signDeadline[ConstFDTFString.isExpired]?SvgPicture.asset(IconAsset.disableSign):SvgPicture.asset(IconAsset.icKy)/*:
                              contractUIModel.typeSign.contains(ContractConstants.usbTokenSign.toString())? SvgPicture.asset(IconAsset.disableSign): Container()*/,
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                S.of(context).sign_contract,
                                style:/*contractUIModel.typeSign.contains(ContractConstants.optSign.toString())||contractUIModel.status == ContractConstants.waitingSigner || contractUIModel.typeSign.contains(ContractConstants.hsmSign.toString())? */
                                contractUIModel.signDeadline[ConstFDTFString.isExpired]?StyleBkav.textStyleFW400(AppColor.gray300, 14):StyleBkav.textStyleFW400(AppColor.cyan, 14)/*:
                                contractUIModel.typeSign.contains(ContractConstants.usbTokenSign.toString())? StyleBkav.textStyleFW400(AppColor.gray300, 14):null*/,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )//else Container(alignment:Alignment.centerLeft, padding: const EdgeInsets.all(3), child: const RefreshProgressIndicator(),)
              ],
            ),),
    );
  }
}
