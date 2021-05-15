import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class FeedBack {
  String rno;
  String message;

  FeedBack({this.rno, this.message});

  Future<Response> postMessage({
    @required String rno,
    @required String message
  }) async {
    try {
      final response = await post(Uri.parse("http://localhost:3000/feedback"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'rno': '$rno', 'message': '$message'})
      );
      print("data posted");
      return response;
    } catch (e) {
      return e;
    }
  }
}
