import 'package:flutter/material.dart';

import '../repository/database_repo.dart';

enum EditType { add, remove }

extension GetWidget on EditType {
  String get text {
    switch (this) {
      case EditType.remove:
        return "Remove";
      case EditType.add:
        return "Add";
    }
  }

  Color get color {
    switch (this) {
      case EditType.remove:
        return Colors.red;
      case EditType.add:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (this) {
      case EditType.remove:
        return Icons.remove;
      case EditType.add:
        return Icons.add;
    }
  }
}

class OldMoneyEdit {
  int id;
  EditType type;
  String date;
  String time;
  String notes;
  int amount;

  OldMoneyEdit(
      {required this.type,
      required this.notes,
      required this.date,
      required this.amount,
      required this.id,
      required this.time});

  factory OldMoneyEdit.fromJson(Map<String, dynamic> json) {
    return OldMoneyEdit(
        id: json[MoneyEditTable.id],
        type: json[MoneyEditTable.type] == 0 ? EditType.add : EditType.remove,
        notes: json[MoneyEditTable.notes],
        date: json[MoneyEditTable.date],
        amount: json[MoneyEditTable.amount],
        time: json[MoneyEditTable.time]);
  }

  Map<String, dynamic> get toJson {
    return {
      MoneyEditTable.id: id,
      MoneyEditTable.notes: notes,
      MoneyEditTable.date: date,
      MoneyEditTable.amount: amount,
      MoneyEditTable.time: time,
      MoneyEditTable.type: type == EditType.add ? 0 : 1
    };
  }
}
