import 'dart:convert';

class UnitUserInfo {
  final bool? isSelectUnit;
  final String? unitGuidDefault;
  final List<ListUnit>? unitList;

  const UnitUserInfo( {
    this.isSelectUnit,
    this.unitGuidDefault,
    this.unitList,});

  UnitUserInfo.fromJson(Map<String, dynamic> json)
      : isSelectUnit = json["isSelectUnit"],
        unitGuidDefault = json["unitGuidDefault"],
        unitList = parseListSigner(
            jsonEncode(json['ltUnit'])
        );
  static List<ListUnit> parseListSigner(
      String listSigner) {
    final parsed = jsonDecode(listSigner).cast<Map<String, dynamic>>();
    return parsed
        .map<ListUnit>((json) =>
        ListUnit.fromJson(json))
        .toList();
  }
}
class ListUnit {
  final String name;
  final String objectGuid;
  final String code;

  const ListUnit( {
    required this.name,
    required this.objectGuid,
    required this.code,});

  ListUnit.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        objectGuid = json["objectGuid"],
        code = json["code"];
}