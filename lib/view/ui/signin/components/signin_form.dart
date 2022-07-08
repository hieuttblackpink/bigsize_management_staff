// ignore_for_file: avoid_print

import 'package:bigsize_management_staff/blocs/staff_bloc.dart';
import 'package:bigsize_management_staff/model/module/storage_item.dart';
import 'package:bigsize_management_staff/models/user/user.dart';
import 'package:bigsize_management_staff/resources/form_error.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/routes_manger.dart';
import 'package:bigsize_management_staff/view/ui/forgot_password/forgot_password.dart';
import 'package:bigsize_management_staff/view/ui/main_page/main_screen.dart';
import 'package:flutter/material.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final StorageService _storageService = StorageService();
  final StaffBloc _staffBloc = StaffBloc();
  late StaffLogin _staffLogin;
  late StorageItem _storageItemUser;
  late StorageItem _storageItemToken;
  bool loginSuccess = false;

  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildusernameFormField(),
          const SizedBox(height: 30),
          buildPasswordFormField(),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Nhớ đăng nhập"),
              const Spacer(),
              GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPassword()))
                },
                child: const Text(
                  "Quên mật khẩu",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "QuicksandMedium"),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(color: Colors.black)))),
            child: Container(
              width: 350,
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
                "Đăng nhập",
                style: TextStyle(
                  fontFamily: "QuickSandBold",
                  fontSize: 30,
                ),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (remember == true) {
                  _staffLogin = await _staffBloc.getLogin(
                      username.toString(), password.toString());
                  print(_staffLogin.isSuccess.toString());
                  loginSuccess = _staffLogin.isSuccess!;
                  print("Login Success: " + loginSuccess.toString());
                  if (loginSuccess) {
                    print("Token: " + _staffLogin.content!.token.toString());
                    _storageItemUser =
                        StorageItem("Username", username.toString());
                    _storageItemToken = StorageItem(
                        "UserToken", _staffLogin.content!.token.toString());
                    _storageService.writeSecureData(_storageItemUser);
                    _storageService.writeSecureData(_storageItemToken);
                    _formKey.currentState!.save();
                    removeError(
                        error: "Sai thông tin tài khoản hoặc mật khẩu.");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => MainView()),
                        ((route) => false));
                  } else {
                    addError(error: "" + _staffLogin.error!.message.toString());
                  }
                } else {
                  _staffLogin = await _staffBloc.getLogin(
                      username.toString(), password.toString());
                  loginSuccess = _staffLogin.isSuccess!;
                  if (loginSuccess) {
                    _storageItemToken = StorageItem(
                        "UserToken", _staffLogin.content!.token.toString());
                    _storageService.writeSecureData(_storageItemToken);
                    _formKey.currentState!.save();
                    removeError(
                        error: "Sai thông tin tài khoản hoặc mật khẩu.");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => MainView()),
                        ((route) => false));
                  } else {
                    addError(error: "" + _staffLogin.error!.message.toString());
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Mật khẩu không được để trống");
        } else if (value.length >= 8) {
          removeError(error: "Mật khẩu quá ngắn (trên 8 ký tự)");
        }
        password = value;
        //return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Mật khẩu không được để trống");
          return "";
        } else if (value.length < 8) {
          addError(error: "Mật khẩu quá ngắn (trên 8 ký tự)");
          return "";
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 20,
        fontFamily: "QuicksandMedium",
      ),
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        labelStyle: const TextStyle(
          fontFamily: "QuicksandMedium",
          fontSize: 20,
        ),
        hintText: "Nhập mật khẩu của bạn",
        hintStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(50, 0, 0, 0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
        suffixIcon: const Icon(Icons.lock),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
      ),
    );
  }

  TextFormField buildusernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Tên tài khoản không được để trống");
        } /*else if (usernameValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidusernameError);
        }*/
        username = value;
        //return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Tên tài khoản không được để trống");
          return "";
        } /*else if (!usernameValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidusernameError);
          return "";
        }*/
        return null;
      },
      style: const TextStyle(
        fontSize: 20,
        fontFamily: "QuicksandMedium",
      ),
      decoration: InputDecoration(
        labelText: "Tài khoản",
        labelStyle: const TextStyle(
          fontFamily: "QuicksandMedium",
          fontSize: 20,
        ),
        hintText: "Nhập tài khoản của bạn",
        hintStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(50, 0, 0, 0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
        suffixIcon: const Icon(Icons.account_circle_sharp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
