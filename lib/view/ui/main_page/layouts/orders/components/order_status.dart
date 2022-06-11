import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key? key}) : super(key: key);

  final double wTL = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
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
                "Dat hang",
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
              child: const Text(
                "xx/xx/xxxx",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                "Duyet",
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
              child: const Text(
                "xx/xx/xxxx",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                "Dong goi",
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
              child: const Text(
                "xx/xx/xxxx",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                "Xuat kho",
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
              child: const Text(
                "xx/xx/xxxx",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                "Hoan thanh",
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
              child: const Text(
                "xx/xx/xxxx",
                textAlign: TextAlign.center,
                style: TextStyle(
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
