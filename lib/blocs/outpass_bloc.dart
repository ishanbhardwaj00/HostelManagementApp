import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hostel_managment_system/repositories/outpass.dart';

part 'outpass_event.dart';

part 'outpass_state.dart';

class OutpassBloc extends Bloc<OutpassEvent, OutpassState> {
  Outpass _outpass;

  OutpassBloc({@required Outpass outpass})
      :
        _outpass= outpass,
        super(OutpassState.initial());

  @override
  Stream<OutpassState> mapEventToState(OutpassEvent event,) async* {
    if (event is OutpassSendDataEvent) {
      yield* mapSendOutpassDataEventToState(event);
    }
  }

  Stream<OutpassState> mapSendOutpassDataEventToState(OutpassSendDataEvent event) async* {
    try {
      yield state.copyWith(outpassStatus: OutpassStatus.sending);
      final response = await _outpass.postOutpassData(
        firstName: event.firstName,
        lastName: event.lastName,
        reason: event.reason,
        leaveAddress: event.leaveAddress,
        toTime: event.toTime,
        fromTime: event.fromTime,
        phoneNo: event.phoneNo,
        transportType: event.transportType,
        id: event.id,
      );
      if(response.statusCode==200) {
          yield state.copyWith(outpassStatus: OutpassStatus.sent);
      }
    }  catch (e) {
      print(e);
    }
  }
}
