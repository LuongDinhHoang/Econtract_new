class InitAccessToken{
  final String accessTokenEKYC;
  final int typeEKYC;
  final String signerCode;

  const InitAccessToken(this.accessTokenEKYC, this.typeEKYC, this.signerCode);

  InitAccessToken.fromJson(Map<String, dynamic> json):
        accessTokenEKYC = json["accessTokenEKYC"],
        typeEKYC = json["typeEKYC"],
        signerCode= json["signerCode"];
}