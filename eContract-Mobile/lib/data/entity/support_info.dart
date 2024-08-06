class SupportInfo{
  final List<String> url;


  const SupportInfo(this.url);

  SupportInfo.fromJson(Map<String, dynamic> json):
       url = [json['oA_Zalo'],json['pageID_FB'],json['hotline_Email'],json['hotline_Services'],json['hotline_Tech'],json['url_Buy']];
}