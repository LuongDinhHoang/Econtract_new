
class SignContractInfo{
  final String otpExpriedTime;
  final int otpDue;
  final String phoneNumber;
  final String errorMessage;

  const SignContractInfo({required this.otpExpriedTime,required this.otpDue,required this.phoneNumber, required this.errorMessage});

  SignContractInfo.fromJson(Map<String, dynamic> json):
      otpExpriedTime= json["otpExpriedTime"],
      otpDue= json["otpDue"],
      phoneNumber= json["phoneNumber"],
      errorMessage="";
}

class ContractSignInfo{
  final String profileCode;
  final String signerName;
  final String signDate;
  final String errorMessage;
  final String tokenHSM;
  ContractSignInfo(this.profileCode, this.signerName, this.signDate, this.errorMessage, this.tokenHSM);

  ContractSignInfo.fromJson(Map<String, dynamic> json):
      profileCode= json["profileCode"],
      signerName= json["signerName"],
      signDate= json["signDate"],
      errorMessage= "",
      tokenHSM= json["tokenHSM"];

}