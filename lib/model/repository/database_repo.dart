import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:bigsize_management_staff/model/module/old_edit_money.dart';
import 'package:bigsize_management_staff/model/module/product.dart';
import 'package:sqflite/sqflite.dart';

import '../module/ui_models.dart';

part '../contstants/database_schema.dart';

part 'files_handling.dart';

const String _dataBasePath = "data.db";
typedef ReturnedData = List<Map<String, dynamic>>;

class DataBaseRepository {
  static DataBaseRepository? _instance;
  static DataBaseRepository get instance => _instance ??= DataBaseRepository();

  late Database _database;
  String get dataBasePath => _database.path;

  DataBaseRepository() {
    _initDataBase();
  }

  set database(Database? database) {
    _database = database ?? _database;
  }

  /// get products by id for deals
  Future<Product> getProduct(String id) async {
    ReturnedData data = await _database.query(ProductsTable.tableName,
        where: "${ProductsTable.id} = ?", whereArgs: [id]);
    if (data.isEmpty) return Product.empty();
    return Product.fromJson(data.first);
  }

  Future<List<Product>> getProducts(List<String> ids) async {
    ReturnedData data = await _database.query(ProductsTable.tableName,
        where: "${ProductsTable.id} IN (${ids.join(',')})");
    return data.map((e) => Product.fromJson(e)).toList();
  }

  /// get Data for showing in home screen
  Future<GraphsData> getGraphData() async {
    return GraphsData.empty();
  }

  Future<ShowData<Product>> getSomeProducts(ShowData<Product> old) async {
    old.maxNumber = await _countData(ProductsTable.tableName);
    old.getNext();
    ReturnedData maps = await _database.query(
      ProductsTable.tableName,
      limit: old.end,
      offset: old.start,
    );
    old.data.addAll(maps.map((e) => Product.fromJson(e)).toList());
    return old..isLoading = false;
  }

  Future<ShowData<EntryModel>> getSomeEntries(ShowData<EntryModel> old) async {
    old.maxNumber = await _countData(EntryTable.tableName);
    old.getNext();

    ReturnedData maps = await _database.query(
      EntryTable.tableName,
      limit: old.end,
      offset: old.start,
    );
    old.data.addAll(maps.map((e) => EntryModel.fromJson(e)).toList());
    return old..isLoading = false;
  }

  Future<ShowData<OrderModel>> getSomeOrders(ShowData<OrderModel> old) async {
    old.maxNumber = await _countData(OrderTable.tableName);
    old.getNext();
    ReturnedData maps = await _database.query(
      OrderTable.tableName,
      limit: old.end,
      offset: old.start,
    );
    old.data.addAll(maps.map((e) => OrderModel.fromJson(e)).toList());
    return old..isLoading = false;
  }

  Future<ShowData<OldMoneyEdit>> getSomeMoneyEdits(
      ShowData<OldMoneyEdit> old) async {
    old.maxNumber = await _countData(MoneyEditTable.tableName);
    old.getNext();
    ReturnedData maps = await _database.query(
      MoneyEditTable.tableName,
      limit: old.end,
      offset: old.start,
    );
    old.data.addAll(maps.map((e) => OldMoneyEdit.fromJson(e)).toList());
    return old..isLoading = false;
  }

