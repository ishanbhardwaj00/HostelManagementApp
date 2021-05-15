part of 'medical_bloc.dart';
 enum MedicalStatus {sending, notSent, sent}
class MedicalState extends Equatable {
  final String rno;
  final int roomNo;
  final String emergency;
  final String contactNo;
  final MedicalStatus medicalStatus;

  MedicalState(
      {this.rno,
      this.roomNo,
      this.emergency,
      this.contactNo,
      this.medicalStatus});
  @override
  // TODO: implement props
  List<Object> get props => [rno, roomNo, emergency, contactNo, medicalStatus];

  factory MedicalState.initial() {
    return MedicalState(
      roomNo: -1,
      rno: "",
      emergency: "",
      contactNo: "",
      medicalStatus: MedicalStatus.notSent
    );
  }

  MedicalState copyWith({String rno, int roomNo, String emergency, String contactNo, MedicalStatus medicalStatus}) {
    return MedicalState(
      rno: rno?? this.rno,
      roomNo: roomNo?? this.roomNo,
      emergency: emergency?? this.emergency,
      contactNo: contactNo?? this.contactNo,
      medicalStatus: medicalStatus?? this.medicalStatus
    );
  }
}

