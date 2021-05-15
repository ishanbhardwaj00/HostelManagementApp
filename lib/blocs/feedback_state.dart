part of 'feedback_bloc.dart';


enum FeedbackStatus {sent, notSent, sending}

// ignore: must_be_immutable
class FeedbackState extends Equatable {
  final String message;
  final String rno;
  final FeedbackStatus status;

  FeedbackState({this.rno, this.message, this.status});

  factory FeedbackState.initial() {
    return FeedbackState(
      message: "",
      rno: "",
      status: FeedbackStatus.notSent,
    );
  }
  FeedbackState copyWith({String rno, String message, @required FeedbackStatus status}) {
    return FeedbackState(
      rno: rno?? this.rno,
      message: message?? this.message,
      status: status?? this.status
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [message, rno, status];
}
