import 'dart:convert';

import 'package:bigsize_management_staff/models/customer/customer.dart';
import 'package:bigsize_management_staff/models/customer/new_customer.dart';
import 'package:http/http.dart' as http;

class CustomerBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<Customer> getCustomer(String cusPhone) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "customers/$cusPhone"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return Customer.fromJson(jsonDecode(response.body));
  }

  Future<Customer> createCustomer(String token, NewCustomer newCustomer) async {
    final response = await http.post(
      Uri.parse(_baseUrl + "customers/add-new-customer"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(newCustomer.toJson()),
    );
    return Customer.fromJson(jsonDecode(response.body));
  }
}
