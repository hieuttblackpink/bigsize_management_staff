import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../repository/database_repo.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  int id;
  String date;
  Uint8List img; //TODO: CORRECT TYPE
  String name;
  String notes;
  double amount;
  double realPrice;
  double sellPrice;

  Product(
      {required this.notes,
      required this.name,
      required this.date,
      required this.amount,
      required this.id,
      required this.img,
      required this.realPrice,
      required this.sellPrice});

  Map<String, dynamic> get toJson => {
        ProductsTable.notes: notes,
        ProductsTable.date: date,
        ProductsTable.name: name,
        ProductsTable.id: id,
        ProductsTable.sellPrice: sellPrice,
        ProductsTable.realPrice: realPrice,
        ProductsTable.amount: amount,
        ProductsTable.img: img,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        notes: json[ProductsTable.notes],
        name: json[ProductsTable.name],
        date: json[ProductsTable.date],
        amount: json[ProductsTable.amount],
        id: json[ProductsTable.id],
        img: json[ProductsTable.img],
        realPrice: json[ProductsTable.realPrice],
        sellPrice: json[ProductsTable.sellPrice]);
  }

  factory Product.empty() {
    return Product(
        notes: 'This product has no notes',
        name: 'Old Product',
        date: '',
        amount: 0,
        id: 0,
        img: Uint8List(0),
        realPrice: 0,
        sellPrice: 0);
  }

  @override
  List<Object?> get props => [id];
}
