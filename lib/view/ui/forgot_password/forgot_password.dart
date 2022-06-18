import 'package:bigsize_management_staff/view/ui/forgot_password/update_password.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

enum AuthMode { forgot, verify }

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool submitValid = false;
  AuthMode _authMode = AuthMode.forgot;
  final TextEditingController _otpController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool verify() {
    return EmailAuth.validate(
        receiverMail: _emailController.value.text,
        userOTP: _otpController.value.text);
  }

  void sendOtp() async {
    //print("Email" + _emailController.value.text);
    EmailAuth.sessionName = "BS";
    bool result =
        await EmailAuth.sendOtp(receiverMail: _emailController.value.text);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.forgot) {
      setState(() {
        _authMode = AuthMode.verify;
      });
    } else {
      setState(() {
        _authMode = AuthMode.forgot;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _authMode == AuthMode.forgot
                    ? 'Ban quen mat khau?'
                    : 'Xac thuc email cua ban',
                style: const TextStyle(
                  fontFamily: "QuicksandBold",
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                _authMode == AuthMode.forgot
                    ? 'Nhap email da lien ket voi'
                    : 'Nhap ma OTP duoc gui den',
                style: const TextStyle(
                    fontSize: 17, fontFamily: "QuicksandMedium"),
              ),
            ),
            Text(
                _authMode == AuthMode.forgot
                    ? 'tai khoan nhan vien cua ban'
                    : _emailController.text,
                style: const TextStyle(
                    fontSize: 17, fontFamily: "QuicksandMedium")),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: _authMode == AuthMode.forgot
                  ? TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(color: Colors.white24)),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      controller: _emailController,
                      // ignore: missing_return
                    )
                  : (submitValid)
                      ? TextFormField(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                borderSide: BorderSide(color: Colors.white24)),
                            labelText: 'Ma OTP',
                            labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          controller: _otpController,
                        )
                      : Container(),
            ),
            SizedBox(
              height: _authMode == AuthMode.forgot ? 50 : 30,
            ),
            if (_authMode == AuthMode.verify)
              MaterialButton(
                  onPressed: sendOtp,
                  child: const Text(
                    'Gui lai ma OTP',
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 1,
                      shadows: [
                        Shadow(color: Colors.indigo, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.indigo,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  )),
            SizedBox(
              height: 50,
              width: 200,
              child: MaterialButton(
                child: Text(
                  _authMode == AuthMode.forgot ? 'Xac thuc email' : 'Xac nhan',
                  style: const TextStyle(
                      fontFamily: "QuicksandBold", fontSize: 20),
                ),
                onPressed: () {
                  if (_authMode == AuthMode.forgot) {
                    sendOtp();
                    _switchAuthMode();
                    submitValid = true;
                  } else {
                    verify();
                    _otpController.clear();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UpdatePassword()));
                    //getCurrentUser();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                color: Colors.black,
                textColor: Theme.of(context).primaryTextTheme.button?.color,
              ),
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
