import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class OrderAssignInfo extends StatelessWidget {
  final ContentOrderDetail orderInfo;
  const OrderAssignInfo({Key? key, required this.orderInfo}) : super(key: key);

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
              "Khách hàng: " +
                  orderInfo.deliveryAddress!.receiverName.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 18),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "Địa chỉ nhận hàng: " +
                  orderInfo.deliveryAddress!.receiveAddress.toString(),
              softWrap: true,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "SĐT: " + orderInfo.deliveryAddress!.receiverPhone.toString(),
              style: const TextStyle(
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
            Text(
              "Nhân viên bán hàng: " + orderInfo.staffName.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Tại chi nhánh: " + orderInfo.store!.storeAddress.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "QuicksandMedium",
              ),
            ),
          ]),
    );
  }
}
