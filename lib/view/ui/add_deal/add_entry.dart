// ignore_for_file: list_remove_unrelated_type

import 'package:bigsize_management_staff/blocs/customer_bloc.dart';
import 'package:bigsize_management_staff/blocs/order_bloc.dart';
import 'package:bigsize_management_staff/models/customer/customer.dart';
import 'package:bigsize_management_staff/models/customer/new_customer.dart';
import 'package:bigsize_management_staff/models/order/new_order.dart';
import 'package:bigsize_management_staff/models/order/order_return.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/add_deal/widgets/customer_box.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/orders/components/order_detail_layout.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/model/module/deals.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../model/repository/dates_repository.dart';
import '../../resources/styles_manager.dart';
import 'widgets/add_box.dart';
import 'widgets/order_product_list.dart';

class AddDealView extends StatefulWidget {
  const AddDealView(this.isEntry, {this.deal, Key? key}) : super(key: key);
  //static TabsState of(BuildContext context) => context.findAncestorStateOfType<TabsState>();
  final Deal? deal;
  final bool isEntry;

  @override
  AddOrderView createState() => AddOrderView();
}

class AddOrderView extends State<AddDealView> {
  static AddOrderView? of(BuildContext context) =>
      context.findAncestorStateOfType<AddOrderView>();

  final StorageService _storageService = StorageService();
  final CustomerBloc _customerBloc = CustomerBloc();
  final OrderBloc _orderBloc = OrderBloc();

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<Customer> createCustomer(String token, NewCustomer newCustomer) async {
    return await _customerBloc.createCustomer(token, newCustomer);
  }

  Future<NewOrderReturn> createOrder(String token, NewOrder newOrder) async {
    return await _orderBloc.createOrder(token, newOrder);
  }

  double totalPrice = 0;
  int totalProduct = 0;

  bool isNewCus = true;
  String cusPhone = "";
  String cusName = "";
  String payment = "";
  List<ProductInNewOrder> listProduct = [];

  void onCusPhoneChange(String phone, bool isNewCusChange) {
    setState(() {
      cusPhone = phone;
      isNewCus = isNewCusChange;
    });
  }

  void onCusNameChange(String name) {
    setState(() {
      cusName = name;
    });
  }

  void onPaymentChange(String pay) {
    setState(() {
      payment = pay;
    });
  }

  void onProductDetailChange(ProductInNewOrder product) {
    print("On product detail change: " +
        product.productDetailId.toString() +
        " " +
        product.quantity.toString());
    var isExistProduct = listProduct
        .where((element) => element.productDetailId == product.productDetailId);
    if (isExistProduct.isNotEmpty) {
      var indexProduct = listProduct.indexWhere(
          (element) => element.productDetailId == product.productDetailId);
      if (product.quantity == 0) {
        setState(() {
          listProduct.removeAt(indexProduct.toInt());
        });
      } else {
        setState(() {
          listProduct[indexProduct.toInt()].quantity = product.quantity;
        });
      }
    } else {
      setState(() {
        listProduct.add(product);
      });
    }
  }

