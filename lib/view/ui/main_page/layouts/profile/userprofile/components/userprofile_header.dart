import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: StyleManager.shadow,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          //color: Colors.white,
          width: 400,
          height: 50,
          child: const Text(
            "Tran Trong Hieu",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "QuickSandBold",
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
