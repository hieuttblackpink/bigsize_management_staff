import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/order_detail.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_info.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_payment.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_status.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetail extends StatefulWidget {
  final String userToken;
  final String id;

  const OrderDetail({Key? key, required this.id, required this.userToken})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OrderDetail> createState() => _OrderDetail();
}

class _OrderDetail extends State<OrderDetail> {
  final OrderBloc _orderBloc = OrderBloc();

  Future<OrderDetailBloc>? getOrder(String token, String id) async {
    return await _orderBloc.getOrder(token, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 15,
        title: Text("Đơn hàng #" + widget.id),
        //actions: getRightAction(value, context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          FutureBuilder<OrderDetailBloc?>(
              future: getOrder(widget.userToken, widget.id),
              builder: (context, order) {
                if (order.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Text(
                            "Ngày đặt hàng: " +
                                order.data!.content!.createDate.toString(),
                            style: Theme.of(context).textTheme.headline4),
                        const SizedBox(height: 10),
                        OrderStatus(
                          orderContent: order.data!.content!,
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(2, (index) => divider()),
                        Text("Thông tin đơn hàng",
                            style: Theme.of(context).textTheme.headline4),
                        divider(),
                        OrderInfo(
                          orderInfo: order.data!.content!,
                        ),
                        divider(),
                        ...List.generate(2, (index) => divider()),
                        const SizedBox(height: 20),
                        Text("Hình thức thanh toán",
                            style: Theme.of(context).textTheme.headline4),
                        divider(),
                        //OrderPayment(order: order),
                        divider(),
                        ...List.generate(2, (index) => divider()),
                        const SizedBox(height: 20),
                        Text("Danh sách sản phẩm",
                            style: Theme.of(context).textTheme.headline4),
                        divider(),
                        listProduct(context, order.data!.content!.productList),
                        const SizedBox(
                          height: 20,
                        ),
                        BillInfo(
                            context,
                            order.data!.content!.totalPrice!.toString(),
                            order.data!.content!.totalPriceAfterDiscount
                                .toString()),
                        const SizedBox(
                          height: 50,
                        ),
                        order.data!.content!.approvalDate == null
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            side: BorderSide(
                                                color: Colors.red)))),
                                onPressed: () => {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 200,
                                  child: const Text(
                                    "Hủy đơn hàng",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "QuicksandMedium",
                                      fontSize: 20,
                                    ),
                                  ),
                                ))
                            : Container(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                }

                return const CircularProgressIndicator();
              })
        ]),
      ),
    );
  }

  Widget upperBox(
          BuildContext context, String totalPrice, String totalProduct) =>
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  totalPrice,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontFamily: "QuicksandBold",
                    fontSize: 30,
                  ),
                ),
                divider(),
                const Text(
                  "VND",
                  style: TextStyle(
                      fontFamily: "QuicksandMedium",
                      color: Colors.black,
                      fontSize: 20),
                )
              ],
            ),
            verticalLine(context),
            Column(
              children: [
                Text("San pham", style: Theme.of(context).textTheme.subtitle1),
                divider(),
                Text(totalProduct,
                    style: Theme.of(context).textTheme.subtitle1),
                divider(),
              ],
            ),
          ],
        ),
      );

  Widget verticalLine(BuildContext context) => Container(
        height: 60.0,
        width: 1.0,
        color: Theme.of(context).colorScheme.onPrimary,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      );

  Widget divider() => const SizedBox(
        height: 5.0,
      );

  // ignore: non_constant_identifier_names
  Widget BillInfo(
          BuildContext context, String totalPrice, String pricePromotion) =>
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  //color: Colors.white,
                  child: const Text(
                    "Đơn giá",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 170,
                  //color: Colors.pinkAccent,
                  child: Text(
                    totalPrice,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
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
                Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  //color: Colors.white,
                  child: const Text(
                    "Giảm giá",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 170,
                  //color: Colors.pinkAccent,
                  child: const Text(
                    "0",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandMedium",
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
                Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  //color: Colors.white,
                  child: const Text(
                    "Khách hàng phải trả",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandBold",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 170,
                  //color: Colors.pinkAccent,
                  child: Text(
                    pricePromotion,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "QuickSandBold",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget listProduct(BuildContext context, List<ProductList>? listP) =>
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => index == listP!.length
            ? listItemProduct(context, listP.last, index)
            : listItemProduct(context, listP[index], index),
        itemCount: listP!.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: 10,
        ),
      );

  Widget listItemProduct(
          BuildContext context, ProductList product, int index) =>
      Container(
        alignment: Alignment.center,
        child: ListTile(
          leading: Image.network(
            product.productImageUrl.toString(),
            width: 50,
            height: 50,
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.productName.toString(),
              ),
              Text(
                product.pricePerOne.toString(),
              ),
              Text(
                product.quantity.toString(),
              )
            ],
          ),
          trailing: Column(children: <Widget>[
            Text(
              product.price.toString(),
            ),
          ]),
        ),
      );
}
