import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:flutter/material.dart';

class OrderPayment extends StatelessWidget {
  final OrderModel order;
  OrderPayment({Key? key, required this.order}) : super(key: key);

  late String paid = "";

  @override
  Widget build(BuildContext context) {
    if (order.type.text == "Paid") {
      paid = "Da thanh toan";
    } else {
      paid = "Chua thanh toan";
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                Text(paid,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: order.type.color))
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "Thanh toan bang vi Momo **4597",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandMedium",
                  fontSize: 20),
            ),
          ]),
    );
  }
}
