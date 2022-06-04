import 'package:bigsize_management_staff/model/module/storage_item.dart';
import 'package:bigsize_management_staff/resources/form_error.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/routes_manger.dart';
import 'package:flutter/material.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final StorageService _storageService = StorageService();
  late StorageItem _storageItem;

  final _formKey = GlobalKey<FormState>();
  String? email;
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
          buildEmailFormField(),
          const SizedBox(height: 20),
          buildPasswordFormField(),
          const SizedBox(height: 20),
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
              const Text("Remember me"),
              const Spacer(),
              /*
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              */
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
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
                  _storageService.deleteAllSecureData();
                  _storageItem =
                      StorageItem(email.toString(), password.toString());
                  _storageService.writeSecureData(_storageItem);
                  _formKey.currentState!.save();
                  Navigator.pushNamed(context, Routes.homeRoute);
                } else {
                  _formKey.currentState!.save();
                  Navigator.pushNamed(context, Routes.homeRoute);
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
          removeError(error: "Password khong duoc trong");
        } else if (value.length >= 8) {
          removeError(error: "Password qua ngan");
        }
        //return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Password khong duoc trong");
          return "";
        } else if (value.length < 8) {
          addError(error: "Password qua ngan");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Email khong de trong");
        } /*else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }*/
        //return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Email khong de trong");
          return "";
        } /*else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }*/
        return null;
      },
      style: const TextStyle(
        fontSize: 20,
        fontFamily: "QuicksandMedium",
      ),
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(
          fontFamily: "QuicksandMedium",
          fontSize: 20,
        ),
        hintText: "Nhập email của bạn",
        hintStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(50, 0, 0, 0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
        suffixIcon: const Icon(Icons.mail),
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
      ),
    );
  }
}
