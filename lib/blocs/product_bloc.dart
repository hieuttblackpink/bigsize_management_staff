import 'dart:convert';

import 'package:bigsize_management_staff/models/product.dart';
import 'package:bigsize_management_staff/models/product_detail.dart';
import 'package:http/http.dart' as http;

class ProductBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<ProductList> getListProduct(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "products/store?PageNumber=1&PageSize=10"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return ProductList.fromJson(jsonDecode(response.body));
  }

  Future<ProductDetail> getProductDetail(String token, int id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "products/store/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return ProductDetail.fromJson(jsonDecode(response.body));
  }
}
