import 'package:bigsize_management_staff/view/ui/main_page/layouts/change_password/change_password.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/setting/components/setting_menu.dart';
import 'package:flutter/material.dart';

class InSettingLayout extends StatefulWidget {
  const InSettingLayout({Key? key}) : super(key: key);

  @override
  State<InSettingLayout> createState() => _InSettingLayout();
}

class _InSettingLayout extends State<InSettingLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cài đặt"),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                SettingMenu(
                    text: "Đổi mật khẩu",
                    icon: Icons.lock_rounded,
                    press: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ChangePassword()))
                        }),
                const SizedBox(
                  height: 0.5,
                ),
              ],
            )));
  }
}
