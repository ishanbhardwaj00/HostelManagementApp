import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hostel_managment_system/blocs/room_bloc.dart';
import 'package:hostel_managment_system/repositories/feedback.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc({@required FeedBack feedback})
      : _feedback = feedback,
        super(FeedbackState.initial());

  final FeedBack _feedback;

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
    if (event is FeedbackSendEvent) {
      yield* mapSendFeedbackSendEventToState(event);
    }
  }

  Stream<FeedbackState> mapSendFeedbackSendEventToState(
      FeedbackSendEvent event) async* {
    print("${event.message} : ${event.rno}");
    yield state.copyWith(status: FeedbackStatus.sending);
    var response = await _feedback.postMessage(rno: event.rno, message: event.message);
    if (response.statusCode == 200) {
      print("feedback sent");
      yield state.copyWith(status: FeedbackStatus.sent);
    }

  }
}
