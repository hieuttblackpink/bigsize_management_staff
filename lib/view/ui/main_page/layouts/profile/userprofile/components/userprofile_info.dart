import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 500.0,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: StyleManager.shadow,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              RowUP().rowUPRow("SDT", "0918224597", 30),
              const SizedBox(
                height: 10,
              ),
              RowUP().rowUPRow("Ngay sinh", "06/06/2000", 20),
              const SizedBox(
                height: 10,
              ),
              RowUP().rowUPRow("Email", "abcdsubcvd@gmail.com", 20),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: use_key_in_widget_constructors
class RowUP extends Row {
  Row rowUPRow(String title, String content, double textSize) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          width: 180,
          margin: const EdgeInsets.only(top: 20, left: 10),
          //color: Colors.blue,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "QuickSandBold",
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: 180,
          margin: const EdgeInsets.only(top: 20, left: 0),
          //color: Colors.red,
          child: Text(
            content,
            softWrap: true,
            style: TextStyle(
              fontFamily: "QuickSandBold",
              fontSize: textSize,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
