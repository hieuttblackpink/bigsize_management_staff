import 'package:bigsize_management_staff/view/ui/main_page/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:bigsize_management_staff/model/module/product.dart';
import 'package:bigsize_management_staff/view/ui/add_deal/add_entry.dart';
import 'package:bigsize_management_staff/view/ui/money_details/money_screen.dart';
//import 'package:shop/model/module/deals.dart';

//import '../../model/module/product.dart';
//import '../ui/add_deal/add_entry.dart';
//import '../ui/add_product/add_product.dart';
//import '../ui/main_page/main_screen.dart';
//import '../ui/money_details/money_screen.dart';

class Routes {
  static const String mainRoute = "/";
  static const String moneyRoute = "/Money";
  static const String addProductRoute = "/Product";
  static const String addOrderRoute = "/Order";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.moneyRoute:
        return MaterialPageRoute(builder: (_) => MoneyDetailsView());
      case Routes.addOrderRoute:
        return MaterialPageRoute(
            builder: (_) =>
                AddDealView(false, deal: settings.arguments as OrderModel?));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: const Center(child: Text("No Route Found")),
            ));
  }
}
