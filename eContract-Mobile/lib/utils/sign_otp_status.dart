abstract class SignOtpStatus{
  const SignOtpStatus();
}
class SendOtpSuccess extends SignOtpStatus{}
class SendOtpFail extends SignOtpStatus{
  const SendOtpFail();
}
class ConfirmOtpSuccess extends SignOtpStatus{

}
class ConfirmOtpFail extends SignOtpStatus{}
class SendOtp extends SignOtpStatus{
  const SendOtp();
}
class ConfirmOTPStatus extends SignOtpStatus{}
//Bkav HoangLD trạng thái gửi tokenHsm thành công
class SendTokenHsmSuccess extends SignOtpStatus{}

class SendOtpEKYCSuccess extends SignOtpStatus{}

