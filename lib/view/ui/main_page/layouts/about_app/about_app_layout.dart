import 'dart:collection';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

//var androidInfo1 = DeviceInfoPlugin().androidInfo;

class GetInfo {
  Future<HashMap<String, String>> getInfo() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    //print('Android $release (SDK $sdkInt), $manufacturer $model');
    HashMap<String, String> info = HashMap();
    Map<String, String> info1 = {
      'osVer': release.toString(),
      'sdkVer': sdkInt.toString(),
      'manuInfo': manufacturer.toString(),
      'modelInfo': model.toString()
    };
    info.addAll(info1);
    //print(info);
    return info;
  }
}

// ignore: must_be_immutable
class AppInfo extends StatelessWidget {
  // This widget is the root of your application.
  HashMap<String, String> info2 = HashMap();

  AppInfo({Key? key, required this.info2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    //print(info2);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Thông tin ứng dụng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
/*
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  //padding: EdgeInsets.all(20),
                  //color: Colors.blue,
                  height: 200,
                  child: Image.asset(
                    "assets/images/main.png",
                  ),
                ),
*/
            Container(
                alignment: Alignment.center,
                //margin: const EdgeInsets.only(left: 20, right: 20),
                //padding: EdgeInsets.all(20),
                //color: Colors.blue,
                child: const Text(
                  "BIGSIZE SHOP FOR STAFF",
                  style: TextStyle(
                    fontFamily: "QuicksandBold",
                    fontSize: 35,
                    color: Color(0xFF00ADFF),
                  ),
                )),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: const Color(0x1000ADFF),
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20),
                    width: 180,
                    //color: Colors.white,
                    child: const Text(
                      "PHIÊN BẢN ỨNG DỤNG",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "QuickSandMedium",
                        color: Color(0xFF0085C3),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 170,
                    //color: Colors.pinkAccent,
                    child: const Text(
                      "6.0.9",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "QuickSandBold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: const Color(0x1000ADFF),
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20),
                    width: 180,
                    //color: Colors.white,
                    child: const Text(
                      "HỆ ĐIỀU HÀNH",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "QuickSandMedium",
                        color: Color(0xFF0085C3),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 170,
                    //color: Colors.pinkAccent,
                    child: Text(
                      info2['osVer'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "QuickSandBold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: const Color(0x1000ADFF),
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20),
                    width: 180,
                    //color: Colors.white,
                    child: const Text(
                      "THIẾT BỊ",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "QuickSandMedium",
                        color: Color(0xFF0085C3),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 170,
                    //color: Colors.pinkAccent,
                    child: Text(
                      info2['manuInfo'].toString().toUpperCase() +
                          " " +
                          info2['modelInfo'].toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "QuickSandBold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
