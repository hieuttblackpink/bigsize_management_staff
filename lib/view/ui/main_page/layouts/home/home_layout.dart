// ignore_for_file: avoid_print, no_logic_in_create_state

import 'dart:math';

import 'package:bigsize_management_staff/blocs/staff_bloc.dart';
import 'package:bigsize_management_staff/blocs/store_bloc.dart';
import 'package:bigsize_management_staff/models/store.dart';
import 'package:bigsize_management_staff/models/user_profile.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/home/widgets/money_card.dart';
import 'package:bigsize_management_staff/view/ui/main_page/widgets/line_graph.dart';
import 'package:bigsize_management_staff/view_model/app_provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayout createState() => _HomeLayout();
}

class _HomeLayout extends State<HomeLayout> {
  final StorageService _storageService = StorageService();
  final StaffBloc _staffBloc = StaffBloc();
  final StoreBloc _storeBloc = StoreBloc();

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<StaffProfile?> getStaffProfile(String token) async {
    return await _staffBloc.getProfile(token);
  }

  Future<Store?> getStore(String token, String id) async {
    return await _storeBloc.getStore(token, id);
  }

  final rng = Random();
  late final List<int> dummyData = List.generate(10, (i) => rng.nextInt(100));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 2),
      child: Column(
        children: <Widget>[
          FutureBuilder<String?>(
              future: getUserToken(),
              builder: (context, shot) {
                if (shot.hasData) {
                  //print("Snap token:" + shot.data.toString());
                  return FutureBuilder<StaffProfile?>(
                      future: getStaffProfile(shot.data.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(children: <Widget>[
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
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Text(
                                  "Xin chào, " +
                                      snapshot.data!.content!.fullname
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "QuicksandBold",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FutureBuilder<Store?>(
                                future: getStore(shot.data.toString(),
                                    snapshot.data!.content!.storeId.toString()),
                                builder: (context, store) {
                                  if (store.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        boxShadow: StyleManager.shadow,
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: const <Widget>[
                                              Icon(
                                                Icons.location_pin,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Chi nhánh cửa hàng",
                                                style: TextStyle(
                                                  fontFamily: "QuicksandBold",
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.store,
                                                color: Colors.blue,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  store.data!.content!
                                                      .storeAddress!
                                                      .toString(),
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontFamily: "QuicksandBold",
                                                    fontSize: 20,
                                                    color: Colors.black,
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
                                              const Icon(
                                                Icons.phone,
                                                color: Colors.blue,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                store.data!.content!.storePhone
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily: "QuicksandBold",
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      boxShadow: StyleManager.shadow,
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              255, 200, 200, 200),
                                          highlightColor: Colors.white,
                                          child: Container(
                                            height: 30,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              255, 200, 200, 200),
                                          highlightColor: Colors.white,
                                          child: Container(
                                            height: 30,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              255, 200, 200, 200),
                                          highlightColor: Colors.white,
                                          child: Container(
                                            height: 30,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ]);
                        }

                        return Column(
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
                              child: Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(0.5),
                                highlightColor: Colors.white,
                                child: const Text(
                                  "Xin chào",
                                  style: TextStyle(
                                    fontFamily: "QuicksandBold",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                boxShadow: StyleManager.shadow,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        255, 200, 200, 200),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: 30,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        255, 200, 200, 200),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: 30,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        255, 200, 200, 200),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: 30,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                }

                return const CircularProgressIndicator();
              }),
          const SizedBox(
            height: 20,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Text("Tình hình kinh doanh hôm nay",
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
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
