import 'dart:async';

import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/order/order_list.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_detail_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shimmer/shimmer.dart';

class OrderLayout extends StatefulWidget {
  const OrderLayout({Key? key}) : super(key: key);

  @override
  _OrderLayout createState() => _OrderLayout();
}

class _OrderLayout extends State<OrderLayout> {
  final StorageService _storageService = StorageService();
  final OrderBloc _orderBloc = OrderBloc();
  late Future<OrderList?> orderListGet;
  OrderList? orderList;
  String userToken = "";
  //late OrderList orderListStream;

  /*
  final StreamController<OrderList> _myStreamCtrl =
      StreamController<OrderList>.broadcast();
  Stream<OrderList> get onVariableChanged => _myStreamCtrl.stream;
  void updateMyUI() => _myStreamCtrl.sink.add(orderListStream);
  */

  var now = DateTime.now();
  var formatter = DateFormat('dd/MM/yyyy');
  bool isChange = true;

  TextEditingController dateController = TextEditingController();
  String orderDate = "";
  DateTime currentDate = DateTime.now();

  Future<String?> getToken() async {
    return _storageService.readSecureData("UserToken");
  }

  Future<OrderList?> getListOrder(String token, String date) async {
    //print(date);
    OrderList? result = await _orderBloc.getListOrder(token, date);
    return result;
  }

  void refresh(String token, String date) async {
    setState(() {
      //orderList = getListOrder(token, date);
    });
  }

