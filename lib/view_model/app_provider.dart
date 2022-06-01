import 'package:flutter/material.dart';

import '../model/module/deals.dart';
import '../model/module/product.dart';
import '../model/module/ui_models.dart';

class AppProvider with ChangeNotifier {
  ShowData<Product> productsShow = ShowData.empty();
  ShowData<OrderModel> ordersShow = ShowData.empty();
  int moneyInBox = -1;
  int revenue = -1;
  int orders = -1;

  Future<void> startApp() async {
    //graphData = await DataBaseRepository.instance.getGraphData();
    //graphData.orders = [1, 2, 3];

    notifyListeners();
  }

/*
  void getProducts() {
    if (productsShow.isEnd) return;
    productsShow.isLoading = true;
    notifyListeners();
    DataBaseRepository.instance.getSomeProducts(productsShow).then((value) {
      productsShow = value;
      notifyListeners();
    });
  }

  void getEntries() {
    if (entriesShow.isEnd) return;
    entriesShow.isLoading = true;
    notifyListeners();
    DataBaseRepository.instance.getSomeEntries(entriesShow).then((value) {
      entriesShow = value;
      notifyListeners();
    });
  }

  void getOrders() {
    if (ordersShow.isEnd) return;
    ordersShow.isLoading = true;
    notifyListeners();
    DataBaseRepository.instance.getSomeOrders(ordersShow).then((value) {
      ordersShow = value;
      notifyListeners();
    });
  }
*/
  void getMoneyInBox() {
    if (moneyInBox != -1) return;
    moneyInBox = 0;
    notifyListeners();
  }

  void calculateRevenue() {}

  void calculateOrders() {}
}
