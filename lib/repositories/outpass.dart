import 'dart:convert';

import 'package:http/http.dart';

class Outpass {
  final String id;
  final String firstName;
  final String lastName;
  final String reason;
  final String toTime;
  final String fromTime;
  final String leaveAddress;
  final String phoneNo;
  final String transportType;

  Outpass(
      {this.firstName,
      this.id,
      this.lastName,
      this.reason,
      this.toTime,
      this.fromTime,
      this.leaveAddress,
      this.phoneNo,
      this.transportType});

  Future<Response> postOutpassData(
      {String firstName,
      String id,
      String lastName,
      String reason,
      String toTime,
      String fromTime,
      String leaveAddress,
      String phoneNo,
      String transportType}) async {
    try {
      var data= jsonEncode({
        'firstName': '$firstName',
        'lastName': '$lastName',
        'reason': '$reason',
        'to': '$toTime',
        'from': '$fromTime',
        'address': '$leaveAddress',
        'parentNo': '$phoneNo',
        'mode': '$transportType',
        'id': '$id'
      });
      final response = await post(Uri.parse("http://localhost:3000/outpass"),
          headers: <String, String> {
            'Content-Type': 'application/json',
          },
          body: data);
      print(data);
      return response;
    } catch(e) {
      return e;
    }
  }
}
