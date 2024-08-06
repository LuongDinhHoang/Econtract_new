///Bkav Nhungltk: model contract search
class ContractSearch{
  int categoryId;
  String categoryName="";
  String objectId="";
  String objectName="";
  ContractSearch({required this.categoryId, required this.categoryName, required this.objectId, required this.objectName});
  ContractSearch.fromJson(Map<String, dynamic> json):
      categoryId= json["categoryId"],
  categoryName= json["categoryName"],
  objectId= json["objectId"],
  objectName= json["objectName"];
}

class GroupContractSearch{
  int categoryId;
  String categoryName;
  List<ObjectSearch> list;
  GroupContractSearch({required this.categoryId, required this.categoryName, required this.list});
}

class ObjectSearch{
  String objectId;
  String objectName;
  ObjectSearch({required this.objectId, required this.objectName});
}

class Category{
  int categoryId;
  String categoryName;
  Category({required this.categoryId, required this.categoryName});
}