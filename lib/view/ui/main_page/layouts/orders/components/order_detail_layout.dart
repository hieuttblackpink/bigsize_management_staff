import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_info.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_payment.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class OrderDetail extends StatefulWidget {
  final String userToken;
  final String id;
  final String cusPhone;

  const OrderDetail(
      {Key? key,
      required this.id,
      required this.userToken,
      required this.cusPhone})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OrderDetail> createState() => _OrderDetail();
}

class _OrderDetail extends State<OrderDetail> {
  final OrderBloc _orderBloc = OrderBloc();

  Future<OrderDetailModel>? getOrder(String token, String id) async {
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
          FutureBuilder<OrderDetailModel?>(
              future: getOrder(widget.userToken, widget.id),
              builder: (context, order) {
                if (order.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                  width: 0.5)),
                          height: 50,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              "Ngày đặt hàng: " +
                                  order.data!.content!.createDate.toString(),
                              style: Theme.of(context).textTheme.headline4),
                        ),
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
                          cusPhone: widget.cusPhone,
                        ),
                        divider(),
                        ...List.generate(2, (index) => divider()),
                        const SizedBox(height: 15),
                        order.data!.content!.rejectedDate == null
                            ? Text("Hình thức thanh toán",
                                style: Theme.of(context).textTheme.headline4)
                            : Container(),
                        divider(),
                        order.data!.content!.rejectedDate == null
                            ? OrderPayment(order: order.data)
                            : Container(),
                        divider(),
                        ...List.generate(2, (index) => divider()),
                        const SizedBox(height: 15),
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
                          height: 10,
                        ),
                        const Text(
                          "Đơn vị tính: VND",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "QuicksandBold", fontSize: 15),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        /*
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
                            : Container(),*/
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                }

                return loadingWidget(context);
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
                  MoneyFormatter(
                          amount: double.parse(
                              num.parse(totalPrice).toStringAsFixed(0)))
                      .output
                      .nonSymbol
                      .toString(),
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
                Text("Sản phẩm", style: Theme.of(context).textTheme.subtitle1),
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
                  //width: 180,
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
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  //width: 170,
                  //color: Colors.pinkAccent,
                  child: Text(
                    MoneyFormatter(
                            amount: double.parse(
                                num.parse(totalPrice).toStringAsFixed(0)))
                        .output
                        .nonSymbol
                        .toString(),
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
                  //width: 180,
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
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  //width: 170,
                  //color: Colors.pinkAccent,
                  child: Text(
                    MoneyFormatter(
                            amount: double.parse(
                                    num.parse(totalPrice).toStringAsFixed(0)) -
                                double.parse(num.parse(pricePromotion)
                                    .toStringAsFixed(0)))
                        .output
                        .nonSymbol
                        .toString(),
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
                  //width: 180,
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
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  //width: 170,
                  //color: Colors.pinkAccent,
                  child: Text(
                    MoneyFormatter(
                            amount: double.parse(
                                num.parse(pricePromotion).toStringAsFixed(0)))
                        .output
                        .nonSymbol
                        .toString(),
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
                product.productName.toString() +
                    " - " +
                    product.colour.toString() +
                    " - " +
                    product.size.toString(),
              ),
              Text(
                MoneyFormatter(
                            amount: double.parse(
                                num.parse(product.pricePerOne.toString())
                                    .toStringAsFixed(0)))
                        .output
                        .nonSymbol
                        .toString() +
                    " d/cái",
              ),
              Text(
                "Số lượng: " + product.quantity.toString() + " cái",
              )
            ],
          ),
          trailing: Column(children: <Widget>[
            Text(
              MoneyFormatter(
                      amount: double.parse(num.parse(product.price.toString())
                          .toStringAsFixed(0)))
                  .output
                  .nonSymbol
                  .toString(),
              style: const TextStyle(fontFamily: "QuicksandMedium"),
            ),
          ]),
        ),
      );

  Widget loadingWidget(BuildContext context) => Container(
        alignment: Alignment.center,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.black,
                      width: 0.5)),
              height: 50,
              padding: const EdgeInsets.only(left: 15),
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 225, 225, 225),
                highlightColor: Colors.white,
                child: const Text("Ngày đặt hàng: ",
                    style: TextStyle(
                        fontFamily: "QuicksandMedium",
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(2, (index) => divider()),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Text("Thông tin đơn hàng",
                  style: Theme.of(context).textTheme.headline4),
            ),
            divider(),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            divider(),
            ...List.generate(2, (index) => divider()),
            const SizedBox(height: 15),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Text("Hình thức thanh toán",
                  style: Theme.of(context).textTheme.headline4),
            ),
            divider(),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            divider(),
            ...List.generate(2, (index) => divider()),
            const SizedBox(height: 15),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Text("Danh sách sản phẩm",
                  style: Theme.of(context).textTheme.headline4),
            ),
            divider(),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 225, 225, 225),
              highlightColor: Colors.white,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            /*
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
                            : Container(),*/
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
}
