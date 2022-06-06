import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile_edit/components/profileedit_form.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile_edit/components/profileedit_header.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          //const UserProfileEditHeader(),
          const SizedBox(
            height: 2,
          ),
          EditProfileForm(
              name: "Tran Trong Hieu",
              dob: "06/06/2000",
              phone: "0918224597",
              email: ""),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
