class SignHSMContractInfo{
  final String reasonError;
  final bool isOk;
  final int status;

  const SignHSMContractInfo({required this.reasonError,required this.isOk,required this.status});

  SignHSMContractInfo.fromJson(Map<String, dynamic> json):
        status = json["status"],
        reasonError= json["object"],
        isOk= json["isOk"];
}