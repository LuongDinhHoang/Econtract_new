import 'package:e_contract/data/entity/contract_search.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/item_contract_in_list.dart';
import 'package:e_contract/view/contract/detail_a_contract_page.dart';
import 'package:e_contract/view_model/ui_models/contract_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/repository.dart';
import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../utils/widgets/notification_internet_widget.dart';
import '../../view_model/contract/contract_search_bloc.dart';

class ContractSearch extends StatefulWidget {
  final List<ContractUIModel> list;
  final bool isFrom;
  final VoidCallback refreshListContract;

  const ContractSearch.init(
      {Key? key,
        required this.list,
        required this.isFrom,
        required this.refreshListContract})
      : super(key: key);

  static Route route(List<ContractUIModel> list, bool isFrom,
      VoidCallback refreshListContract) {
    return MaterialPageRoute(
        builder: (_) => ContractSearch.init(
          list: list,
          isFrom: isFrom,
          refreshListContract: refreshListContract,
        ));
  }

  @override
  State<StatefulWidget> createState() => StateSearchContract();
}

class StateSearchContract extends State<ContractSearch>
    with WidgetsBindingObserver {
  int categoryId = 0;
  String objectId = "";
  String queryText = "";
  bool onShowResult = false;
  String textChange = "";
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey _autocompleteKey = GlobalKey();
  List<GroupContractSearch>? suggestionList;
  bool hideKeyboard = false;

  BoxDecoration createBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: const Border.fromBorderSide(
            BorderSide(width: 1, color: Color(0xFFC5CED9))));
  }

