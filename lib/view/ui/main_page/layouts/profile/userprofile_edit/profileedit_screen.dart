import 'package:bigsize_management_staff/models/user_profile.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class UserProfileEditScreen extends StatelessWidget {
  final String userToken;
  final StaffProfile? staffProfile;
  const UserProfileEditScreen(
      {Key? key, required this.staffProfile, required this.userToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin cá nhân"),
      ),
      body: Body(
        userToken: userToken,
        staffProfile: staffProfile,
      ),
    );
  }
}
