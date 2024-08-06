import 'package:e_contract/utils/constants/api_constains.dart';

class RemoteSigningSuccess {
  final int transactionRemoteSignStatus;
  final String profileCode;
  final String signerName;
  final String signDate;

  RemoteSigningSuccess(
      {required this.signerName,
      required this.signDate,
      required this.profileCode,
      required this.transactionRemoteSignStatus});

  RemoteSigningSuccess.fromJson(Map<String, dynamic> json)
      : signerName = json["signerName"],
        signDate = json["signDate"],
        profileCode = json["profileCode"],
        transactionRemoteSignStatus = ApiConstants.switchRemoteSigningOk
            ? json["transactionRemoteSignStatus"]
            : json["status"];
}