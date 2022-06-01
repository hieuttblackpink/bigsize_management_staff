import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bigsize_management_staff/model/repository/database_repo.dart';
import '../model/local/pref_repository.dart';

class SettingProvider with ChangeNotifier {
  late int minimumAmount = PreferenceRepository.getDataFromSharedPreference(
        key: PreferenceKey.minimumAmount,
      ) ??
      15;

  final DbFileHandling _fileHandling = DbFileHandling();

  Future<void> clearDataBase() async {
    EasyLoading.show(status: "Deleting database");
    try {
      await DataBaseRepository.instance.delete();
      EasyLoading.showSuccess("Database deleted successfully");
    } catch (err) {
      EasyLoading.showError("An error accrued,Please try again");
    }
  }

  void hidePrice() {
    EasyLoading.showToast("Not yet");
  }

  void changeMinimumAmount(int value) {
    minimumAmount = value;
    PreferenceRepository.putDataInSharedPreference(
      value: value,
      key: PreferenceKey.minimumAmount,
    );
    notifyListeners();
  }

  Future<void> exportDataBase() async {
    EasyLoading.show(status: 'preparing report');
    try {
      await _fileHandling.exportDataBase();
      EasyLoading.showSuccess(
          "File saved successfully,check at you file manager ");
    } catch (err) {
      EasyLoading.showError("An error accrued,Please try again");
    }
  }

  Future<void> importDataBase() async {
    try {
      EasyLoading.show(status: 'Reading file');
      DataBaseRepository.instance.database =
          await _fileHandling.importDataBase();
      EasyLoading.showSuccess("File read successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }

  void printZeroProduct() async {
    EasyLoading.show(status: 'Preparing report');
    ReturnedData products =
        await DataBaseRepository.instance.getZeroAmountProduct();
    try {
      await _fileHandling.saveCsv(products, "Zero Product");
      EasyLoading.showSuccess("File saved successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }

  void printLessProduct() async {
    print(minimumAmount);
    EasyLoading.show(status: 'Preparing report');
    ReturnedData products =
        await DataBaseRepository.instance.getLessAmountProduct(minimumAmount);
    try {
      await _fileHandling.saveCsv(products, "Less Product");
      EasyLoading.showSuccess("File saved successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }

  void printAllProduct() async {
    EasyLoading.show(status: 'Preparing report');
    ReturnedData products = await DataBaseRepository.instance.getAllProducts();
    try {
      await _fileHandling.saveCsv(products, "All Product");
      EasyLoading.showSuccess("File saved successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }

  void printAllEntries() async {
    EasyLoading.show(status: 'Preparing report');
    ReturnedData products = await DataBaseRepository.instance.getAllEntries();
    try {
      await _fileHandling.saveCsv(products, "All Entries");
      EasyLoading.showSuccess("File saved successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }

  void printAllOrders() async {
    ReturnedData products = await DataBaseRepository.instance.getAllOrders();
    EasyLoading.show(status: 'Preparing report');
    try {
      await _fileHandling.saveCsv(products, "All Orders");
      EasyLoading.showSuccess("File saved successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }

  void printAllMoneyEdit() async {
    EasyLoading.show(status: 'Preparing report');

    ReturnedData products =
        await DataBaseRepository.instance.getAllMoneyEdits();
    try {
      await _fileHandling.saveCsv(products, "All Money Edit");
      EasyLoading.showSuccess("File saved successfully");
    } catch (err) {
      EasyLoading.showError("Ann error accrued,Please try again");
    }
  }
}
