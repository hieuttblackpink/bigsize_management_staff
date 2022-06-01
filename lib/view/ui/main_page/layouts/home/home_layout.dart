import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/home/widgets/money_card.dart';
import 'package:bigsize_management_staff/view/ui/main_page/widgets/line_graph.dart';
import 'package:bigsize_management_staff/view_model/app_provider.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  final rng = Random();
  late final List<int> dummyData = List.generate(10, (i) => rng.nextInt(100));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 2),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              top: 5,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black,
                    width: 0.25)),
            height: 50,
            padding: const EdgeInsets.only(left: 15),
            child: const Text(
              "Xin chao, Tran Trong Hieu",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "QuicksandBold",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Text("Tinh hinh kinh doanh hom nay",
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(
                height: 10,
              ),
              const MoneyCard(),
              const SizedBox(
                height: 10,
              ),
              /*
              Text("Sales Last month",
                  style: Theme.of(context).textTheme.headline4),
              LineGraph(context.select<AppProvider, List<int>>(
                  (val) => val.graphData.moneyGraph)),
              const SizedBox(
                height: 5,
              ),
              Text("Orders Last month",
                  style: Theme.of(context).textTheme.headline4),
              LineGraph(context.select<AppProvider, List<int>>(
                  (val) => val.graphData.ordersGraph)),
              */
            ],
          ),
        ],
      ),
    );
  }
}
