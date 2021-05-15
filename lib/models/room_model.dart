class Room {
  int rno;
  String oid;
  String type;
  String status;
  String firstName;
  String lastName;
  Room({this.rno, this.oid, this.type, this.status, this.firstName, this.lastName});

  factory Room.fromJson(Map<String, dynamic> map) {
    return Room(
      rno: map['rno'] ,
      oid: map['oid'],
      type: map['type'],
      status: map['status'],
      firstName: map['firstname'],
      lastName: map['lastname']
    );
  }
}