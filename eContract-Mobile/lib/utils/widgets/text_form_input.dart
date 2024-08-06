import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/resource/assets.dart';
import 'package:e_contract/resource/color.dart';
import 'package:e_contract/resource/style.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/view/account/login_users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


/// Bkav DucLQ custom 1 o nhat text
class TextFormFieldInput extends StatefulWidget {
  final String _label;
  final TextEditingController _textEditingController;
  final bool _isTypePassword;

  final bool _errorValidate;
  final FocusNode _focusNode;
  final String errorValidate;
  final Function(bool) checkPass;
  final bool changePass;
  final bool checkUser;
  final bool checkAutofocus;

  const TextFormFieldInput(
      this._label,
      this._textEditingController,
      this._isTypePassword,
      this._errorValidate,
      this._focusNode,
      this.errorValidate,
      this.checkPass,
      this.changePass,
      {Key? key, this.checkUser = false ,this.checkAutofocus = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormFieldInputState();
}

class _TextFormFieldInputState extends State<TextFormFieldInput> {
  bool _showDeleteText = true;
  bool _obscureText = true;
  bool _showAsterisk = false;
  bool _textIsNotEmpty = false;
  bool _validatorTextIsEmpty= false;
  bool hideError= false;
  bool onTap= true;

  //Bkav Nhungltk
  bool _hasFocus = false;

  //final FocusNode _focusNode= FocusNode();

  _TextFormFieldInputState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Bkav DucLQ show icon * mau do
  void showAsterrick(bool show) {
    setState(() {
      Logger.loggerDebug("show icon do $show");
      _showAsterisk = show;
      Logger.loggerDebug("nhungltk show asterisk: $_showAsterisk");
    });
  }

  //Bkav Nhungltk: hien thi thong bao text null 
  void textIsNotEmplty(bool textIsNotEmpty){
    setState(() {
      _validatorTextIsEmpty= !textIsNotEmpty;
    });
  }

  /// Bkav DucLQ ham nay de tao lai deco
  InputDecoration createInputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF08B7DD), width: 1.0)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: (widget._errorValidate || _validatorTextIsEmpty) && !hideError
                  ? AppColor.redDD
                  : const Color(0xFFBDBDBD) /*Bkav Nhungltk*/,
              width: 1.0)),
      errorStyle: StyleBkav.textStyleFW400(AppColor.redDD, 12,overflow: TextOverflow.fade),
      errorMaxLines: 2,
      errorText: widget.changePass== true && _validatorTextIsEmpty && !hideError? S.of(context).pass_empty:
      (widget._errorValidate || _validatorTextIsEmpty)&& !hideError ? widget.errorValidate:  null,
      label: (_showAsterisk /*Bkav Nhungltk && (_notEmpty*/ ||
              _textIsNotEmpty) /*)*/
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Text(widget._label,
                      style: StyleBkav.textStyleFW400(
                          _hasFocus || _textIsNotEmpty
                              ? AppColor.black22
                              : AppColor.grayB8, 16)),
                ),
                !widget.changePass?
                Flexible(
                  child: Text(" *",
                      style: StyleBkav.textStyleFW400(AppColor.redDD, 16)),
                ):Container(),
              ],
            )
          : Text(widget._label,
              style: StyleBkav.textStyleFW400(AppColor.grayB8, 14)),
      suffixIcon: !widget._isTypePassword
          ? _showDeleteText && _hasFocus && _textIsNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center, // added line
                  mainAxisSize: MainAxisSize.min, // added line
                  children: <Widget>[
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(IconAsset.backgroundClear),
                              fit: BoxFit.cover),
                        ),
                        child: Transform.scale(
                          scale: 2,
                          child: IconButton(
                          color: AppColor.black22,
                          icon:
                              //Bkav Nhungltk: fix loi fucus bi mau xanh
                              Image.asset(IconAsset.icClear),
                          onPressed: () {
                            widget._textEditingController.clear();
                            _textIsNotEmpty = false;
                            showDeleteText(false);
                          },
                        ),)
                      )
                    ])
              : null
          : _showDeleteText && _hasFocus //Bkav Nhungltk
              ? Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min, // added line
                  children: <Widget>[
                    _textIsNotEmpty ?
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(IconAsset.backgroundClear),
                            fit: BoxFit.cover),
                      ),
                        child: Transform.scale(
                          scale: 2,
                          child: IconButton(
                            color: AppColor.black22,
                            icon: Image.asset(IconAsset.icClear),
                            onPressed: () {
                              widget._textEditingController.clear();
                              //Bkav Nhungltk
                              _textIsNotEmpty = false;
                              showDeleteText(false);
                            },
                          ),
                        ))
                        :Container(),
                    IconButton(
                      color: AppColor.black22,
                      //Bkav Nhungltk: fix loi fucus bi mau xanh
                      icon: _obscureText
                          ? Image.asset(IconAsset.icEye)
                          : Image.asset(IconAsset.eyeOff),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ],
                )
              : IconButton(
                  color: AppColor.black22,
                  //Bkav Nhungltk: fix loi fucus bi mau xanh
                  icon: _obscureText
                      ? Image.asset(IconAsset.icEye)
                      : Image.asset(IconAsset.eyeOff),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
    );
  }

  InputDecoration createInputDecorationUsers() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1.0)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: (widget._errorValidate || _validatorTextIsEmpty) && !hideError
                  ? AppColor.redDD
                  : const Color(0xFFBDBDBD) /*Bkav Nhungltk*/,
              width: 1.0)),
      prefixIcon: IconButton(
        color: AppColor.black22,
        icon: SvgPicture.asset(IconAsset.icUsers),
        onPressed: () async {
          Navigator.of(context).pushAndRemoveUntil<void>(
              await LoginUsersPage.route(), (route) => true);
        },
      ),
      suffixIcon: IconButton(
        color: AppColor.black22,
        icon: SvgPicture.asset(IconAsset.icMore),
        onPressed: () async {
          Navigator.of(context).pushAndRemoveUntil<void>(
              await LoginUsersPage.route(), (route) => true);
        },
      ),
    );
  }


  ///Bkav DucLQ ham nay de show Icon delete
  void showDeleteText(bool show) {
    setState(() {
      Logger.loggerDebug("show Delete $show");
      _showDeleteText = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget._textEditingController.text.isNotEmpty){
      _textIsNotEmpty = true;
    }
    return
      Focus(child: TextFormField(
        onTap: () async {
          setState(() {
          onTap=true;
        }
        );
          if(widget.checkUser){
             Navigator.of(context).pushAndRemoveUntil<void>(
                await LoginUsersPage.route(), (route) => true);
          }
            widget._focusNode.requestFocus();
        },
          autofocus: widget.checkAutofocus,
          readOnly: widget.checkUser?true:false,
          textInputAction: TextInputAction.next,
          focusNode: widget._focusNode,
          controller: widget._textEditingController,
          decoration: widget.checkUser?createInputDecorationUsers():createInputDecoration(),
          obscureText: widget._isTypePassword ? _obscureText : false,
          obscuringCharacter: "*",
          onChanged: (text) => {
            showDeleteText((text.isNotEmpty)),
                if ((text.isNotEmpty /*Bkav Nhungltk && _isTypePassword*/) !=
                    _showDeleteText)
                  {
                    if (!text.isNotEmpty){//Bkav HoangCV: check dieu kien khi text null
                      _textIsNotEmpty = false,
                    }// Bkav HoangCV: check khi co text trong form thi ko hien thong bao nhap text
                    else {
                      textIsNotEmplty(true),
                    }
                  }
                else if (text.isNotEmpty)
                  {
                    _textIsNotEmpty = true,
                    textIsNotEmplty(true),
                    setState(() {
                      hideError= true;
                    })
                  }
                else
                  {
                    _textIsNotEmpty = false,
                    textIsNotEmplty(false),
                  }
              },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              textIsNotEmplty(false);
            }
            setState(() {
              hideError= false;
            });
            //return null;
          },
          onEditingComplete: ()async{
            widget._focusNode.unfocus();
            setState(() {
              hideError= false;
              onTap=false;
            });
            if(onTap==false && widget.changePass== true) {
              setState(() {
                onTap= true;
              });
              onLostFocus(widget._textEditingController.text, false);
            }
          }
      ),
      onFocusChange: (hasFocus) async {
        showAsterrick(hasFocus);
        //Bkav Nhungltk:
        setState(() {
          _hasFocus = hasFocus;
          if(hasFocus==false){
            hideError= false;
          }
        });
        if(hasFocus== false && widget.changePass== true) {
         onLostFocus(widget._textEditingController.text, true);
        }
      },
    );
  }

  void onLostFocus(String text, bool lostFocus){
    if(text.isEmpty){
      textIsNotEmplty(false);
    }else{
      textIsNotEmplty(true);
      }
    widget.checkPass(lostFocus);
  }
}
