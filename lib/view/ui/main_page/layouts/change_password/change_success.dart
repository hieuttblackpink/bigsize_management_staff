import 'package:flutter/material.dart';

class ChangePasswordSuccess extends StatelessWidget {
  const ChangePasswordSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: MediaQuery.of(context).size.height * 0.4, //40%
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Text(
          "Đổi mật khẩu thành công",
          style: TextStyle(
            fontSize: (30 / 812.0) * MediaQuery.of(context).size.height,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            textColor: Colors.white,
            padding: const EdgeInsets.all(0),
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: Colors.black),
              padding: const EdgeInsets.all(0),
              child: const Text(
                "XÁC NHẬN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "QuickSandBold",
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