  void onProductChange(double price, int product) {
    setState(() {
      totalPrice += price;
      totalProduct += product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool willLeave = false;
          // show the confirm dialog
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text(
                        'Bạn có muốn thoát không?\nDữ liệu đơn hàng này sẽ bị xóa.'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            willLeave = true;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Thoát')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Ở lại'))
                    ],
                  ));
          return willLeave;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
              appBar: AppBar(
                title: Text(
                    "${widget.deal == null ? "Tạo" : "Edit"} ${widget.isEntry ? "entry" : "đơn hàng"}"),
                actions: [
                  IconButton(
                      onPressed: () {
                        DateRepository.selectDate(
                            context: context, initial: DateTime.now());
                      },
                      icon: const Icon(Icons.calendar_today))
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                  color: Colors.white.withOpacity(0),
                  child: BlurryContainer(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.2),
                    blur: 0,
                    height: 170,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ListTile(
                            title: const Text(
                              "Tạm tính",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "QuicksandBold",
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            isThreeLine: false,
                            trailing: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                MoneyFormatter(amount: totalPrice)
                                        .output
                                        .nonSymbol
                                        .toString() +
                                    " VND",
                                style: const TextStyle(
                                  fontFamily: "QuicksandBold",
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                String? token = await getUserToken();
                                print("Token: " + token.toString());
                                print("Cus phone: " + cusPhone);
                                print("Cus name: " + cusName);
                                print("IsNewCus: " + isNewCus.toString());
                                print("Pay: " + payment);
                                print("List Product:");
                                for (var item in listProduct) {
                                  print(item.productDetailId.toString() +
                                      " - " +
                                      item.quantity.toString());
                                }

                                if (isNewCus) {
                                  NewCustomer newCustomer = NewCustomer(
                                      phoneNumber: cusPhone,
                                      fullname: cusName,
                                      email: "empty@gmail.com",
                                      gender: true);
                                  Customer newCus = await createCustomer(
                                      token.toString(), newCustomer);

                                  if (newCus.isSuccess!) {
                                    NewOrder newOrder = NewOrder(
                                        customerPhoneNumber: cusPhone,
                                        paymentMethod: "Cash",
                                        listProduct: listProduct);
                                    NewOrderReturn orderReturn =
                                        await createOrder(
                                            token.toString(), newOrder);
                                    if (orderReturn.isSuccess!) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OrderDetail(
                                                    id: orderReturn
                                                        .content!.orderId
                                                        .toString(),
                                                    userToken: token.toString(),
                                                  )));
                                    } else {
                                      print("Error when create order!");
                                    }
                                  } else {
                                    print("Error when create customer!");
                                  }
                                } else {
                                  NewOrder newOrder = NewOrder(
                                      customerPhoneNumber: cusPhone,
                                      paymentMethod: "Cash",
                                      listProduct: listProduct);
                                  NewOrderReturn orderReturn =
                                      await createOrder(
                                          token.toString(), newOrder);
                                  if (orderReturn.isSuccess!) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OrderDetail(
                                                  id: orderReturn
                                                      .content!.orderId
                                                      .toString(),
                                                  userToken: token.toString(),
                                                )));
                                  } else {
                                    print("Error when create order!");
                                  }
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          side: BorderSide(
                                              color: Colors.black)))),
                              child: Container(
                                width: 120,
                                height: 40,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Tạo đơn hàng",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text("Ngày tạo đơn: ${DateTime.now().formatDate}",
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 10),
                    upperBox(context),
                    ...List.generate(2, (index) => divider()),
                    Text("Khách hàng",
                        style: Theme.of(context).textTheme.headline4),
                    divider(),
                    const CustomerBox(),
                    const SizedBox(height: 10),
                    Text("Phương thức thanh toán",
                        style: Theme.of(context).textTheme.headline4),
                    divider(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: StyleManager.shadow,
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: StyleManager.border),
                      height: 45,
                      child: GestureDetector(
                        onTap: () => {},
                        child: const Text(
                          "Chọn phương thức thanh toán",
                          style: TextStyle(
                            fontFamily: "QuicksandMedium",
                            fontSize: 20,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    divider(),
                    const AddBox(),
                    ...List.generate(2, (index) => divider()),
                    divider(),
                    //const OrderProductList(),
                  ],
                ),
              )),
        ));
  }

  Widget upperBox(BuildContext context) => Container(
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
                  "Tổng tiền",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                divider(),
                Text(
                  MoneyFormatter(amount: totalPrice)
                          .output
                          .nonSymbol
                          .toString() +
                      " VND",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            verticalLine(context),
            Column(
              children: [
                Text("Sản phẩm", style: Theme.of(context).textTheme.subtitle1),
                divider(),
                Text(totalProduct.toString(),
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
}
