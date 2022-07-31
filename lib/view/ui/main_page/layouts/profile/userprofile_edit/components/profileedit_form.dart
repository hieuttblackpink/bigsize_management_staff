// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_const

import 'package:bigsize_management_staff/blocs/staff_bloc.dart';
import 'package:bigsize_management_staff/models/user/user_profile.dart';
import 'package:bigsize_management_staff/resources/form_error.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/profile/userprofile/userprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class EditProfileForm extends StatefulWidget {
  final String userToken;
  String name = "";
  String dob = "";
  String phone = "";
  String email = "";

  EditProfileForm(
      {Key? key,
      required this.name,
      required this.dob,
      required this.phone,
      required this.email,
      required this.userToken})
      : super(key: key);

  @override
  _EditProfile createState() =>
      // ignore: no_logic_in_create_state
      _EditProfile(
          userToken: userToken,
          name: name,
          dob: dob,
          phone: phone,
          email: email);
}

class _EditProfile extends State<EditProfileForm> {
  final StaffBloc _staffBloc = StaffBloc();
  final String userToken;
  String name = "";
  String dob = "";
  String phone = "";
  String email = "";

  bool hasError = false;
  bool isUpdatting = false;

  final List<String?> errors = [];

  _EditProfile(
      {required this.userToken,
      required this.name,
      required this.dob,
      required this.phone,
      required this.email});

  TextEditingController nameP = TextEditingController();
  TextEditingController emailP = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController phoneP = TextEditingController();

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameP.text = name;
    emailP.text = email;
    birthDay.text = dob;
    phoneP.text = phone;

    Size size = MediaQuery.of(context).size;

    nameP.selection =
        TextSelection.fromPosition(TextPosition(offset: nameP.text.length));
    emailP.selection =
        TextSelection.fromPosition(TextPosition(offset: emailP.text.length));
    phoneP.selection =
        TextSelection.fromPosition(TextPosition(offset: phoneP.text.length));

