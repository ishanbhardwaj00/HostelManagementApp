import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hostel_managment_system/blocs/outpass_bloc.dart';
import 'package:hostel_managment_system/repositories/complaint.dart';

part 'complaint_event.dart';

part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc({@required Complaint complaint})
      : _complaint = complaint,
        super(ComplaintState.initial());

  final Complaint _complaint;

  @override
  Stream<ComplaintState> mapEventToState(
    ComplaintEvent event,
  ) async* {
    if (event is ComplaintSendEvent) {
      yield* mapComplaintSendEventToState(event);
    }
  }

  Stream<ComplaintState> mapComplaintSendEventToState(
      ComplaintSendEvent event) async* {
    try {
      yield state.copyWith(complaintStatus: ComplaintStatus.sending);
      var response = await _complaint.postComplaintData(
          contactNumber: event.contactNumber,
          problem: event.problem,
          roomNo: event.roomNo,
          rno: event.rno);
      if(response.statusCode==200) {
        yield state.copyWith(complaintStatus: ComplaintStatus.sent);
      }
    }  catch (e) {
      print(e);
    }
  }
}
