// ignore_for_file: avoid_print

import 'package:bigsize_management_staff/blocs/staff_bloc.dart';
import 'package:bigsize_management_staff/models/user_password.dart';
import 'package:bigsize_management_staff/resources/form_error.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/change_password/change_success.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //double hNotice = 70;
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final StorageService _storageService = StorageService();
  final StaffBloc _staffBloc = StaffBloc();
  late UserPassword _userPassword;
  late String? userToken;
  bool isChange = false;

  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void removeAllError() {
    setState(() {
      errors.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doi mat khau"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                onTap: () {
                  removeAllError();
                },
                controller: oldPass,
                obscureText: true,
                decoration: InputDecoration(
                  label: const Text("Mat khau cu"),
                  border: myinputborder(),
                  enabledBorder: myinputborder(),
                  focusedBorder: myfocusborder(),
                  suffixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0085C3),
                    size: 30,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: "QuickSandMedium",
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                onTap: () {
                  removeAllError();
                },
                controller: newPass,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mat khau moi",
                  border: myinputborder(),
                  enabledBorder: myinputborder(),
                  focusedBorder: myfocusborder(),
                  suffixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0085C3),
                    size: 30,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: "QuickSandMedium",
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                onTap: () {
                  removeAllError();
                },
                controller: confirmPass,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Xac nhan mat khau",
                  border: myinputborder(),
                  enabledBorder: myinputborder(),
                  focusedBorder: myfocusborder(),
                  suffixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0085C3),
                    size: 30,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: "QuickSandMedium",
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            FormError(errors: errors),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: RaisedButton(
                onPressed: () async {
                  if (newPass.text.length < 8) {
                    addError(error: "Mat khau moi qua ngan");
                  } else {
                    removeError(error: "Mat khau moi qua ngan");
                    userToken =
                        await _storageService.readSecureData("UserToken");
                    _userPassword = await _staffBloc.changePassword(
                        userToken.toString(),
                        oldPass.text,
                        newPass.text,
                        confirmPass.text);
                    print(_userPassword.isSuccess.toString());
                    if (_userPassword.isSuccess == null) {
                      addError(
                          error: _userPassword.errors!.confirmNewPassword!.first
                                  .substring(0, 12) +
                              "\n" +
                              _userPassword.errors!.confirmNewPassword!.first
                                  .substring(
                                      13,
                                      _userPassword.errors!.confirmNewPassword!
                                          .first.length));
                    } else if (!_userPassword.isSuccess!) {
                      addError(error: "Sai mật khẩu");
                    } else {
                      removeError(error: "Sai mật khẩu");
                      removeError(
                          error:
                              "New password and confirmation new password do not match.");
                      print("Doi mat khau thanh cong");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ChangePasswordSuccess()));
                      //Navigator.pop(context);
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: Colors.black),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "XAC NHAN",
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
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Color(0xFF00ADFF),
          width: 2,
        ));
  }
}
