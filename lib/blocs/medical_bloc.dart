import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostel_managment_system/repositories/medical_emergency.dart';

part 'medical_event.dart';
part 'medical_state.dart';

class MedicalBloc extends Bloc<MedicalEvent, MedicalState> {
  MedicalBloc({@required MedicalEmergency emergency}) : _emergency= emergency, super(MedicalState.initial());
  final MedicalEmergency _emergency;

  @override
  Stream<MedicalState> mapEventToState(
    MedicalEvent event,
  ) async* {
    if(event is MedicalSendDataEvent) {
      yield* mapMedicalSendDataEventToState(event);
    }

  }

 // ignore: missing_return
 Stream<MedicalState> mapMedicalSendDataEventToState(MedicalSendDataEvent event) async * {
    yield state.copyWith(medicalStatus: MedicalStatus.sending);
    var response= await _emergency.postMedicalEmergencyData(roomNo: event.roomNo, rno: event.rno, emergency: event.emergency,contactNo: event.contactNo);
    if(response.statusCode==200) {
      yield state.copyWith(medicalStatus: MedicalStatus.sent);
    }
 }
}
