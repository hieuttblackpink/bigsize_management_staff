// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  late String _token;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final Uri url =
        "https://identitytoolkit..com/v1/accounts:$urlSegment?key=AIzaSyB6RUmyB-ktH7JPXBKJFOfIb1l5bIbQbnM"
            as Uri;
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    print(responseData);
    _token = responseData['idToken'];
    print('************************' + _token.toString());
    try {
      if (urlSegment == "signUp") {
        sharedPreferences.setString("token", _token.toString());
      }
    } catch (e) {
      print(e);
    }
    print("true");
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> changePassword(String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString("token")!;
    final Uri url =
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyB6RUmyB-ktH7JPXBKJFOfIb1l5bIbQbnM"
            as Uri;
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
  }
}
