// ignore_for_file: avoid_print, no_logic_in_create_state

import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_search.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/order_assign/order_assign_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/home/home_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/order_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/setting/setting_layout.dart';

import '../../../view_model/layout_provider.dart';
import '../../resources/routes_manger.dart';

const List<String> appBarTitles = [
  "Trang chủ",
  "Đơn đặt hàng",
  "Don hang online",
  "Sản phẩm",
  "Tài khoản"
];

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainView createState() => _MainView();
}

class _MainView extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<LayoutProvider, int>(
      selector: (_, val) => val.activeLayout,
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          titleSpacing: 15,
          title: Text(appBarTitles[value]),
          actions: getRightAction(value, context),
        ),
        bottomNavigationBar: bottomNavigationBar(value, context),
        body: [
          const HomeLayout(),
          const OrderLayout(),
          const OrderAssignLayout(),
          const ProductLayout(),
          const SettingLayout(),
        ][value],
      ),
    );
  }

  List<Widget> getRightAction(int activeLayout, BuildContext context) {
    if (activeLayout > 0 && activeLayout < 4) {
      return [
        IconButton(
            onPressed: () {
              switch (activeLayout) {
                case 1:
                  break;
                case 2:
                  break;
                case 3:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SearchProductLayout()));
                  break;
              }
            },
            icon: activeLayout == 3
                ? const Icon(Icons.search)
                : const Icon(null)),
        IconButton(
            onPressed: () {
              switch (activeLayout) {
                case 1:
                  Navigator.pushNamed(context, Routes.addOrderRoute);
                  break;
                case 2:
                  Navigator.pushNamed(context, Routes.addEntryRoute);
                  break;
                case 3:
                  Navigator.pushNamed(context, Routes.addProductRoute);
                  break;
              }
            },
            icon: activeLayout == 1
                ? const Icon(
                    Icons.add,
                    size: 35,
                  )
                : const Icon(null)),
        const SizedBox(
          width: 5,
        ),
      ];
    } else {
      return [];
    }
  }

  Widget bottomNavigationBar(int activeLayout, BuildContext context) => GNav(
      selectedIndex: activeLayout,
      onTabChange: (newIndex) {
        context.read<LayoutProvider>().changeActiveLayout = newIndex;
      },
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      duration: const Duration(milliseconds: 300),
      gap: 4,
      color: Theme.of(context).colorScheme.onBackground,
      activeColor: Theme.of(context).colorScheme.onSecondary,
      iconSize: 24,
      tabBackgroundColor: Theme.of(context).colorScheme.onSurface,
      padding: const EdgeInsets.all(10),
      tabMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      tabs: List.generate(
          appBarTitles.length,
          (index) => GButton(
                icon: [
                  Icons.home_outlined,
                  Icons.local_mall,
                  Icons.shopping_cart_outlined,
                  Icons.storefront_outlined,
                  Icons.account_circle,
                ][index],
                text: appBarTitles[index],
              )));
}
