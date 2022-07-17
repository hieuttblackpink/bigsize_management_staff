import 'package:bigsize_management_staff/view/ui/main_page/layouts/notification/notification_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_detail_layout.dart';
import 'package:bigsize_management_staff/view/ui/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/model/module/deals.dart';

import '../../model/module/product.dart';
import '../ui/add_deal/add_entry.dart';
import '../ui/add_product/add_product.dart';
import '../ui/main_page/main_screen.dart';
import '../ui/money_details/money_screen.dart';

class Routes {
  static const String mainRoute = "/";
  static const String homeRoute = "/Home";
  static const String loginRoute = "/Login";
  static const String moneyRoute = "/Money";
  static const String addProductRoute = "/Product";
  static const String addEntryRoute = "/Entry";
  static const String addOrderRoute = "/Order";
  //static const String OrderDetailRoute = "/OrderDetail";
  static const String notificationRoute = "/Notification";
}

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return null;
      //return MaterialPageRoute(
      //builder: (_) => const /*MainView()*/ SignInScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.moneyRoute:
        return MaterialPageRoute(builder: (_) => MoneyDetailsView());
      case Routes.addProductRoute:
        return MaterialPageRoute(
            builder: (_) => AddProductView(settings.arguments as Product?));
      case Routes.addEntryRoute:
        return MaterialPageRoute(
            builder: (_) =>
                AddDealView(true, deal: settings.arguments as EntryModel?));
      case Routes.addOrderRoute:
        return MaterialPageRoute(
            builder: (_) =>
                AddDealView(false, deal: settings.arguments as OrderModel?));
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationLayout());
      //case Routes.OrderDetailRoute:
      //return MaterialPageRoute(builder: (_) => const OrderDetail());
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
