import 'package:e_contract/utils/utils.dart';

class CopyAddressModel {
  String signer;
  String address;
  String deadline;

  CopyAddressModel(
      {required this.signer, required this.address, required this.deadline});

  CopyAddressModel.fromJson(Map<String, dynamic> json)
      : signer = json['signerName'],
        address = json['urlPageSign'],
        deadline = Utils.convertTimeFDTF(
            time: json['expiredDate'], type: ConstFDTFString.m1bM2d);
}
