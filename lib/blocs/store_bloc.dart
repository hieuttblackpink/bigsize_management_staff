import 'dart:convert';
import 'package:bigsize_management_staff/models/store/store.dart';
import 'package:bigsize_management_staff/services/exception.dart';
import 'package:http/http.dart' as http;

class StoreBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<Store?> getStore(String token, String id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "stores/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    switch (response.statusCode) {
      case 200:
        return Store.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return Store.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return Store.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return Store.fromJson(jsonDecode(response.body));
    }
  }
}
