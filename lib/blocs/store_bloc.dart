import 'dart:convert';
import 'package:bigsize_management_staff/models/store/store.dart';
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
    return Store.fromJson(jsonDecode(response.body));
  }
}
