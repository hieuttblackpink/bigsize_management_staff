import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu(
      {Key? key,
      required this.text,
      required this.icon,
      this.press,
      this.colors})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: colors ?? Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shadowColor: Colors.grey,
        ),
        onPressed: press,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: colors ?? Colors.black,
              size: 20,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: TextStyle(
                fontFamily: "QuickSandMedium",
                fontSize: 20,
                color: colors ?? Colors.black,
              ),
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: colors ?? Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
