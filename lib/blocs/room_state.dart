part of 'room_bloc.dart';

enum RoomStatus { loaded, notLoaded, error, loading }

class RoomState extends Equatable {
  int rno;
  String oid;
  String firstName;
  String lastName;
  String type;
  String status;
  RoomStatus loadedStatus;

  RoomState(
      {@required this.rno,
      @required this.oid,
        @required this.firstName,
        @required this.lastName,
      @required this.type,
      @required this.status,
      @required this.loadedStatus
      });

  factory RoomState.initial() {
    return RoomState(
      rno: 0,
      oid: "",
      firstName: "",
      lastName: "",
      type: "",
      status: "",
      loadedStatus: RoomStatus.notLoaded,
    );
  }

  RoomState copyWith({
       int rno,
       String oid,
       String type,
       String status,
       String firstName,
       String lastName,
       RoomStatus loadedStatus,
  }) {
    return RoomState(
        rno: rno ?? this.rno,
        oid: oid ?? this.oid,
        type: type ?? this.type,
        firstName: firstName?? this.firstName,
        lastName: lastName?? this.lastName,
        status: status ?? this.status,
        loadedStatus: loadedStatus?? this.loadedStatus
    );
  }

  @override
  List<Object> get props => [rno, oid, type, status, firstName, lastName];
}
