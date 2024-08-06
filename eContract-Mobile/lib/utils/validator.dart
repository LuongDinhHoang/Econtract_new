
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/navigation_service.dart';

class Validator {
  static const String _emailRule =
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
  static const String _passwordRule =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?~]).{9,}$';
  static const String _rejectRule =
      r'^!@#$%&*()_+-={}[]/|\:;”,“<>"';


  static String emailValidator(String email) {
    if (email == "") {
      return "Email is Empty";
    }
    var isValid = RegExp(_emailRule).hasMatch(email);
    if (!isValid) {
      return "Email invalid";
    }
    return "";
  }

  static String passwordValidator(String pass) {
    if (pass == "") {
      return "Password is Empty";
    }
    if (pass.length < 8) {
      return "Password require minimum 8 characters";
    }
    var isValid = RegExp(_passwordRule).hasMatch(pass);
    if (!isValid) {
      return "Password invalid";
    }
    return "";
  }

  //Bkav TungDV
  static String errorValidate(String content){
    if(content == ""){
      return S.of(NavigationService.navigatorKey.currentContext!).not_agree_null;
    }
    if(content.length < 5){
      return S.of(NavigationService.navigatorKey.currentContext!).not_agree_length_5;
    }
    if(content.length > 500){
      return S.of(NavigationService.navigatorKey.currentContext!).not_agree_length_500;
    }

    //validate toàn bộ là 1 ký tu
    int count = 0;
    for (var x in content.runes) {
      for (var y in content.runes) {
         if(x==y){
           count++;
         }
      }
      if(count == content.runes.length || (content.length > 1 && content == "")){
        return S.of(NavigationService.navigatorKey.currentContext!).not_agree_illegal;
      }
      count = 0;
    }

    //validate toàn bộ là ký tự đăc biet
    int countRule = 0;
    for (var x in content.runes) {
      for (var y in _rejectRule.runes) {
        if(x==y){
          countRule++;
        }
      }
    }
    if(countRule == content.runes.length){
      return S.of(NavigationService.navigatorKey.currentContext!).not_agree_illegal;
    }
    return "";
  }

  ///Bkav Nhungltk: validate mat khau
  /// Mat khau co do dai toi thieu la 8
  /// Chứa 3 trong 4 kiểu ký tự (a – z, A – Z, 0 – 9, !@#$%^&*)
  ///  Khong chua khoang trang
  static bool validateFormatPass(String pass){
    RegExp regExp1= RegExp(r"^(?=(.*[0-9]))(?=.*[\!@#$%^&*])(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}");
    RegExp regExp2=RegExp(r"^(?=(.*[0-9]))(?=.*[\!@#$%^&*])(?=.*[a-z])(?=(.*)).{8,}");
    RegExp regExp3=RegExp(r"^(?=(.*[0-9]))(?=.*[\!@#$%^&*])(?=.*[A-Z])(?=(.*)).{8,}");
    RegExp regExp4= RegExp(r"^(?=(.*[0-9]))(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}");
    RegExp regExp5= RegExp(r"^(?=.*[\!@#$%^&*])(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}");
    return (regExp1.hasMatch(pass)|| regExp2.hasMatch(pass)|| regExp3.hasMatch(pass)|| regExp4.hasMatch(pass)|| regExp5.hasMatch(pass)) &&
        !pass.contains(" ");
  }

  static bool validatePassLength(String pass){
    if(pass.length<8) {
      return false;
    }
    return true;
  }
}
