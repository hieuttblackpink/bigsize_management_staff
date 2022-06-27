import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class OrderPayment extends StatelessWidget {
  final OrderModel order;
  OrderPayment({Key? key, required this.order}) : super(key: key);

  late String paid = "";

  @override
  Widget build(BuildContext context) {
    if (order.type.text == "Paid") {
      paid = "Dã thanh toán";
    } else {
      paid = "Chưa thanh toán";
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: StyleManager.shadow,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  order.type.icon,
                  size: 20,
                  color: order.type.color,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(paid,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: order.type.color))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Thanh toán bằng ví Momo **4597",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandMedium",
                  fontSize: 20),
            ),
          ]),
    );
  }
}