  @override
  void initState() {
    super.initState();
    String formattedDate = formatter.format(now);
    print(formattedDate);
    dateController.text = formattedDate;
    orderDate = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isChange = true;
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                FutureBuilder<String?>(
                    future: getToken(),
                    builder: (context, token) {
                      if (token.hasData) {
                        if (isChange) {
                          getListOrder(token.data.toString(), orderDate)
                              .then((value) {
                            orderList = value;
                            isChange = false;
                            if (mounted) {
                              setState(() {
                                userToken = token.data.toString();
                              });
                            }
                          });
                        }

                        //updateMyUI();
                        return Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 80,
                              //width: 150,
                              child: TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: myinputborder(),
                                  enabledBorder: myinputborder(),
                                  focusedBorder: myfocusborder(),
                                  contentPadding: const EdgeInsets.only(
                                      top: 0, left: 20, bottom: 0, right: 10),
                                ),
                                style: const TextStyle(
                                  fontFamily: "QuicksandMedium",
                                  fontSize: 20,
                                ),
                                //enabled: false,
                                readOnly: true,
                                focusNode: FocusNode(),
                                enableInteractiveSelection: false,
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime(1950, 1, 1),
                                    maxTime: DateTime.now(), //(2022, 12, 31),
                                    theme: const DatePickerTheme(
                                      headerColor: Color(0x1000ADFF),
                                      backgroundColor: Color(0xFFFFFFFF),
                                      itemStyle: TextStyle(
                                        color: Color(0xFF00ADFF),
                                        fontFamily: "QuickSandBold",
                                        fontSize: 20,
                                      ),
                                      doneStyle: TextStyle(
                                        color: Color(0xFF0085C3),
                                        fontSize: 20,
                                        fontFamily: "QuickSandBold",
                                      ),
                                      cancelStyle: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 20,
                                        fontFamily: "QuickSandBold",
                                      ),
                                    ),
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours
                                              .toString());
                                    },
                                    onConfirm: (date) async {
                                      print('confirm $date');
                                      String bd = "";
                                      if ((date.day >= 10) &&
                                          (date.month >= 10)) {
                                        bd = date.day.toString() +
                                            "/" +
                                            date.month.toString() +
                                            "/" +
                                            date.year.toString();
                                      }
                                      if ((date.day < 10) &&
                                          (date.month >= 10)) {
                                        bd = "0" +
                                            date.day.toString() +
                                            "/" +
                                            date.month.toString() +
                                            "/" +
                                            date.year.toString();
                                      }
                                      if ((date.day >= 10) &&
                                          (date.month < 10)) {
                                        bd = date.day.toString() +
                                            "/0" +
                                            date.month.toString() +
                                            "/" +
                                            date.year.toString();
                                      }
                                      if ((date.day < 10) &&
                                          (date.month < 10)) {
                                        bd = "0" +
                                            date.day.toString() +
                                            "/0" +
                                            date.month.toString() +
                                            "/" +
                                            date.year.toString();
                                      }
                                      print("Here: " + bd);
                                      dateController.text = bd;
                                      orderDate = dateController.text;
                                      isChange = true;

                                      if (isChange) {
                                        getListOrder(token.data.toString(),
                                                dateController.text.toString())
                                            .then((value) {
                                          orderList = value;
                                          isChange = false;
                                          if (mounted) {
                                            setState(() {
                                              currentDate = date;
                                            });
                                          }
                                        });
                                      }
                                    },
                                    currentTime: currentDate,
                                    locale: LocaleType.vi,
                                  );
                                },
                              ),
                            ),
                            orderList != null &&
                                    orderList!.content!.isNotEmpty &&
                                    !isChange
                                ? Column(
                                    children: <Widget>[
                                      ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "Tổng đơn hàng ${orderList!.content!.length}",
                                                  style: const TextStyle(
                                                    fontFamily: "QuicksandBold",
                                                    fontSize: 15,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  // thickness: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            height: 10,
                                            thickness: 0,
                                          ),
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                index ==
                                                        orderList!
                                                            .content!.length
                                                    ? listItem(
                                                        context,
                                                        orderList!
                                                            .content!.last,
                                                        index,
                                                        token.toString())
                                                    : listItem(
                                                        context,
                                                        orderList!
                                                            .content![index],
                                                        index,
                                                        token.toString()),
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(
                                              height: 10,
                                            ),
                                            itemCount:
                                                orderList!.content!.length,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  )
                                : orderList != null &&
                                        orderList!.content!.isEmpty &&
                                        !isChange
                                    ? Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.center,
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: const Text(
                                              "Bạn không có đơn hàng nào vào ngày này",
                                              style: TextStyle(
                                                  fontFamily: "QuicksandMedium",
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.blue,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 550,
                                          ),
                                        ],
                                      )
                                    : loadListOrder(context)
                          ],
                        );
                      }

                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          ),
        ));
  }

  Widget loadListOrder(BuildContext context) => Column(
        children: <Widget>[
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Shimmer.fromColors(
                      child: const Text("Tổng đơn hàng ",
                          style: TextStyle(
                            fontFamily: "QuicksandBold",
                            fontSize: 15,
                          )),
                      baseColor: const Color.fromARGB(255, 225, 225, 225),
                      highlightColor: Colors.white),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.onBackground,
                      // thickness: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 10,
                thickness: 0,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                    //height: 70,
                    color: Colors.white,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 225, 225, 225),
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              height: 30,
                              width: 70,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 225, 225, 225),
                            highlightColor: Colors.white,
                            child: Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                      isThreeLine: false,
                      onTap: () => {},
                      subtitle: Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 225, 225, 225),
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                      ), //ngay tao + so san pham
                      trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Tooltip(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.black),
                          message: "Tong tien",
                          child: Column(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 225, 225, 225),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: 25,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 225, 225, 225),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: 25,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                separatorBuilder: (_, __) => const SizedBox(
                  height: 10,
                ),
                itemCount: 10,
              )
            ],
          ),
        ],
      );

  Widget listItem(BuildContext context, ContentOrderList item, int index,
          String token) =>
      Container(
          //height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: StyleManager.shadow,
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "#" + item.orderId.toString(),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "QuicksandBold",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  item.customerName.toString(), //ten khach hang
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "QuicksandBold",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
              ],
            ),
            isThreeLine: false,
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OrderDetail(
                            id: item.orderId.toString(),
                            userToken: token,
                            cusPhone: item.customerPhone.toString(),
                          )))
            },
            subtitle: Text(
              "${item.totalQuantity} sản phẩm",
              style: const TextStyle(fontFamily: "QuicksandMedium"),
            ), //ngay tao + so san pham
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Tooltip(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black),
                message: "Tong tien",
                child: Column(
                  children: <Widget>[
                    Text(
                      MoneyFormatter(
                                  amount:
                                      item.totalPriceAfterDiscount!.toDouble())
                              .output
                              .nonSymbol
                              .toString() +
                          " VND",
                      style: const TextStyle(
                          fontSize: 17, fontFamily: "QuicksandMedium"),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          item.status.toString() == "Đã nhận hàng"
                              ? Icons.check
                              : item.status.toString() == "Từ chối"
                                  ? Icons.cancel
                                  : Icons.info_rounded,
                          size: 20,
                          color: item.status.toString() == "Đã nhận hàng"
                              ? Colors.green
                              : item.status.toString() == "Từ chối"
                                  ? Colors.red
                                  : Colors.orange,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(item.status.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                  color:
                                      item.status.toString() == "Đã nhận hàng"
                                          ? Colors.green
                                          : item.status.toString() == "Từ chối"
                                              ? Colors.red
                                              : Colors.orange,
                                ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Color(0xFF00ADFF),
          width: 2,
        ));
  }
  /*
  StreamBuilder<OrderList?>(
                            stream: orderListGet.asStream(),
                            //future: orderListGet,
                            //getListOrder(token.data.toString(), orderDate),
                            builder: (context, orderList) {
                              if (orderList.hasData) {
                                return Column(
                                  children: <Widget>[
                                    ListView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                "Tổng đơn hàng ${orderList.data!.content!.length}",
                                                style: const TextStyle(
                                                  fontFamily: "QuicksandBold",
                                                  fontSize: 15,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                // thickness: 10,
                                                height: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 10,
                                          thickness: 0,
                                        ),
                                        ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              index ==
                                                      orderList
                                                          .data!.content!.length
                                                  ? listItem(
                                                      context,
                                                      orderList
                                                          .data!.content!.last,
                                                      index,
                                                      token.toString())
                                                  : listItem(
                                                      context,
                                                      orderList.data!
                                                          .content![index],
                                                      index,
                                                      token.toString()),
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(
                                            height: 10,
                                          ),
                                          itemCount:
                                              orderList.data!.content!.length,
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              }

                              return loadListOrder(context);
                            })
   */
}
