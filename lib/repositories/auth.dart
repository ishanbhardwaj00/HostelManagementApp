import 'dart:convert';

import 'package:http/http.dart';

class SignIn {
  final String id; 
  final String password;
  SignIn({this.id, this.password});
  
  Future<Response> postData(String id, String password) async {
    var response = await post(
        Uri.parse("http://localhost:3000/auth"),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': '$id', 'password': '$password'}),
    );
    return response;
  }

}