class ApiResponse {
  final int status;
  final dynamic object;
  final bool isOk;
  final bool isError;

  ApiResponse(this.status, this.object, this.isOk, this.isError);

  ApiResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        object = json["object"],
        isOk = json["isOk"],
        isError = json["isError"];
}
