import 'dart:convert';

import 'package:bigsize_management_staff/models/notification/notification.dart';
import 'package:http/http.dart' as http;

class NotificationBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<NotificationModel> getNotification(String token, int page) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "notifications?PageNumber=$page&PageSize=10"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return NotificationModel.fromJson(jsonDecode(response.body));
  }
}
