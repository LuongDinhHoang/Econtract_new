class ChangePasswordInfo{
  final String reasonError;
  final bool isOk;

  const ChangePasswordInfo({required this.reasonError,required this.isOk});

  ChangePasswordInfo.fromJson(Map<String, dynamic> json):
        reasonError= json["object"],
        isOk= json["isOk"];
}
