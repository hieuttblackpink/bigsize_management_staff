import 'dart:convert';
import 'dart:io';

import 'package:bigsize_management_staff/models/avatar/avatar.dart';
import 'package:bigsize_management_staff/services/exception.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AvatarBloc {
  final String _baseUrl = "https://20.211.17.194/api/v1/";

  Future<Avatar> getAvatar(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl + "staffs/get-avatar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );

    switch (response.statusCode) {
      case 200:
        return Avatar.fromJson(jsonDecode(response.body));
      case 400:
        BadRequestException(response.body.toString());
        return Avatar.fromJson(jsonDecode(response.body));
      case 401:

      case 403:
        UnauthorisedException(response.body.toString());
        return Avatar.fromJson(jsonDecode(response.body));
      case 500:

      default:
        FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return Avatar.fromJson(jsonDecode(response.body));
    }
  }

  Future<Avatar> uploadAvatar(String token, File image) async {
    var request = http.MultipartRequest(
        "PUT", Uri.parse(_baseUrl + "staffs/upload-avatar"));

    //request.fields['title'] = "dummyImage";
    request.headers['Authorization'] = "Bearer $token";

    File file = File(image.path);
    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: "@" + file.path.split('/').last));

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    Avatar avatar = Avatar.fromJson(jsonDecode(result));
    print("Upload avatar api: " + result);
    //print("Upload avatar api 2: " + avatar.toString());
    return avatar;
  }
}