    return Column(
      children: <Widget>[
        SizedBox(height: size.height * 0.001),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "Họ và tên",
            style: TextStyle(
              fontFamily: "QuicksandBold",
              fontSize: 20,
              color: Color(0xFF000000),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          height: 80,
          child: TextField(
            controller: nameP,
            onTap: () {
              removeAllError();
            },
            onChanged: (value) async {
              nameP.text = value;
              setState(() {
                nameP.selection = TextSelection.fromPosition(
                    TextPosition(offset: nameP.text.length));
                name = nameP.text;
              });
            },
            onSubmitted: (value) async {
              nameP.text = value;
              setState(() {
                nameP.selection = TextSelection.fromPosition(
                    TextPosition(offset: nameP.text.length));
                name = nameP.text;
              });
            },
            decoration: InputDecoration(
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              focusColor: Colors.white,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.only(top: 0, left: 20, bottom: 0, right: 10),
            ),
            maxLength: 50,
            style: const TextStyle(
              fontFamily: "QuicksandMedium",
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.002),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "EMAIL",
            style: TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: 20,
                color: Color(0xFF000000)),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          height: 80,
          child: TextField(
            controller: emailP,
            onTap: () {
              removeAllError();
            },
            onChanged: (value) async {
              emailP.text = value;
              setState(() {
                emailP.selection = TextSelection.fromPosition(
                    TextPosition(offset: emailP.text.length));
                email = emailP.text;
              });
            },
            onSubmitted: (value) async {
              emailP.text = value;
              setState(() {
                emailP.selection = TextSelection.fromPosition(
                    TextPosition(offset: emailP.text.length));
                email = emailP.text;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              errorBorder: myErrorborder(),
              contentPadding:
                  const EdgeInsets.only(top: 0, left: 20, bottom: 0, right: 10),
            ),
            maxLength: 100,
            style: const TextStyle(
              fontFamily: "QuickSandMedium",
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.002),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "SĐT",
            style: TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: 20,
                color: Color(0xFF000000)),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          height: 80,
          child: TextField(
            controller: phoneP,
            onTap: () {
              removeAllError();
            },
            onChanged: (value) async {
              phoneP.text = value;
              setState(() {
                phoneP.selection = TextSelection.fromPosition(
                    TextPosition(offset: phoneP.text.length));
                phone = phoneP.text;
              });
            },
            onSubmitted: (value) async {
              phoneP.text = value;
              setState(() {
                phoneP.selection = TextSelection.fromPosition(
                    TextPosition(offset: phoneP.text.length));
                phone = phoneP.text;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              contentPadding:
                  const EdgeInsets.only(top: 0, left: 20, bottom: 0, right: 10),
            ),
            maxLength: 10,
            style: const TextStyle(
              fontFamily: "QuickSandMedium",
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.002),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "Sinh nhật",
            style: TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: 20,
                color: Color(0xFF000000)),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          height: 80,
          child: TextField(
            controller: birthDay,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              contentPadding:
                  const EdgeInsets.only(top: 0, left: 20, bottom: 0, right: 10),
            ),
            style: const TextStyle(
              fontFamily: "QuicksandMedium",
              fontSize: 20,
            ),
            //enabled: false,
            readOnly: true,
            focusNode: FocusNode(),
            enableInteractiveSelection: false,
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1950, 1, 1),
                maxTime: DateTime(2022, 12, 31),
                theme: const DatePickerTheme(
                  headerColor: Color(0x1000ADFF),
                  backgroundColor: Color(0xFFFFFFFF),
                  itemStyle: TextStyle(
                    color: Color(0xFF00ADFF),
                    fontFamily: "QuickSandBold",
                    fontSize: 20,
                  ),
                  doneStyle: TextStyle(
                    color: Color(0xFF0085C3),
                    fontSize: 20,
                    fontFamily: "QuickSandBold",
                  ),
                  cancelStyle: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 20,
                    fontFamily: "QuickSandBold",
                  ),
                ),
                onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                },
                onConfirm: (date) {
                  print('confirm $date');
                  String bd = "";
                  if ((date.day >= 10) && (date.month >= 10)) {
                    bd = date.day.toString() +
                        "/" +
                        date.month.toString() +
                        "/" +
                        date.year.toString();
                  }
                  if ((date.day < 10) && (date.month >= 10)) {
                    bd = "0" +
                        date.day.toString() +
                        "/" +
                        date.month.toString() +
                        "/" +
                        date.year.toString();
                  }
                  if ((date.day >= 10) && (date.month < 10)) {
                    bd = date.day.toString() +
                        "/0" +
                        date.month.toString() +
                        "/" +
                        date.year.toString();
                  }
                  if ((date.day < 10) && (date.month < 10)) {
                    bd = "0" +
                        date.day.toString() +
                        "/0" +
                        date.month.toString() +
                        "/" +
                        date.year.toString();
                  }
                  print(bd);
                  birthDay.text = bd;
                },
                currentTime: DateTime.now(),
                locale: LocaleType.vi,
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
          child: FormError(errors: errors),
        ),
        /*
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 20),
          child: TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(1950, 1, 1),
                  maxTime: DateTime(2022, 12, 31),
                  theme: const DatePickerTheme(
                    headerColor: Color(0x1000ADFF),
                    backgroundColor: Color(0xFFFFFFFF),
                    itemStyle: TextStyle(
                      color: Color(0xFF00ADFF),
                      fontFamily: "QuickSandBold",
                      fontSize: 20,
                    ),
                    doneStyle: TextStyle(
                      color: Color(0xFF0085C3),
                      fontSize: 20,
                      fontFamily: "QuickSandBold",
                    ),
                    cancelStyle: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 20,
                      fontFamily: "QuickSandBold",
                    ),
                  ),
                  onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  },
                  onConfirm: (date) {
                    print('confirm $date');
                    String bd = "";
                    if ((date.day >= 10) && (date.month >= 10)) {
                      bd = date.day.toString() +
                          "/" +
                          date.month.toString() +
                          "/" +
                          date.year.toString();
                    }
                    if ((date.day < 10) && (date.month >= 10)) {
                      bd = "0" +
                          date.day.toString() +
                          "/" +
                          date.month.toString() +
                          "/" +
                          date.year.toString();
                    }
                    if ((date.day >= 10) && (date.month < 10)) {
                      bd = date.day.toString() +
                          "/0" +
                          date.month.toString() +
                          "/" +
                          date.year.toString();
                    }
                    if ((date.day < 10) && (date.month < 10)) {
                      bd = "0" +
                          date.day.toString() +
                          "/0" +
                          date.month.toString() +
                          "/" +
                          date.year.toString();
                    }
                    print(bd);
                    birthDay.text = bd;
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.vi,
                );
              },
              child: const Text(
                'Chon ngay',
                style: TextStyle(
                  color: Color(0xFF00ADFF),
                  fontFamily: "QuickSandBold",
                  fontSize: 25,
                ),
              )),
        ),
        */
        SizedBox(height: size.height * 0.05),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          child: RaisedButton(
            onPressed: () async {
              /*
              setState(() {
                isUpdatting = true;
              });
              */
              if (nameP.text.isEmpty) {
                addError(error: "Họ và tên không được bỏ trống!");
                hasError = true;

                //return;
              } else if (phoneP.text.isEmpty) {
                addError(error: "SĐT không được bỏ trống!");
                hasError = true;
                //return;
              } else if (emailP.text.isEmpty) {
                addError(error: "Email không được bỏ trống!");
                hasError = true;
                //return;
              } else if (phoneP.text.isNotEmpty && phoneP.text.length < 10) {
                addError(error: "SĐT phải có 10 ký tự!");
                hasError = true;
              } else {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(emailP.text.toString());

                if (emailP.text.isNotEmpty && !emailValid) {
                  addError(error: "Email không hợp lệ!");
                  hasError = true;
                } else {
                  hasError = false;
                }
              }

              if (hasError == false) {
                removeAllError();

                ContentStaffProfile content = ContentStaffProfile(
                    uid: 1,
                    fullname: nameP.text,
                    phoneNumber: phoneP.text,
                    email: emailP.text,
                    birthday: birthDay.text,
                    storeId: 1,
                    role: "Staff");
                StaffProfile profileUpdate = StaffProfile(content: content);
                bool isUpdate =
                    await _staffBloc.updateProfile(userToken, profileUpdate);
                if (isUpdate) {
                  var nav = Navigator.of(context);
                  nav.pop();
                  nav.pop();

                  Fluttertoast.showToast(
                      msg: "Cập nhật thông tin thành công", // message
                      toastLength: Toast.LENGTH_SHORT, // length
                      gravity: ToastGravity.BOTTOM, // location
                      timeInSecForIosWeb: 1 // duration
                      );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const UserProfileScreen()));
                } else {
                  showAlertDialog(context,
                      "Có lỗi xảy ra khi cập nhật thông tin.\nVui lòng thử lại sau.");
                }
              } else {
                return;
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            textColor: Colors.white,
            padding: const EdgeInsets.all(0),
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 0, 150, 255),
                    Color.fromARGB(150, 0, 170, 255)
                  ])),
              padding: const EdgeInsets.all(0),
              child: !isUpdatting
                  ? const Text(
                      "XÁC NHẬN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "QuickSandBold",
                        fontSize: 30,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "ĐANG CẬP NHẬT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "QuickSandBold",
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),
      ],
    );
  }

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
        borderRadius: const BorderRadius.all(const Radius.circular(10)),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(const Radius.circular(10)),
        borderSide: const BorderSide(
          color: Color(0xFF00ADFF),
          width: 2,
        ));
  }

  OutlineInputBorder myErrorborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(const Radius.circular(10)),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ));
  }

  showAlertDialog(context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Thông báo"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoading(context) {
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text(
                    "Đang xử lí...",
                    style: TextStyle(fontFamily: "QuicksandMedium"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
