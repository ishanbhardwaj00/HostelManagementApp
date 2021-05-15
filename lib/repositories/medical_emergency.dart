import 'dart:convert';

import 'package:http/http.dart';

class MedicalEmergency {
  final String rno;
  final int roomNo;
  final String emergency;
  final String contactNo;

  MedicalEmergency({this.rno, this.roomNo, this.emergency, this.contactNo});

  // ignore: missing_return
  Future<Response> postMedicalEmergencyData(
      {String rno, int roomNo, String emergency, String contactNo}) async {
    try {
      var response = await post(
        Uri.parse("http://localhost:3000/medical"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'rno': '$rno',
            'roomNo': roomNo,
            'emergency': '$emergency',
            'contactNo': '$contactNo'
          },
        ),
      );
      return response;
    }  catch (e) {
      print(e);
      return null;
    }
  }
}
