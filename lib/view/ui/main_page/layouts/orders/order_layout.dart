import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/order_list.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_detail_layout.dart';
import 'package:flutter/material.dart';

class OrderLayout extends StatefulWidget {
  const OrderLayout({Key? key}) : super(key: key);

  @override
  _OrderLayout createState() => _OrderLayout();
}

class _OrderLayout extends State<OrderLayout> {
  final StorageService _storageService = StorageService();
  final OrderBloc _orderBloc = OrderBloc();

  Future<String?> getToken() async {
    return _storageService.readSecureData("UserToken");
  }

  Future<OrderList?> getListOrder(String token) async {
    return await _orderBloc.getListOrder(token);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          FutureBuilder<String?>(
              future: getToken(),
              builder: (context, token) {
                if (token.hasData) {
                  return Column(
                    children: <Widget>[
                      FutureBuilder<OrderList?>(
                          future: getListOrder(token.data.toString()),
                          builder: (context, orderList) {
                            if (orderList.hasData) {
                              return Column(
                                children: <Widget>[
                                  ListView(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "Tong don hang ${orderList.data!.content!.length}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
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
                                                    orderList
                                                        .data!.content![index],
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

                            return const CircularProgressIndicator();
                          })
                    ],
                  );
                }

                return const CircularProgressIndicator();
              }),
        ],
      ),
    );
  }

  Widget listItem(
          BuildContext context, Content item, int index, String token) =>
      Container(
          //height: 70,
          color: Colors.white,
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
                const Text(
                  "", //item.,//ten khach hang
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
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
                          )))
            },
            //subtitle: Text("${item.date} | ${item.itemsCount} items"), //ngay tao + so san pham
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
                      "${item.totalPriceAfterDiscount} VND",
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          item.status.toString() == "Đã nhận hàng"
                              ? Icons.check
                              : Icons.cancel,
                          size: 20,
                          color: item.status.toString() == "Đã nhận hàng"
                              ? Colors.green
                              : Colors.red,
                        ),
                        Text(item.status.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                  color:
                                      item.status.toString() == "Đã nhận hàng"
                                          ? Colors.green
                                          : Colors.red,
                                ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
}
