// ignore_for_file: avoid_print

import 'package:bigsize_management_staff/services/auth.dart';
import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    Key? key,
  }) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _passController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  Future<void> _submit(String newPassword) async {
    await AuthServices().changePassword(newPassword);
  }

  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Create New Password?',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Your new password must be different ',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const Text('from previous used password',
                  style: TextStyle(fontSize: 17)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: Colors.white24)),
                      labelText: 'New Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _passController.text = value;
                      });
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: Colors.white24)),
                      labelText: 'Confirm New Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _confirmPassController.text = value;
                      });
                    },
                    // ignore: missing_return
                  )),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 40,
                width: 285,
                child: _isloading
                    ? const CircularProgressIndicator()
                    : MaterialButton(
                        child: const Text('Reset Password'),
                        onPressed: () {
                          setState(() {
                            _isloading = true;
                          });
                          _passController.text == _confirmPassController.text
                              ? _submit(_passController.text)
                              : print("failed");
                          setState(() {
                            _isloading = false;
                          });
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        color: Colors.indigo.shade600,
                        textColor:
                            Theme.of(context).primaryTextTheme.button?.color,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
