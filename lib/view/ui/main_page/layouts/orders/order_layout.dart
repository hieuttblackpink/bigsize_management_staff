import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/module/deals.dart';
import '../../../../../model/module/ui_models.dart';
import '../../../../../view_model/app_provider.dart';

ShowData<OrderModel> test = ShowData.empty();

List<OrderModel> orderL = [];

OrderModel order1 = OrderModel(
    items: [],
    id: 1,
    type: PaymentType.paid,
    totalMoney: 5000,
    name: "Tran Trong Hieu",
    date: "01/01/2022",
    time: "9:00",
    profit: 50);

class OrderLayout extends StatelessWidget {
  const OrderLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderL.isEmpty) {
      orderL.add(order1);
    }
    test.data = orderL;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Selector<AppProvider, ShowData<OrderModel>>(
        selector: (context, appProvider) => test,
        builder: (context, entries, _) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Text("Tong don hang ${entries.data.length}",
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    // thickness: 10,
                    height: 10,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
              thickness: 0,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => index == entries.data.length
                  ? entries.lastItem
                  : listItem(context, entries.data[index]),
              separatorBuilder: (_, __) => const SizedBox(
                height: 7,
              ),
              itemCount: entries.data.length + 1,
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, OrderModel item) => ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "#" + item.id.toString(),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
          ],
        ),
        isThreeLine: false,
        subtitle: Container(
          color: Colors.pinkAccent,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("${item.date} | ${item.itemsCount} items"),
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Tooltip(
            message: "Profit is ${item.profit}",
            child: Column(
              children: <Widget>[
                Text(
                  "${item.totalMoney} VND",
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      item.type.icon,
                      size: 20,
                      color: item.type.color,
                    ),
                    Text(item.type.text,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: item.type.color))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                /**/
                GestureDetector(
                  child: const Text(">"),
                ),
              ],
            ),
          ),
        ),
      );
}
