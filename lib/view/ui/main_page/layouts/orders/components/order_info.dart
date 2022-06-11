import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  final OrderModel order;
  const OrderInfo({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        boxShadow: StyleManager.shadow,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Khach hang: " + order.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 18),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              "Dia chi: ",
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              "SDT: ",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const Text(
              "Ban boi: ",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Tai chi nhanh: ",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
          ]),
    );
  }
}
