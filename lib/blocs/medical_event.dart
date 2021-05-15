part of 'medical_bloc.dart';

abstract class MedicalEvent extends Equatable {
  const MedicalEvent();
}

// ignore: must_be_immutable
class MedicalSendDataEvent extends MedicalEvent {
  @override
  final String rno;
  final int roomNo;
  final String emergency;
  final String contactNo;
  final MedicalStatus medicalStatus;

  MedicalSendDataEvent(
      {this.rno,
      this.roomNo,
      this.emergency,
      this.contactNo,
      this.medicalStatus});

  List<Object> get props => [rno, Icons.room, emergency, contactNo, medicalStatus];

}
