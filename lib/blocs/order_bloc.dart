import 'dart:convert';

import 'package:bigsize_management_staff/models/customer.dart';
import 'package:bigsize_management_staff/models/order_detail.dart';
import 'package:bigsize_management_staff/models/order_list.dart';
import 'package:http/http.dart' as http;

class OrderBloc {
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

  Future<OrderList> getListOrder(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl +
          "orders-s/for-staff?OrderType=false&OrderByCreateDate=true&PageNumber=1&PageSize=10"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return OrderList.fromJson(jsonDecode(response.body));
  }

  Future<OrderDetailBloc> getOrder(String token, String id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "orders-s/detail/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return OrderDetailBloc.fromJson(jsonDecode(response.body));
  }
}
