import 'dart:convert';

import 'package:http/http.dart';

class DisplayRoom {
  String oid;

  DisplayRoom({this.oid});

  // ignore: missing_return
  Future<Response> getRoomData(String oid) async {
      print(oid);
      try {
        final response= await post(
            Uri.parse("http://localhost:3000/room"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'oid' : '$oid'})
        );
        return response;
      } catch(e) {
        print(e);
        return e;
      }
  }
}