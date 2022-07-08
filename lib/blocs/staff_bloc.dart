// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bigsize_management_staff/models/user/user.dart';
import 'package:bigsize_management_staff/models/user/user_password.dart';
import 'package:bigsize_management_staff/models/user/user_profile.dart';
import 'package:bigsize_management_staff/models/user/user_work.dart';
import 'package:bigsize_management_staff/models/user/user_work_order.dart';
import 'package:http/http.dart' as http;

class StaffBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<StaffLogin> getLogin(String uid, String password) async {
    //print(uid + " - " + password);
    final response = await http.post(
      Uri.parse(_baseUrl + "accounts/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': uid, 'password': password}),
    );
    //print("SB_GetLogin: " + response.body.toString());
    return StaffLogin.fromJson(jsonDecode(response.body));
  }

  Future<StaffProfile> getProfile(String token) async {
    //print("Token get:" + token);
    final response = await http.get(
      Uri.parse(_baseUrl + "staffs/get-own-profile"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    //print("SB_GetProfile: " + response.body.toString());
    return StaffProfile.fromJson(jsonDecode(response.body));
  }

  Future<bool> updateProfile(String token, StaffProfile profile) async {
    final response = await http.put(
      Uri.parse(_baseUrl + "staffs/update-profile"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        'fullname': profile.content!.fullname.toString(),
        'email': profile.content!.email.toString(),
        'birthday': profile.content!.birthday.toString(),
        'phone_number': profile.content!.phoneNumber.toString()
      }),
    );
    //print("SB_UpdateProfile: " + response.body.toString());
    return StaffProfile.fromJson(jsonDecode(response.body)).isSuccess as bool;
  }

  Future<UserPassword> changePassword(
      String token, String oP, String nP, String cP) async {
    final response = await http.put(
      Uri.parse(_baseUrl + "accounts/change-password"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        'old_password': oP,
        'new_password': nP,
        'confirm_new_password': cP
      }),
    );
    print("SB_CP: " + response.body.toString());
    return UserPassword.fromJson(jsonDecode(response.body));
  }

  Future<StaffWorking> getStaffWork(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "orders/staff-performance"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    //print("SB_SW: " + response.body.toString());
    return StaffWorking.fromJson(jsonDecode(response.body));
  }

  Future<StaffWorkingOrder> getStaffWorkOrder(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "orders/staff-performance-order"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    //print("SB_SW: " + response.body.toString());
    return StaffWorkingOrder.fromJson(jsonDecode(response.body));
  }
}
