import 'dart:convert';

import 'package:bigsize_management_staff/models/product/product.dart';
import 'package:bigsize_management_staff/models/product/product_colour.dart';
import 'package:bigsize_management_staff/models/product/product_detail.dart';
import 'package:bigsize_management_staff/models/product/product_detail_specific.dart';
import 'package:bigsize_management_staff/models/product/product_quantity_store.dart';
import 'package:bigsize_management_staff/models/product/product_search.dart';
import 'package:bigsize_management_staff/models/product/product_size.dart';
import 'package:http/http.dart' as http;

class ProductBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<ProductList> getListProduct(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl +
          "products?PageNumber=1&PageSize=10&Status=true"), //products/store?PageNumber=1&PageSize=10
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
        //'Authorization': "Bearer $token",
      },
    );
    return ProductList.fromJson(jsonDecode(response.body));
  }

  Future<ProductDetail> getProductDetail(String token, int id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "products/$id"), //"products/store/$id"
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
        //'Authorization': "Bearer $token",
      },
    );
    return ProductDetail.fromJson(jsonDecode(response.body));
  }

  Future<ProductSearch> searchProductByName(String searchKey) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "products?ProductName=$searchKey&Status=true"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
        //'Authorization': "Bearer $token",
      },
    );
    return ProductSearch.fromJson(jsonDecode(response.body));
  }

  Future<ProductColour> getProductColour(String token, int id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "products/colours/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return ProductColour.fromJson(jsonDecode(response.body));
  }

  Future<ProductSize> getProductSize(String token, int idP, int idC) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "products/sizes/$idP/$idC"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return ProductSize.fromJson(jsonDecode(response.body));
  }

  Future<ProductQuantityStore> getProductQuantityStore(
      String token, int idP, int idC, int idS) async {
    final response = await http.get(
      Uri.parse(_baseUrl +
          "products/quantity-of-store?ProductId=$idP&ColourId=$idC&SizeId=$idS"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );
    return ProductQuantityStore.fromJson(jsonDecode(response.body));
  }

  Future<ProductDetailSpecific> getProductSpecificDetail(
      String token, int id, int detailID) async {
    final response = await http.get(
      Uri.parse(
          _baseUrl + "products/detail/$id/$detailID"), //"products/store/$id"
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': "Bearer $token",
      },
    );
    return ProductDetailSpecific.fromJson(jsonDecode(response.body));
  }
}
