import 'package:drift/drift.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:equatable/equatable.dart';

class ListSignInfo {
  final int? id;
  final String? name;
  final String? tooltip;
  final String? description;
  final bool? isDisable;
  final bool? isCheck;

  const ListSignInfo(this.id, this.name, this.tooltip, this.description, this.isDisable, this.isCheck);

  ListSignInfo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        tooltip = json["tooltip"],
        description = json["description"],
        isDisable = json["isDisable"],
        isCheck = json["isCheck"];
}