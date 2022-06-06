import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile/components/userprofile_header.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile/components/userprofile_info.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile_edit/profileedit_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          const UserProfileHeader(),
          const SizedBox(
            height: 10,
          ),
          const UserProfileInfo(),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        side: BorderSide(color: Colors.black)))),
            child: Container(
              width: 250,
              height: 60,
              alignment: Alignment.center,
              //color: kPrimaryColor,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.00),
                ),
                color: Colors.black,
              ),
              child: const Text(
                "Sua thong tin",
                style: TextStyle(
                  fontFamily: "QuickSandMedium",
                  fontSize: 30,
                ),
              ),
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const UserProfileEditScreen()))
            },
          ),
        ],
      ),
    );
  }
}