  /// filter data
  Future<List<Product>> searchProducts(String search) async {
    ReturnedData data = await _database.query(ProductsTable.tableName,
        where: "${ProductsTable.name} LIKE '%$search%'");
    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<EntryModel>> searchEntries(String search) async {
    ReturnedData data = await _database.query(EntryTable.tableName,
        where: "${EntryTable.name} LIKE '%$search%'");
    return data.map((e) => EntryModel.fromJson(e)).toList();
  }

  Future<List<OrderModel>> searchOrders(String search) async {
    ReturnedData data = await _database.query(OrderTable.tableName,
        where: "${OrderTable.name} LIKE '%$search%'");
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }

  /// money Box calculation

  /// insert data to database
  Future<void> insertProduct(Product product) async {
    await _database.insert(
        ProductsTable.tableName, product.toJson.remove(ProductsTable));
  }

  Future<void> insertEntry(EntryModel entry) async {
    await _database.insert(
        EntryTable.tableName, entry.toJson.remove(EntryTable.id));
  }

  Future<void> insertOrder(OrderModel order) async {
    await _database.insert(
        OrderTable.tableName, order.toJson.remove(OrderTable.id));
  }

  Future<void> insertMoneyEdit(OldMoneyEdit oldEditMoney) async {
    await _database.insert(MoneyEditTable.tableName,
        oldEditMoney.toJson.remove(MoneyEditTable.id));
  }

  /// edit data in database
  Future<void> editProduct(Product product) async {
    await _database.update(
        ProductsTable.tableName, product.toJson.remove(ProductsTable),
        where: '${ProductsTable.id} = ?', whereArgs: [product.id]);
  }

  Future<void> editEntry(EntryModel entry) async {
    await _database.update(
        EntryTable.tableName, entry.toJson.remove(EntryTable.id),
        where: '${EntryTable.id} = ?', whereArgs: [entry.id]);
  }

  Future<void> editOrder(OrderModel order) async {
    await _database.update(
        OrderTable.tableName, order.toJson.remove(OrderTable.id),
        where: '${OrderTable.id} = ?', whereArgs: [order.id]);
  }

  Future<void> editMoneyEdit(OldMoneyEdit oldEditMoney) async {
    await _database.update(
        MoneyEditTable.tableName, oldEditMoney.toJson.remove(MoneyEditTable.id),
        where: '${MoneyEditTable.id} = ?', whereArgs: [oldEditMoney.id]);
  }

  /// get reports data
  Future<ReturnedData> getZeroAmountProduct() async {
    ReturnedData data = await _database.query(ProductsTable.tableName,
        where: "${ProductsTable.amount} = 0");
    return data;
  }

  Future<ReturnedData> getLessAmountProduct(int min) async {
    ReturnedData data = await _database.query(ProductsTable.tableName,
        where: "${ProductsTable.amount} < $min");
    return data;
  }

  Future<ReturnedData> getAllProducts() async {
    ReturnedData data = await _database.query(ProductsTable.tableName);
    return data;
  }

  Future<ReturnedData> getAllEntries() async {
    ReturnedData data = await _database.query(EntryTable.tableName);
    return data;
  }

  Future<ReturnedData> getAllMoneyEdits() async {
    ReturnedData data = await _database.query(MoneyEditTable.tableName);
    return data;
  }

  Future<ReturnedData> getAllOrders() async {
    ReturnedData data = await _database.query(OrderTable.tableName);
    return data;
  }

  /// delete data from database
  Future<void> deleteProduct(int id) async {
    await _database.delete(ProductsTable.tableName,
        where: "${ProductsTable.id} = ?", whereArgs: [id]);
  }

  Future<void> deleteAllProducts() async {
    await _database.delete(ProductsTable.tableName);
  }

  Future<void> deleteOrder(int id) async {
    await _database.delete(OrderTable.tableName,
        where: "${OrderTable.id} = ?", whereArgs: [id]);
  }

  Future<void> deleteAllOrders() async {
    await _database.delete(OrderTable.tableName);
  }

  Future<void> deleteEntry(int id) async {
    await _database.delete(EntryTable.tableName,
        where: "${EntryTable.id} = ?", whereArgs: [id]);
  }

  Future<void> deleteAllEntries() async {
    await _database.delete(EntryTable.tableName);
  }

  Future<void> deleteAllMoneyEdits() async {
    await _database.delete(MoneyEditTable.tableName);
  }

  Future<void> deleteMoneyEdit(int id) async {
    await _database.delete(MoneyEditTable.tableName,
        where: "${MoneyEditTable.id} = ?", whereArgs: [id]);
  }

  Future<int> _countData(String tableName) async {
    ReturnedData value =
        await _database.rawQuery("SELECT COUNT(*) FROM $tableName");
    return value[0]['COUNT(*)'];
  }

  Future<void> _initDataBase() async {
    _database = await openDatabase(_dataBasePath,
        version: 1, onCreate: _createDataBase);
  }

  Future<void> _createDataBase(Database db, int _) async {
    for (String schema in _TablesSchema.allSchemas) {
      await db.execute(schema);
    }
  }

  Future<void> dispose() async => await _database.close();

  Future<void> delete() async {
    for (String name in _TablesSchema.allNames) {
      await _database.delete(name);
    }
  }
}