/*  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        focusNode.requestFocus();
      });
    } else if (state == AppLifecycleState.inactive) {
      setState(() {
        focusNode.unfocus();
      });
    }
  }

/*  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Logger.logActivity("Show Search Page");
    return BlocProvider(
      create: (context) => ContractSearchBloc(
          repository: context.read<Repository>(),
          categoryId: categoryId,
          objectId: objectId,
          keySearch: queryText,
          blocContext: context,
          isFrom: widget.isFrom),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: AppColor.cyan,
              toolbarHeight: 44,
              elevation: 0.5,
              centerTitle: false,
              titleSpacing: 0,
              title: Column(
                children: [
                  Container(
                    height: 32,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: BlocBuilder<ContractSearchBloc,
                        ContractSearchState>(
                        builder: (context, state) {
                          return TextFormField(
                            style: StyleBkav.textStyleBlack14(),
                            controller: _textEditingController,
                            focusNode: focusNode,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintStyle: StyleBkav.textStyleGray300(),
                              hintText: S.of(context).label_search,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 10, bottom: 15),
                              suffixIcon: _textEditingController.text != ""
                                  ? IconButton(
                                padding: const EdgeInsets.only(),
                                icon: const Icon(CupertinoIcons.xmark_circle_fill,
                                    size: 24, color: AppColor.gray400),
                                onPressed: () async {
                                  setState(() {
                                    _textEditingController.clear();
                                  });
                                },
                              )
                                  : null,
                            ),
                            // onEditingComplete: (String value) {
                            //   FocusManager.instance.primaryFocus
                            //       ?.unfocus(disposition: UnfocusDisposition.scope);
                            //   if (value.isNotEmpty) {
                            //     context
                            //         .read<ContractSearchBloc>()
                            //         .add(ContractEasySearchEvent(value, 0, ""));
                            //   }
                            // },
                            onFieldSubmitted:(String value){
                              FocusManager.instance.primaryFocus
                                  ?.unfocus(
                                  disposition:
                                  UnfocusDisposition
                                      .scope);
                              if(value.isNotEmpty) {
                                context.read<
                                    ContractSearchBloc>().add(
                                    ContractEasySearchEvent(
                                        value,
                                        0, ""));
                                /*setState(() {
                                                          queryText = value;
                                                          onShowResult = true;
                                                        });*/
                              }
                              RawAutocomplete.onFieldSubmitted<String>(_autocompleteKey);
                            },
                            onChanged: (String value) {
                              setState(() {});
                            },);
                        }),
                  ),
                  BlocBuilder<ContractSearchBloc, ContractSearchState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       FocusManager.instance.primaryFocus
                            //           ?.unfocus(
                            //               disposition:
                            //                   UnfocusDisposition.scope);
                            //       Navigator.pop(context);
                            //     },
                            //     icon: SvgPicture.asset(
                            //       IconAsset.icBackSearch,
                            //       width: 24,
                            //       height: 24,
                            //     )),
                            Expanded(
                                child: BlocBuilder<ContractSearchBloc,
                                    ContractSearchState>(
                                    builder: (context, state) {
                                      suggestionList = state.suggestionList;
                                      return RawAutocomplete(
                                        key: _autocompleteKey,
                                        focusNode: focusNode,
                                        textEditingController: _textEditingController,
                                        optionsBuilder: (TextEditingValue
                                        textEditingValue) async {
                                          if (textEditingValue.text == '') {
                                            onShowResult = false;
                                            return const Iterable<
                                                String>.empty();
                                          } else {
                                            if (!hideKeyboard) {
                                              context
                                                  .read<ContractSearchBloc>()
                                                  .add(
                                                  ContractSuggestSearchEvent(
                                                      textEditingValue
                                                          .text));
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500));
                                            }
                                            setState(() {
                                              hideKeyboard = false;
                                              onShowResult = true;
                                              queryText =
                                                  textEditingValue.text;
                                            });
                                            List<String> matches = <String>[];
                                            if (suggestionList!.isNotEmpty) {
                                              matches = [textEditingValue.text];
                                            }
                                            return matches;
                                          }
                                        },
                                        // fieldViewBuilder: (BuildContext
                                        //         context,
                                        //     TextEditingController
                                        //         textEditingController,
                                        //     FocusNode focusNodeBuild,
                                        //     VoidCallback onFieldSubmitted) {
                                        //   // focusNode = focusNodeBuild;
                                        //   return TextField(
                                        //     style:
                                        //         StyleBkav.textStyleBlack14(),
                                        //     controller: textEditingController,
                                        //     focusNode: focusNode,
                                        //     autofocus: true,
                                        //     decoration: InputDecoration(
                                        //       hintStyle: StyleBkav
                                        //           .textStyleGray300(),
                                        //       hintText:
                                        //           S.of(context).label_search,
                                        //       border: InputBorder.none,
                                        //       contentPadding:
                                        //           const EdgeInsets.only(
                                        //               left: 10, bottom: 15),
                                        //       suffixIcon:
                                        //           textEditingController
                                        //                       .text !=
                                        //                   ""
                                        //               ? IconButton(
                                        //                   padding:
                                        //                       const EdgeInsets
                                        //                           .only(),
                                        //                   icon: const Icon(
                                        //                       CupertinoIcons
                                        //                           .xmark_circle_fill,
                                        //                       size: 24,
                                        //                       color: AppColor
                                        //                           .gray400),
                                        //                   onPressed:
                                        //                       () async {
                                        //                     setState(() {
                                        //                       textEditingController
                                        //                           .clear();
                                        //                     });
                                        //                   },
                                        //                 )
                                        //               : null,
                                        //     ),
                                        //     onSubmitted: (String value) {
                                        //       FocusManager
                                        //           .instance.primaryFocus
                                        //           ?.unfocus(
                                        //               disposition:
                                        //                   UnfocusDisposition
                                        //                       .scope);
                                        //       if (value.isNotEmpty) {
                                        //         context
                                        //             .read<
                                        //                 ContractSearchBloc>()
                                        //             .add(
                                        //                 ContractEasySearchEvent(
                                        //                     value, 0, ""));
                                        //       }
                                        //     },
                                        //     onChanged: (String value) {
                                        //       setState(() {});
                                        //     },
                                        //   );
                                        // },
                                        optionsViewBuilder: (BuildContext
                                        contextBuild,
                                            void Function(String) onSelected,
                                            Iterable<String> options) {
                                          // ContractSearchBloc bloc = Bloc
                                          //Bkav HoangLD fix bug BECM-582
                                          final textFieldHeight =
                                              MediaQuery.of(context)
                                                  .size
                                                  .height -
                                                  69 -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .bottom;
                                          return BlocProvider.value(
                                            value: BlocProvider.of<
                                                ContractSearchBloc>(context),
                                            child: BlocBuilder<
                                                ContractSearchBloc,
                                                ContractSearchState>(
                                                builder: (context, state) {
                                                  return onShowResult
                                                      ? Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        right: 70),
                                                    child: Align(
                                                      alignment:
                                                      Alignment.topLeft,
                                                      child:
                                                      GestureDetector(
                                                        //Bkav HoangLD fix bug BECM-581
                                                        behavior:
                                                        HitTestBehavior
                                                            .opaque,
                                                        onLongPressDown:
                                                            (_) {
                                                          SystemChannels
                                                              .textInput
                                                              .invokeMethod(
                                                              'TextInput.hide');
                                                          hideKeyboard =
                                                          true;
                                                        },
                                                        child: Material(
                                                            borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8.0)),
                                                            elevation: 4.0,
                                                            child:
                                                            ConstrainedBox(
                                                              constraints:
                                                              BoxConstraints(
                                                                maxHeight:
                                                                textFieldHeight,
                                                              ),
                                                              child:
                                                              SingleChildScrollView(
                                                                child: BlocBuilder<
                                                                    ContractSearchBloc,
                                                                    ContractSearchState>(
                                                                    builder:
                                                                        (context,
                                                                        state) {
                                                                      // if (queryText == textChange &&
                                                                      //     queryText != "") {
                                                                      //   context.read<ContractSearchBloc>().add(
                                                                      //       ContractSuggestSearchEvent(
                                                                      //           queryText));
                                                                      //   textChange = "";
                                                                      // }
                                                                      return ListView
                                                                          .builder(
                                                                        physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                        scrollDirection:
                                                                        Axis.vertical,
                                                                        shrinkWrap:
                                                                        true,
                                                                        itemBuilder: (context, indexList) => ListTile(
                                                                            title: Text(state.suggestionList[indexList].categoryName, style: StyleBkav.textStyleFW700(AppColor.gray400, 14)),
                                                                            subtitle:
                                                                            //<Widget>[
                                                                            Container(
                                                                              padding: const EdgeInsets.only(left: 28),
                                                                              child: ListView.builder(
                                                                                physics: const NeverScrollableScrollPhysics(),
                                                                                itemBuilder: (context, index) => GestureDetector(
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                                                                    child: RichText(text: _transformWord(state.suggestionList[indexList].list[index].objectName, queryText), textScaleFactor: MediaQuery.of(context).textScaleFactor),
                                                                                  ),
                                                                                  onTap: () {
                                                                                    FocusManager.instance.primaryFocus?.unfocus(disposition: UnfocusDisposition.scope);
                                                                                    context.read<ContractSearchBloc>().add(ContractEasySearchEvent(queryText, state.suggestionList[indexList].categoryId, (state.suggestionList[indexList].list)[index].objectId));
                                                                                    setState(() {
                                                                                      categoryId = indexList;
                                                                                      objectId = index.toString();
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                itemCount: state.suggestionList[indexList].list.length < 10 ? state.suggestionList[indexList].list.length : 10,
                                                                                scrollDirection: Axis.vertical,
                                                                                shrinkWrap: true,
                                                                              ),
                                                                            )
                                                                          // ],
                                                                        ),
                                                                        itemCount: state
                                                                            .suggestionList
                                                                            .length,
                                                                      );
                                                                    }),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                      : Container();
                                                }),
                                          );
                                        },
                                      );
                                    })),
                            // )
                          ],
                        );
                      }),
                ],
              ),
              leading: IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus
                        ?.unfocus(disposition: UnfocusDisposition.scope);
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    IconAsset.icBackSearch,
                    width: 24,
                    height: 24,
                  ))),
          body: Container(
            color: AppColor.gray50,
            child: SafeArea(
                left: false,
                right: false,
                bottom: false,
                child: Utils.bkavCheckOrientation(
                  context,
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1,
                          color: AppColor.gray300,
                          width: double.infinity,
                        ),
                        const NotificationInternet(),
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<ContractSearchBloc,
                              ContractSearchState>(builder: (context, state) {
                            List<ContractUIModel> list = [];
                            if (state.isChange) {
                              list = state.listContracts;
                            } else {
                              list = widget.list;
                            }
                            return NotificationListener<ScrollNotification>(
                              onNotification:
                                  (ScrollNotification notification) {
                                if (notification.metrics.atEdge) {
                                  if (notification.metrics.pixels == 0) {
                                  } else {
                                    if (objectId != "") {
                                      context.read<ContractSearchBloc>().add(
                                          ContractEasySearchContinueEvent(
                                              queryText,
                                              categoryId,
                                              objectId,
                                              widget.isFrom ? 1 : 2,
                                              state.listContractDocFrom,
                                              state.lastUpdate));
                                    } else {
                                      context.read<ContractSearchBloc>().add(
                                          ContractEasySearchContinueEvent(
                                              queryText,
                                              0,
                                              "0",
                                              widget.isFrom ? 1 : 2,
                                              state.listContractDocFrom,
                                              state.lastUpdate));
                                    }
                                  }
                                }
                                return true;
                              },
                              child: list.isNotEmpty
                                  ? RefreshIndicator(
                                onRefresh: () async {
                                  if (queryText.isEmpty) {
                                    context
                                        .read<ContractSearchBloc>()
                                        .add(ContractEasySearchEvent(
                                        queryText, 0, ""));
                                  }
                                },
                                edgeOffset: 0,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: list.length + 1,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return index == list.length
                                          ? Visibility(
                                        visible:
                                        state.loadingSearch,
                                        child: const Center(
                                            child:
                                            RefreshProgressIndicator()),
                                      )
                                          : Container(
                                        margin: index == 0
                                            ? const EdgeInsets.only(
                                            top: 8)
                                            : index ==
                                            list.length - 1
                                            ? const EdgeInsets
                                            .only(bottom: 8)
                                            : null,
                                        child: ContractItem(
                                          onTap: () async {
                                            FocusManager.instance
                                                .primaryFocus
                                                ?.unfocus();
                                            await Future.delayed(
                                                const Duration(
                                                    milliseconds:
                                                    200));
                                            Navigator.of(context)
                                                .push(DetailAContract
                                                .route(
                                                list[index],
                                                widget
                                                    .isFrom,
                                                context));
                                            FocusManager.instance
                                                .primaryFocus
                                                ?.unfocus();
                                          },
                                          contractUIModel:
                                          list[index],
                                          isFrom: widget.isFrom,
                                          refreshListContract: widget
                                              .refreshListContract,
                                        ),
                                      );
                                    }),
                              )
                                  : Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(IconAsset.icEmpty),
                                    const SizedBox(
                                      height: 27.56,
                                    ),
                                    Text(
                                      S.of(context).empty,
                                      style: StyleBkav.textStyleFW400(
                                          AppColor.black22, 18),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )),
          )),
    );
  }

  TextSpan _transformWord(String word, String textContain) {
    List<String> name = word.split(' ');
    List<TextSpan> listTextSpan = [];
    for (int i = 0; i < name.length; i++) {
      if (textContain.toLowerCase().contains(name[i].toLowerCase())) {
        listTextSpan.add(TextSpan(
            text: "${name[i]} ",
            style: StyleBkav.textStyleFW700(Colors.black, 14,
                overflow: TextOverflow.visible)));
      } else {
        listTextSpan.add(TextSpan(
            text: "${name[i]} ",
            style: StyleBkav.textStyleFW400(Colors.black, 14,
                overflow: TextOverflow.visible)));
      }
    }
    return TextSpan(children: listTextSpan);
  }
}