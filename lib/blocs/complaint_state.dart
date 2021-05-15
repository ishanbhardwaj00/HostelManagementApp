part of 'complaint_bloc.dart';

enum ComplaintStatus { notSent, sending, sent }

class ComplaintState extends Equatable {
  final String rno;
  final String problem;
  final int roomNo;
  final String contactNumber;
  final ComplaintStatus complaintStatus;

  ComplaintState(
      {this.rno,
      this.problem,
      this.roomNo,
      this.contactNumber,
      this.complaintStatus});

  List<Object> get props =>
      [rno, problem, roomNo, contactNumber, complaintStatus];

  factory ComplaintState.initial() {
    return ComplaintState(
        rno: "",
        problem: "",
        roomNo: -1,
        contactNumber: "",
        complaintStatus: ComplaintStatus.notSent);
  }

  ComplaintState copyWith(
      {String rno,
      String problem,
      int roomNo,
      String contactNumber,
      ComplaintStatus complaintStatus}) {
    return ComplaintState(
        rno: rno ?? this.rno,
        problem: problem ?? this.problem,
        contactNumber: contactNumber ?? this.contactNumber,
        complaintStatus: complaintStatus ?? this.complaintStatus);
  }
}
