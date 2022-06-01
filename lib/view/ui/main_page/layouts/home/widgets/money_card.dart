import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view_model/app_provider.dart';

import '../../../../../resources/routes_manger.dart';

class MoneyCard extends StatelessWidget {
  const MoneyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: StyleManager.border),
      child: Column(
        children: [
          upperBox(context),
          lowerBox(context),
        ],
      ),
    );
  }

  Widget upperBox(BuildContext context) => Hero(
      tag: "MoneyBox",
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Doanh thu",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                divider(),
                Selector<AppProvider, int>(
                  selector: (_, val) => val.moneyInBox,
                  builder: (context, val, _) => Text(
                    val == -1 ? '1000000' : "$val",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                divider(),
                Selector<AppProvider, int>(
                  selector: (_, val) => val.revenue,
                  builder: (context, val, _) => Text(
                    "VND",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
            verticalLine(context),
            Column(
              children: [
                Text("Don dat hang",
                    style: Theme.of(context).textTheme.subtitle1),
                divider(),
                Selector<AppProvider, int>(
                  selector: (_, val) => val.orders,
                  builder: (context, val, _) => Text(
                    val == -1 ? '100' : val.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ));

  Widget verticalLine(BuildContext context) => Container(
        height: 60.0,
        width: 1.0,
        color: Theme.of(context).colorScheme.onPrimary,
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      );

  Widget divider() => const SizedBox(
        height: 5.0,
      );

  Widget lowerBox(BuildContext context) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.moneyRoute);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              boxShadow: StyleManager.shadow,
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Thong tin chi tiet",
                style: Theme.of(context).textTheme.headline3,
              ),
              Icon(
                Icons.arrow_right_sharp,
                color: Theme.of(context).colorScheme.onSecondary,
              )
            ],
          ),
        ),
      );
}
