import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatus extends StatelessWidget {
  final Content orderContent;
  const OrderStatus({Key? key, required this.orderContent}) : super(key: key);

  final double wTL = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      width: double.infinity,
      //color: const Color.fromARGB(255, 224, 244, 253),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.center,
            isFirst: true,
            indicatorStyle: IndicatorStyle(
              height: 30,
              width: 50,
              color: Colors.blue,
              iconStyle: IconStyle(iconData: Icons.check, color: Colors.white),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.lightBlue,
              thickness: 2,
            ),
            startChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: wTL,
              child: const Text(
                "Đặt hàng",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
            endChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: 60,
              child: Text(
                orderContent.createDate!.substring(0, 5) +
                    "\n" +
                    orderContent.createDate!.substring(6, 10),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
          ),
          TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.center,
            indicatorStyle: IndicatorStyle(
              height: 30,
              color: Colors.blue,
              iconStyle: IconStyle(iconData: Icons.check, color: Colors.white),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.lightBlue,
              thickness: 2,
            ),
            startChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: wTL,
              child: const Text(
                "Duyệt",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
            endChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: 60,
              child: Text(
                orderContent.approvalDate!.substring(0, 5) +
                    "\n" +
                    orderContent.createDate!.substring(6, 10),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
          ),
          TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.center,
            indicatorStyle: IndicatorStyle(
              height: 30,
              color: Colors.blue,
              iconStyle: IconStyle(iconData: Icons.check, color: Colors.white),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.lightBlue,
              thickness: 2,
            ),
            startChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: wTL,
              child: const Text(
                "Đóng gói",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
            endChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: 60,
              child: Text(
                orderContent.packagedDate!.substring(0, 5) +
                    "\n" +
                    orderContent.createDate!.substring(6, 10),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
          ),
          TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.center,
            indicatorStyle: IndicatorStyle(
              height: 30,
              color: Colors.blue,
              iconStyle: IconStyle(iconData: Icons.check, color: Colors.white),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.lightBlue,
              thickness: 2,
            ),
            startChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: wTL,
              child: const Text(
                "Xuất kho",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
            endChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: 60,
              child: Text(
                orderContent.deliveryDate!.substring(0, 5) +
                    "\n" +
                    orderContent.createDate!.substring(6, 10),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
          ),
          TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.center,
            isLast: true,
            indicatorStyle: IndicatorStyle(
              height: 30,
              color: Colors.blue,
              iconStyle: IconStyle(iconData: Icons.check, color: Colors.white),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.lightBlue,
              thickness: 2,
            ),
            startChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: wTL,
              child: const Text(
                "Hoàn thành",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
            endChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: 60,
              child: Text(
                orderContent.receivedDate!.substring(0, 5) +
                    "\n" +
                    orderContent.createDate!.substring(6, 10),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "QuicksandBold",
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
