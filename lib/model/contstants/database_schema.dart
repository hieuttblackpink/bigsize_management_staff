part of "../repository/database_repo.dart";

class OrderTable {
  static const String tableName = 'orders';
  static const String id = 'id';
  static const String profit = 'profit';
  static const String totalMoney = 'totalMoney';
  static const String date = 'date';
  static const String time = 'time';
  static const String name = 'name';
  static const String type = 'type';
  static const String items = 'items';
}

class EntryTable {
  static const String tableName = 'entries';
  static const String id = 'id';
  static const String totalMoney = 'totalMoney';
  static const String date = 'date';
  static const String time = 'time';
  static const String name = 'name';
  static const String type = 'type';
  static const String items = 'items';
}

class MoneyEditTable {
  static const String tableName = 'moneyEdits';
  static const String id = 'id';
  static const String notes = 'notes';
  static const String amount = 'amount';
  static const String type = 'type';
  static const String date = 'date';
  static const String time = 'time';
}

class ProductsTable {
  static const String tableName = 'products';
  static const String id = 'id';
  static const String notes = 'notes';
  static const String name = 'name';
  static const String date = 'date';
  static const String amount = 'amount';
  static const String img = 'img';
  static const String realPrice = 'realPrice';
  static const String sellPrice = 'sellPrice';
}

class _TablesSchema {
  static const String _moneyEdit =
      '''CREATE TABLE  IF NOT EXISTS "${MoneyEditTable.tableName}" (
"${MoneyEditTable.id}"	INTEGER ,
"${MoneyEditTable.notes}"	TEXT,
"${MoneyEditTable.amount}"	NUMERIC,
"${MoneyEditTable.type}"	INTEGER,
"${MoneyEditTable.date}"	TEXT,
"${MoneyEditTable.time}"	TEXT,
PRIMARY KEY("id" AUTOINCREMENT)
);''';

  static const String _products =
      '''CREATE TABLE  IF NOT EXISTS  "${ProductsTable.tableName}" (
	"${ProductsTable.id}"	INTEGER,
	"${ProductsTable.notes}"	TEXT,
	"${ProductsTable.name}"	TEXT,
	"${ProductsTable.date}"	TEXT,
	"${ProductsTable.amount}"	NUMERIC,
	"${ProductsTable.img}"	TEXT,
	"${ProductsTable.realPrice}"	NUMERIC,
	"${ProductsTable.sellPrice}"	NUMERIC,
	PRIMARY KEY("id" AUTOINCREMENT)
);''';

  static const String _entries =
      '''CREATE TABLE  IF NOT EXISTS  "${EntryTable.tableName}" (
	"${EntryTable.id}"	INTEGER,
	"${EntryTable.totalMoney}"	NUMERIC,
	"${EntryTable.date}"	TEXT,
	"${EntryTable.time}"	TEXT,
	"${EntryTable.name}"	TEXT,
	"${EntryTable.type}"	INTEGER,
	"${EntryTable.items}"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);''';

  static const String _orders =
      '''CREATE TABLE  IF NOT EXISTS  "${OrderTable.tableName}" (
	"${OrderTable.id}"	INTEGER,
	"${OrderTable.profit}"	NUMERIC,
	"${OrderTable.totalMoney}"	NUMERIC,
	"${OrderTable.date}"	TEXT,
	"${OrderTable.time}"	TEXT,
	"${OrderTable.name}"	TEXT,
	"${OrderTable.type}"	INTEGER,
	"${OrderTable.items}"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);''';

  static List<String> get allSchemas =>
      [_moneyEdit, _products, _entries, _orders];
  static List<String> get allNames => [
        MoneyEditTable.tableName,
        ProductsTable.tableName,
        EntryTable.tableName,
        OrderTable.tableName
      ];
}
