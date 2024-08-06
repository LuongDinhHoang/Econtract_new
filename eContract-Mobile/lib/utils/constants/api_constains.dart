class ApiConstants {

  static const domainDev = "van.econtract.vn";
  static const domainProduct = "van.econtract.vn";
  static const domainDemo = "demo.econtract.vn";
  static const unEncodedPathLogin = "/api/Account/LoginApp";
  static const unEncodedPathViewDetail = "/api/Profile/ViewDetail";
  static const unEncodePathProfileText =
      "/api/ProfileText/GetContentProfileText";
  static const unEncodePathHistoryAProfile = "/api/Common/GetListHistory";
  static const unEncodePathCopyAddress = "/api/Profile/GetUrlPageSignApp";
  static const unEncodePathEasySearchApp = "/api/Profile/EasySearchApp";
  static const unEncodePathSuggestSearchContractFrom = "/api/Profile/SuggestSearchFromApp";//Bkav Nhungltk: cap nhat API
  static const unEncodePathSuggestSearchContractTo= "/api/Profile/SuggestSearchToApp";//Bkav Nhungltk: cap nhat API
  static const unEncodePathGetlistByLastUpdateApp= "/api/Profile/GetListByLastUpdateApp";
  static const unEncodePathSendOtp="/api/OTP/SendOTPApp";
  static const unEncodePathConfirmOTP= "/api/OTP/ConfirmOTPAndDoXApp";
  static const unEncodeUpdateTokenFireBase = "/api/AppUser/UpdateUUIDTokenFirebase";
  static const unEncodedPathReject = "/api/Profile/Reject";
  static const unEncodePathGetTimeToSever = "/api/AppNotify/GetTimeToServer";
  static const unEncodedPathLogout = "/api/Account/Logout";
  static const unEncodedPathGetListNotification = "/api/AppNotify/GetListNotify";
  static const unEncodedPathChangePassword = "/api/UserManager/ChangePassword";
  static const unEncodedPathViewDetailApp = "/api/Profile/ViewDetailApp";
  static const unEncodedPathUpdateStatusViewed = "/api/AppNotify/UpdateStatusUserViewed";
  static const unEncodedPathUpdateStatusReceive = "/api/AppNotify/UpdateStatusAppReceivedUserNoView";
  static const unEncodedPathSupport = "/api/Support/GetInforSupport";
  static const unEncodedPathInsertLog= "/api/AppLog/InserLog";
  static const unEncodePathSignHSM="/api/HSM/SignHSM";
  static const unEncodedPathGetTypeList = "/api/Profile/GetListTypeSignOfProfile";
  static const unEncodeUpdateLastTimeOpen = "/api/AppUser/UpdateLastTimeOpen";
  static const unEncodeGetBagNumber = "/api/AppNotify/GetBagNumber";
  static const unEncodePathSendOtpByTokenHsm="/api/HSM/SignByTokenHSM";
  static const unEncodeGetAccessToken = "/api/Common/GetAccessToken";
  static const unEncodeGetAccessTokenEKYC = "/api/EKYC/Init";
  static const unEncodeSignEKYC = "/api/EKYC/Sign";
  static const unEncodePathConfirmOTPEKYC= "/api/OTP/ConfirmOTPAndDoX";





  static const unEncodedPathRemoteSigning = "/api/RemoteSigning/RequestSign"; // ky bang remote signing
  static const unEncodedPathGetResultSign = "/api/RemoteSigning/GetResultSign"; // call api de lay trang thai 3s 1 lan
  static const unEncodedPathCancelSign = "/api/RemoteSigning/CancelSign"; // huy ky remote signing
  static const unEncodedPathRemoteSigningSignTemp = "/api/RemoteSigning/Sign"; // ky bang remote signing, dung 1 api nay cho chua ho tro nhung api khac
  static const switchRemoteSigningOk = false; // do remote signing kich ban chuan chua ho tro nen de tam kich ban thay the, sau ben RS ho tro thi mo ra
  static const unEncodedPathGetTimeCallRS = "/api/RemoteSigning/GetTimeCallRS"; // lay thoi gian doi ky remote signing
}
