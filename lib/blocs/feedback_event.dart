part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();
}

class FeedbackSendEvent  extends FeedbackEvent {
  final String rno;
  final String message;

  FeedbackSendEvent({this.rno, this.message});

  @override
  // TODO: implement props
  List<Object> get props => [rno, message];
}