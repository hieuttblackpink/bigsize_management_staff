import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/entry/entry_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/home/home_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/order_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_layout.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/setting/setting_layout.dart';

import '../../../view_model/layout_provider.dart';
import '../../resources/routes_manger.dart';

const List<String> appBarTitles = [
  "Trang chu",
  "Don dat hang",
  "Entry",
  "Products",
  "Profile"
];

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

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
          HomeLayout(),
          const OrderLayout(),
          const EntryLayout(),
          const ProductLayout(),
          const SettingLayout(),
        ][value],
      ),
    );
  }

  List<Widget> getRightAction(int activeLayout, BuildContext context) {
    if (activeLayout > 0 && activeLayout < 3) {
      return [
        IconButton(
            onPressed: () {
              switch (activeLayout) {
                case 1:
                  break;
                case 2:
                  break;
                case 3:
                  break;
              }
            },
            icon: const Icon(Icons.search)),
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
            icon: const Icon(
              Icons.add,
              size: 35,
            )),
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
