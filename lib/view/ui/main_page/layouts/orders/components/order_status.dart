import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatus extends StatelessWidget {
  final ContentOrderDetail orderContent;
  const OrderStatus({Key? key, required this.orderContent}) : super(key: key);

  final double wTL = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      alignment: Alignment.center,
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
              color: orderContent.approvalDate != null
                  ? Colors.blue
                  : orderContent.rejectedDate != null
                      ? Colors.red
                      : Colors.orange,
              iconStyle: IconStyle(
                  iconData: orderContent.approvalDate != null
                      ? Icons.check
                      : orderContent.rejectedDate != null
                          ? Icons.cancel
                          : Icons.info_outlined,
                  color: Colors.white),
            ),
            beforeLineStyle: LineStyle(
              color: orderContent.approvalDate != null
                  ? Colors.lightBlue
                  : Colors.grey,
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
                orderContent.approvalDate != null
                    ? orderContent.approvalDate!.substring(0, 5) +
                        "\n" +
                        orderContent.approvalDate!.substring(6, 10)
                    : orderContent.rejectedDate != null
                        ? "Đã từ chối"
                        : "",
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
              color: orderContent.approvalDate == null
                  ? Colors.grey
                  : orderContent.packagedDate == null
                      ? Colors.orange
                      : Colors.blue,
              iconStyle: IconStyle(
                  iconData: orderContent.approvalDate == null
                      ? Icons.circle_outlined
                      : orderContent.packagedDate == null
                          ? Icons.info_outline
                          : Icons.check,
                  color: Colors.white),
            ),
            beforeLineStyle: LineStyle(
              color: orderContent.packagedDate != null
                  ? Colors.lightBlue
                  : Colors.grey,
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
                orderContent.packagedDate != null
                    ? orderContent.packagedDate!.substring(0, 5) +
                        "\n" +
                        orderContent.packagedDate!.substring(6, 10)
                    : "",
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
              color: orderContent.approvalDate == null
                  ? Colors.grey
                  : orderContent.packagedDate == null
                      ? Colors.grey
                      : orderContent.deliveryDate == null
                          ? Colors.orange
                          : Colors.blue,
              iconStyle: IconStyle(
                  iconData: orderContent.approvalDate == null
                      ? Icons.circle_outlined
                      : orderContent.packagedDate == null
                          ? Icons.circle_outlined
                          : orderContent.deliveryDate == null
                              ? Icons.info_outlined
                              : Icons.check,
                  color: Colors.white),
            ),
            beforeLineStyle: LineStyle(
              color: orderContent.deliveryDate != null
                  ? Colors.lightBlue
                  : Colors.grey,
              thickness: 2,
            ),
            startChild: Container(
              alignment: Alignment.center,
              height: 30,
              width: wTL,
              child: const Text(
                "Giao hàng",
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
                orderContent.deliveryDate != null
                    ? orderContent.deliveryDate!.substring(0, 5) +
                        "\n" +
                        orderContent.deliveryDate!.substring(6, 10)
                    : "",
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
              color: orderContent.approvalDate == null
                  ? Colors.grey
                  : orderContent.packagedDate == null
                      ? Colors.grey
                      : orderContent.deliveryDate == null
                          ? Colors.grey
                          : orderContent.receivedDate == null
                              ? Colors.orange
                              : Colors.blue,
              iconStyle: IconStyle(
                  iconData: orderContent.approvalDate == null
                      ? Icons.circle_outlined
                      : orderContent.packagedDate == null
                          ? Icons.circle_outlined
                          : orderContent.deliveryDate == null
                              ? Icons.circle_outlined
                              : orderContent.receivedDate == null
                                  ? Icons.info_outlined
                                  : Icons.check,
                  color: Colors.white),
            ),
            beforeLineStyle: LineStyle(
              color: orderContent.receivedDate != null
                  ? Colors.lightBlue
                  : Colors.grey,
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
                orderContent.receivedDate != null
                    ? orderContent.receivedDate!.substring(0, 5) +
                        "\n" +
                        orderContent.receivedDate!.substring(6, 10)
                    : "",
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
