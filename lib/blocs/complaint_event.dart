part of 'complaint_bloc.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();
}

class ComplaintSendEvent extends ComplaintEvent {
  final String rno;
  final String problem;
  final int roomNo;
  final String contactNumber;
  final ComplaintStatus complaintStatus;

  ComplaintSendEvent(
      {this.rno,
      this.problem,
      this.roomNo,
      this.contactNumber,
      this.complaintStatus});

  @override
  // TODO: implement props
  List<Object> get props => [rno, problem, roomNo, contactNumber, complaintStatus];
}
