import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/add_deal/add_entry.dart';
import 'package:flutter/material.dart';

class PaymentMethodLayout extends StatefulWidget {
  const PaymentMethodLayout({Key? key}) : super(key: key);

  @override
  _PaymentMethodLayout createState() => _PaymentMethodLayout();
}

class _PaymentMethodLayout extends State<PaymentMethodLayout> {
  int choose = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chọn phương thức thanh toán"),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () async {
            switch (choose) {
              case 0:
                Navigator.pop(context, "Tiền mặt");
                break;
              default:
                Navigator.pop(context, "Thẻ");
                break;
            }
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text("XÁC NHẬN"),
          ),
        ),
      )),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                //AddOrderView.of(context)!.onPaymentChange("Tiền mặt");
                setState(() {
                  choose = 0;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: choose == 0 ? Colors.blue : Colors.white,
                        width: 3),
                    boxShadow: StyleManager.shadow,
                    color: choose == 0
                        ? const Color.fromARGB(255, 225, 245, 255)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.attach_money_rounded,
                      size: 100,
                      color: choose == 0 ? Colors.lightBlue : Colors.black,
                    ),
                    Text(
                      "Tiền mặt",
                      style: TextStyle(
                        fontFamily: "QuicksandBold",
                        fontSize: 40,
                        color: choose == 0 ? Colors.lightBlue : Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                //AddOrderView.of(context)!.onPaymentChange("Thẻ");
                setState(() {
                  choose = 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: choose == 1 ? Colors.blue : Colors.white,
                        width: 3),
                    boxShadow: StyleManager.shadow,
                    color: choose == 1
                        ? const Color.fromARGB(255, 225, 245, 255)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance_rounded,
                      size: 100,
                      color: choose == 1 ? Colors.lightBlue : Colors.black,
                    ),
                    Text(
                      "Thẻ",
                      style: TextStyle(
                        fontFamily: "QuicksandBold",
                        fontSize: 40,
                        color: choose == 1 ? Colors.lightBlue : Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
