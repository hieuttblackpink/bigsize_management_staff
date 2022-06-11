import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_info.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_payment.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_status.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetail extends StatefulWidget {
  final OrderModel order;

  const OrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OrderDetail> createState() => _OrderDetail(order: order);
}

class _OrderDetail extends State<OrderDetail> {
  final OrderModel order;

  _OrderDetail({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 15,
        title: Text("Order #" + order.id.toString()),
        //actions: getRightAction(value, context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Text("Ngay dat hang: " + order.time + ", " + order.date,
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 10),
              const OrderStatus(),
              const SizedBox(height: 20),
              upperBox(context),
              ...List.generate(2, (index) => divider()),
              const SizedBox(height: 20),
              Text("Thong tin don hang",
                  style: Theme.of(context).textTheme.headline4),
              divider(),
              OrderInfo(order: order),
              divider(),
              ...List.generate(2, (index) => divider()),
              const SizedBox(height: 20),
              Text("Hinh thuc thanh toan",
                  style: Theme.of(context).textTheme.headline4),
              divider(),
              OrderPayment(order: order),
              divider(),
              ...List.generate(2, (index) => divider()),
              const SizedBox(height: 20),
              Text("Danh sach san pham",
                  style: Theme.of(context).textTheme.headline4),
              divider(),
              //OldEntryList(),
              const SizedBox(
                height: 20,
              ),
              BillInfo(context),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () => {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 200,
                    child: const Text(
                      "Huy don hang",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "QuicksandMedium",
                        fontSize: 20,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget upperBox(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "" + order.totalMoney.toString() + "",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontFamily: "QuicksandBold",
                    fontSize: 30,
                  ),
                ),
                divider(),
                const Text(
                  "VND",
                  style: TextStyle(
                      fontFamily: "QuicksandMedium",
                      color: Colors.black,
                      fontSize: 20),
                )
              ],
            ),
            verticalLine(context),
            Column(
              children: [
                Text("San pham", style: Theme.of(context).textTheme.subtitle1),
                divider(),
                Text(order.itemsCount.toString() + "",
                    style: Theme.of(context).textTheme.subtitle1),
                divider(),
              ],
            ),
          ],
        ),
      );

  Widget verticalLine(BuildContext context) => Container(
        height: 60.0,
        width: 1.0,
        color: Theme.of(context).colorScheme.onPrimary,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      );

  Widget divider() => const SizedBox(
        height: 5.0,
      );

  // ignore: non_constant_identifier_names
  Widget BillInfo(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  //color: Colors.white,
                  child: const Text(
                    "Tong tien hang",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 170,
                  //color: Colors.pinkAccent,
                  child: const Text(
                    "xxxxxxx",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  //color: Colors.white,
                  child: const Text(
                    "Thue",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 170,
                  //color: Colors.pinkAccent,
                  child: const Text(
                    "0",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  //color: Colors.white,
                  child: const Text(
                    "Khach hang phai tra",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandBold",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 170,
                  //color: Colors.pinkAccent,
                  child: const Text(
                    "xxxxxxx",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandBold",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
