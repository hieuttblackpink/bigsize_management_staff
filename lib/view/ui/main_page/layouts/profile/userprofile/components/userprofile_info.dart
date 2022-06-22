// ignore_for_file: no_logic_in_create_state

import 'package:bigsize_management_staff/blocs/staff_bloc.dart';
import 'package:bigsize_management_staff/models/user_profile.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:bigsize_management_staff/resources/theme_manager.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile_edit/profileedit_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileInfo extends StatefulWidget {
  final String userToken;
  const UserProfileInfo({
    Key? key,
    required this.userToken,
  }) : super(key: key);

  @override
  _UserProfileInfo createState() => _UserProfileInfo(userToken);
}

class _UserProfileInfo extends State<UserProfileInfo> {
  final String userToken;
  final StaffBloc _staffBloc = StaffBloc();

  _UserProfileInfo(this.userToken);

  Future<StaffProfile?> getStaffProfile(String token) async {
    return await _staffBloc.getProfile(token);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RefreshIndicator(
            onRefresh: () => getStaffProfile(userToken),
            child: FutureBuilder<StaffProfile?>(
                future: getStaffProfile(userToken),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      height: 500.0,
                      width: 450,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorManager.backGroundBlue,
                        //boxShadow: StyleManager.shadow,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.white,
                              boxShadow: StyleManager.shadow,
                            ),
                            child: RowUP().rowUPRow(
                              Icons.phone_android_rounded,
                              snapshot.data!.content!.phoneNumber.toString(),
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UserProfileEditScreen(
                                              userToken: userToken,
                                              staffProfile: snapshot.data,
                                            )));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.white,
                              boxShadow: StyleManager.shadow,
                            ),
                            child: RowUP().rowUPRow(
                              Icons.email_rounded,
                              snapshot.data!.content!.email.toString(),
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UserProfileEditScreen(
                                              userToken: userToken,
                                              staffProfile: snapshot.data,
                                            )));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.white,
                              boxShadow: StyleManager.shadow,
                            ),
                            child: RowUP().rowUPRow(
                              Icons.cake_rounded,
                              snapshot.data!.content!.birthday.toString(),
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UserProfileEditScreen(
                                              userToken: userToken,
                                              staffProfile: snapshot.data,
                                            )));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                    alignment: Alignment.center,
                    height: 500.0,
                    width: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: ColorManager.backGroundBlue,
                      //boxShadow: StyleManager.shadow,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.white,
                              boxShadow: StyleManager.shadow,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.white,
                              boxShadow: StyleManager.shadow,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.white,
                              boxShadow: StyleManager.shadow,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }))
      ],
    );
  }
}

// ignore: use_key_in_widget_constructors
class RowUP extends Row {
  Row rowUPRow(IconData icon, String content, VoidCallback press) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          width: 30,
          margin: const EdgeInsets.only(top: 0, left: 30),
          //color: Colors.blue,
          child: Icon(
            icon,
            size: 25,
          ),
        ),
        Container(
          width: 280,
          margin: const EdgeInsets.only(top: 0, left: 10),
          //color: Colors.red,
          child: Text(
            content,
            softWrap: true,
            style: const TextStyle(
              fontFamily: "QuicksandMedium",
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: 30,
          margin: const EdgeInsets.only(top: 0, left: 0),
          //color: Colors.red,
          child: IconButton(
            icon: const Icon(
              Icons.edit_rounded,
              size: 20,
            ),
            onPressed: press,
          ),
        ),
      ],
    );
  }
}
