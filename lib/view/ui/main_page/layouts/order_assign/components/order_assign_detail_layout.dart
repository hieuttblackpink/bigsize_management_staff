import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:bigsize_management_staff/models/order/order_exported.dart';
import 'package:bigsize_management_staff/models/order/order_packaged.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/order_assign/components/order_assign_info.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/order_assign/components/order_assign_status.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_info.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_payment.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class OrderAssignDetail extends StatefulWidget {
  final String userToken;
  final String id;

  const OrderAssignDetail({Key? key, required this.id, required this.userToken})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<OrderAssignDetail> createState() => _OrderAssignDetail();
}

class _OrderAssignDetail extends State<OrderAssignDetail> {
  final OrderBloc _orderBloc = OrderBloc();

  Future<OrderDetailModel>? getOrder(String token, String id) async {
    return await _orderBloc.getOrder(token, id);
  }

  Future<OrderPackaged> updateToPackage(String token, int id) async {
    return await _orderBloc.updateOrderToPackaged(token, id);
  }

  Future<OrderExported> updateToExported(String token, int id) async {
    return await _orderBloc.updateOrderToExported(token, id);
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
                        Text(
                            "Ngày đặt hàng: " +
                                order.data!.content!.createDate.toString(),
                            style: Theme.of(context).textTheme.headline4),
                        const SizedBox(height: 10),
                        OrderAssignStatus(
                          orderContent: order.data!.content!,
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(2, (index) => divider()),
                        Text("Thông tin đơn hàng",
                            style: Theme.of(context).textTheme.headline4),
                        divider(),
                        OrderAssignInfo(
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
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        side: BorderSide(color: Colors.red)))),
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
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)), side: BorderSide(color: Colors.blue)))),
                                onPressed: () async {
                                  if (order.data!.content!.packagedDate ==
                                      null) {
                                    OrderPackaged isPackaged =
                                        await updateToPackage(widget.userToken,
                                            int.parse(widget.id));
                                    if (isPackaged.isSuccess!) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OrderAssignDetail(
                                                    id: widget.id,
                                                    userToken: widget.userToken,
                                                  )));
                                    } else {
                                      showAlertDialog(context,
                                          "Có lỗi xảy ra khi cập nhật trạng thái đơn hàng này");
                                    }
                                  }

                                  if (order.data!.content!.deliveryDate ==
                                      null) {
                                    OrderExported isPackaged =
                                        await updateToExported(widget.userToken,
                                            int.parse(widget.id));
                                    if (isPackaged.isSuccess!) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Cập nhật trạng thái đơn hàng thành công", // message
                                          toastLength:
                                              Toast.LENGTH_SHORT, // length
                                          gravity:
                                              ToastGravity.CENTER, // location
                                          timeInSecForIosWeb: 1 // duration
                                          );
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OrderAssignDetail(
                                                    id: widget.id,
                                                    userToken: widget.userToken,
                                                  )));
                                    } else {
                                      showAlertDialog(context,
                                          "Có lỗi xảy ra khi cập nhật trạng thái đơn hàng này");
                                    }
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      order.data!.content!.deliveryDate == null
                                          ? 60
                                          : 0,
                                  width: 200,
                                  child: Text(
                                    order.data!.content!.packagedDate == null
                                        ? "Đã đóng gói"
                                        : order.data!.content!.deliveryDate ==
                                                null
                                            ? "Đã giao"
                                            : "",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontFamily: "QuicksandMedium",
                                      fontSize: 20,
                                    ),
                                  ),
                                )),
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
                product.productName.toString() +
                    " - " +
                    product.colour.toString() +
                    " - " +
                    product.size.toString(),
              ),
              Text(
                product.pricePerOne.toString() + " d/cái",
              ),
              Text(
                "Số lượng: " + product.quantity.toString() + " cái",
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

  showAlertDialog(context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Thông báo"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
          ],
        ),
      );
}
