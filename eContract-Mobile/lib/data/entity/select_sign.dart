class SelectSign{
  final int id;
  final String name;
  final String description;
  final bool isDisable;
  final bool isCheck;

  const SelectSign(this.id, this.name, this.description, this.isDisable, this.isCheck);

  SelectSign.fromJson(Map<String, dynamic> json):
        id = json["id"],
        name= json["name"],
        description = json["description"],
        isDisable= json["isDisable"],
        isCheck= json["isCheck"];
}