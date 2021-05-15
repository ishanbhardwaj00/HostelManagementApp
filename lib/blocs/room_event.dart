part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

// ignore: must_be_immutable
class RoomDisplayEvent extends RoomEvent {
  int rno;
  String oid;
  String type;
  String status;
  String name;
    RoomDisplayEvent({this.rno, this.oid, this.type, this.status, this.name});
  @override
  List<Object> get props => [rno, oid, type, status, name];
}