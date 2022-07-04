// ignore_for_file: no_logic_in_create_state

import 'package:bigsize_management_staff/models/user/user_profile.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile_edit/components/profileedit_form.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final String userToken;
  final StaffProfile? staffProfile;
  const Body({Key? key, required this.staffProfile, required this.userToken})
      : super(key: key);

  @override
  _Body createState() => _Body(userToken, staffProfile);
}

class _Body extends State<Body> {
  final String userToken;
  final StaffProfile? staffProfile;

  _Body(this.userToken, this.staffProfile);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 2,
          ),
          EditProfileForm(
              userToken: userToken,
              name: staffProfile!.content!.fullname.toString(),
              dob: staffProfile!.content!.birthday.toString(),
              phone: staffProfile!.content!.phoneNumber.toString(),
              email: staffProfile!.content!.email.toString()),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
