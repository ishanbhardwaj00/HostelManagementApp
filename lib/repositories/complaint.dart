import 'dart:convert';

import 'package:http/http.dart';

class Complaint {
  final String rno;
  final String problem;
  final int roomNo;
  final String contactNumber;

  Complaint({this.rno, this.problem, this.roomNo, this.contactNumber});

  Future<Response> postComplaintData(
      {String rno, String problem, int roomNo, String contactNumber})  async {
        var response= await post(Uri.parse("http://localhost:3000/complaint",),
          headers: <String, String> {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'rno': '$rno',
            'problem': '$problem',
            'contact_no': '$contactNumber',
            'room_no': roomNo,
          }),
        );
        if(response.statusCode==200) {
          print("complaint success");
          return response;
        }
  }
}
