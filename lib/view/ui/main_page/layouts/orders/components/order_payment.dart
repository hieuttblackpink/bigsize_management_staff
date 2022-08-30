import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class OrderPayment extends StatelessWidget {
  final OrderDetailModel? order;
  OrderPayment({Key? key, required this.order}) : super(key: key);

  late String paid = "";

  @override
  Widget build(BuildContext context) {
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
            /*
            Row(
              children: <Widget>[
                Icon(
                  order!.content!.paymentMethod == null
                      ? Icons.cancel_rounded
                      : Icons.check_circle_rounded,
                  size: 20,
                  color: order!.content!.paymentMethod == null
                      ? Colors.red
                      : Colors.green,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                    order!.content!.paymentMethod == null
                        ? "Chưa thanh toán"
                        : "Đã thanh toán",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: order!.content!.paymentMethod == null
                              ? Colors.red
                              : Colors.green,
                        ))
              ],
            ),*/
            const SizedBox(
              height: 5,
            ),
            Text(
              order!.content!.paymentMethod.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandMedium",
                  fontSize: 20),
            ),
          ]),
    );
  }
}
