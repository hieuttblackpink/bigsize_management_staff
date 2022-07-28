import 'dart:convert';

import 'package:bigsize_management_staff/models/customer/customer.dart';
import 'package:bigsize_management_staff/models/order/new_order.dart';
import 'package:bigsize_management_staff/models/order/order_detail.dart';
import 'package:bigsize_management_staff/models/order/order_exported.dart';
import 'package:bigsize_management_staff/models/order/order_list.dart';
import 'package:bigsize_management_staff/models/order/order_packaged.dart';
import 'package:bigsize_management_staff/models/order/order_return.dart';
import 'package:bigsize_management_staff/services/exception.dart';
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
    switch (response.statusCode) {
      case 200:
        return Customer.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return Customer.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return Customer.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return Customer.fromJson(jsonDecode(response.body));
    }
  }

  Future<OrderList?> getListOrder(String token, String date) async {
    final response = await http.get(
      Uri.parse(_baseUrl +
          "orders/for-staff?CreateDate=$date"), //"orders/for-staff?OrderType=false&OrderByCreateDate=true&PageNumber=1&PageSize=10"
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    try {
      switch (response.statusCode) {
        case 200:
          return OrderList.fromJson(jsonDecode(response.body));
        case 400:
          BadRequestException(response.body.toString());
          return OrderList.fromJson(jsonDecode(response.body));
        case 401:

        case 403:
          UnauthorisedException(response.body.toString());
          return OrderList.fromJson(jsonDecode(response.body));
        case 500:

        default:
          FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
          return OrderList.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
  }

  Future<OrderDetailModel> getOrder(String token, String id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "orders/detail/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    switch (response.statusCode) {
      case 200:
        return OrderDetailModel.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return OrderDetailModel.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return OrderDetailModel.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return OrderDetailModel.fromJson(jsonDecode(response.body));
    }
  }

  Future<NewOrderReturn> createOrder(String token, NewOrder newOrder) async {
    final response = await http.post(
      Uri.parse(_baseUrl + "orders/create-order-for-customer"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(newOrder.toJson()),
    );
    switch (response.statusCode) {
      case 200:
        return NewOrderReturn.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return NewOrderReturn.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return NewOrderReturn.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return NewOrderReturn.fromJson(jsonDecode(response.body));
    }
  }

  Future<OrderList?> getListOrderAssign(String token, String date) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "orders/assigned-order?CreateDate=$date"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    try {
      switch (response.statusCode) {
        case 200:
          return OrderList.fromJson(jsonDecode(response.body));
        case 400:
          BadRequestException(response.body.toString());
          return OrderList.fromJson(jsonDecode(response.body));
        case 401:

        case 403:
          UnauthorisedException(response.body.toString());
          return OrderList.fromJson(jsonDecode(response.body));
        case 500:

        default:
          FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
          return OrderList.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
  }

  Future<OrderPackaged> updateOrderToPackaged(String token, int id) async {
    final response = await http.put(
      Uri.parse(_baseUrl + "orders/packaged/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    switch (response.statusCode) {
      case 200:
        return OrderPackaged.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return OrderPackaged.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return OrderPackaged.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return OrderPackaged.fromJson(jsonDecode(response.body));
    }
  }

  Future<OrderExported> updateOrderToExported(String token, int id) async {
    final response = await http.put(
      Uri.parse(_baseUrl + "orders/delivery/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    switch (response.statusCode) {
      case 200:
        return OrderExported.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return OrderExported.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return OrderExported.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return OrderExported.fromJson(jsonDecode(response.body));
    }
  }
}
