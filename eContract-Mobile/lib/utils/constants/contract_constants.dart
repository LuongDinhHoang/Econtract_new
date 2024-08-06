/// Bkav HanhNTHe: trang thai cua Ho so
class ContractConstants {
  // status loai ho so mau (type)
  static const int using = 0; // đang sử dụng
  static const int stopUsing = 1; // ngừng sử dụng
  static const int deleted = 2; // đã xoá
  // status ho so - contractStatus
  static const int newlyCreated = 1; // mới tạo
  static const int waitingSign = 2; // chờ ký
  static const int refusingSign = 3; // từ chối ký
  static const int cancelled = 4; // đã huỷ
  static const int completed = 5; // hoàn thành

  // statusView cua Signer
  static const int notSeen = 0; // chưa xem - chua xem hoa chua ky
  static const int seen = 1; // đã xem - xem it nhat 1 van ban
  // statusSign cua Signer - neu co all signer co statusSign = 2 ? vb = hoan thanh : vb = cho ky
  static const int newSigner = 0; // mới tạo - người dùng mới tạo
  static const int waitingSigner = 1; // chờ ký - chờ người dùng ký
  static const int signed = 2; // đã ký - da ky het cac van ban
  static const int notSigned = 3; // tu choi ky

  // status phuong thuc ky van ban cho tung user - typeSignId cua Signer
  static const int unknown = 0; // chưa xác định
  static const int optSign = 1; // ký bằng OTP
  static const int hsmUnitSign = 2; // ký bằng HSM - CKS đơn vị
  static const int hsmPersonalSign = 3; // ky bang HSM - CKS ca nhan
  static const int usbTokenUnitSign = 7; // ky bang USB Token - CKS don vi
  static const int usbTokenPersonalSign = 5; // ky bang USB Token - CKS ca nhan
  static const int hsmSign = 2; // ky bang HSM
  static const int usbTokenSign = 4; // ky bang USB Token //Bkav Nhungltk: Sua lai typeSign theo BE

  // string key in buttonShow
  static const String copyPageSignKey = "copyPageSign";
  static const String editKey = "edit";
  static const String restoreKey = "restore";
  static const String signKey = "sign";
  static const String downloadKey = "download";
  static const String viewHistoryKey = "viewHistory";
  static const String cancelTransferSignKey = "cancelTranferSign";

  // key xav dinh xem chuyen tu trang nao de ky
  static const int signFromHomePage = 0;
  static const int signFromDocumentPage = 1;

  // key status notification
  static const int notificationUnsent = 1;
  static const int notificationSent = 2;
  static const int notificationReceived = 3;
  static const int notificationSeen = 4;

  //Status loại thông báo
  static const int unsigned = 0;//chưa thưc hiện ký
  static const int requestToSign = 1; //có một yêu cầu ký
  static const int signSuccess = 2;// ký thành công

  // id Radio Hình thức ký
  static const int radioOTP = 1;// lua chon la OTP
  static const int radioUSBToken = 4; // lua chon la USB Token
  static const int radioHSM = 2;// lua chon la HSM
  static const int radioRemoteSigning = 8;// lua chon la RemoteSigning
  static const int radioEKYC = 16;// lua chon la RemoteSigning

  // id trang thai giao dich ky remote signing
  static const int waitAuthentication = 1;// chờ xác thực
  static const int received = 2; // đã tiếp nhận
  static const int authenticated = 3;// đã xác thực
  static const int cancelAuthentication = 4;// huy xac thuc

  // package name app Bkav Remote Signing
  static const String bkavRemoteSigningPackageName = "mor.com.bkav.rs";
  static const String bkavRemoteSigningUrlScheme = "BkavRemoteSigning://";
  static const String bkavRemoteSigningUrlAppStore =
      "itms-apps://itunes.apple.com/us/app/bkav-remote-signing/id1619934936";
}
