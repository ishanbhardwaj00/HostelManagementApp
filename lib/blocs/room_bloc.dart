import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hostel_managment_system/models/room_model.dart';
import 'package:hostel_managment_system/repositories/get_room.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  DisplayRoom _displayRoom;

  RoomBloc({@required DisplayRoom displayRoom})
      : _displayRoom = displayRoom,
        super(RoomState.initial());

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is RoomDisplayEvent) {
      yield* mapRoomDisplayEventToState(event);
    }
  }

  Stream<RoomState> mapRoomDisplayEventToState(RoomDisplayEvent event) async* {
    try {
      yield state.copyWith(loadedStatus: RoomStatus.loading);
      final response = await _displayRoom.getRoomData(event.oid);
      if (response.statusCode == 200) {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        var room = Room.fromJson(jsonData[0]);
        yield state.copyWith(
            rno: room.rno,
            oid: room.oid,
            type: room.type,
            status: room.status,
            firstName: room.firstName,
            lastName: room.lastName,
            loadedStatus: RoomStatus.loaded);
      }
    } catch (e) {
      yield state.copyWith(loadedStatus: RoomStatus.error);
      print(e);
    }
  }
}
