// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_const

import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// ignore: must_be_immutable
class EditProfileForm extends StatefulWidget {
  String name = "";
  String dob = "";
  String phone = "";
  String email = "";

  EditProfileForm(
      {Key? key,
      required this.name,
      required this.dob,
      required this.phone,
      required this.email})
      : super(key: key);

  @override
  _EditProfile createState() =>
      // ignore: no_logic_in_create_state
      _EditProfile(name: name, dob: dob, phone: phone, email: email);
}

class _EditProfile extends State<EditProfileForm> {
  String name = "";
  String dob = "";
  String phone = "";
  String email = "";

  _EditProfile(
      {required this.name,
      required this.dob,
      required this.phone,
      required this.email});

  TextEditingController nameP = TextEditingController();
  TextEditingController emailP = TextEditingController();
  TextEditingController birthDay = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameP.text = name;
    emailP.text = email;
    birthDay.text = dob;

    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 50.0,
          width: 400,
          decoration: BoxDecoration(
              boxShadow: StyleManager.shadow,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ])),
          padding: const EdgeInsets.all(0),
          child: Text(
            phone,
            style: const TextStyle(
              fontFamily: "QuickSandBold",
              fontSize: 30,
              color: Color(0xFF00ADFF),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "NAME",
            style: TextStyle(
              fontFamily: "QuickSandBold",
              fontSize: 25,
              color: Color(0xFF000000),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: nameP,
            decoration: InputDecoration(
              //labelText: "Hostel name",
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              focusColor: Colors.white,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(
                  top: 25, left: 20, bottom: 25, right: 10),
            ),
            maxLength: 50,
            style: const TextStyle(
              fontFamily: "QuickSandMedium",
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "EMAIL",
            style: TextStyle(
                fontFamily: "QuickSandBold",
                fontSize: 25,
                color: Color(0xFF000000)),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: emailP,
            decoration: InputDecoration(
              //labelText: "Hostel address",
              filled: true,
              fillColor: Colors.white,
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              contentPadding: const EdgeInsets.only(
                  top: 25, left: 20, bottom: 25, right: 10),
            ),
            maxLength: 100,
            style: const TextStyle(
              fontFamily: "QuickSandMedium",
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          //color: Colors.blue,
          child: const Text(
            "BIRTH DAY",
            style: TextStyle(
                fontFamily: "QuickSandBold",
                fontSize: 25,
                color: Color(0xFF000000)),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: birthDay,
            decoration: InputDecoration(
              //labelText: "Room amount",
              filled: true,
              fillColor: Colors.white,
              border: myinputborder(),
              enabledBorder: myinputborder(),
              focusedBorder: myfocusborder(),
              contentPadding: const EdgeInsets.only(
                  top: 25, left: 20, bottom: 25, right: 10),
            ),
            style: const TextStyle(
              fontFamily: "QuickSandMedium",
              fontSize: 20,
            ),
            enabled: false,
          ),
        ),
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
        SizedBox(height: size.height * 0.05),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          child: RaisedButton(
            onPressed: () => {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
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
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(170, 0, 0, 0)
                  ])),
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
}
