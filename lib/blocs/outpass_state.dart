part of 'outpass_bloc.dart';

enum OutpassStatus {sent, notSent, sending}
class OutpassState extends Equatable {
  const OutpassState(
      {this.firstName,
      this.id,
      this.outpassStatus,
      this.lastName,
      this.reason,
      this.toTime,
      this.fromTime,
      this.leaveAddress,
      this.phoneNo,
      this.transportType});

  final String firstName;
  final OutpassStatus outpassStatus;
  final String lastName;
  final String reason;
  final String toTime;
  final String fromTime;
  final String leaveAddress;
  final String phoneNo;
  final String transportType;
  final String id;

  factory OutpassState.initial() {
    return OutpassState(
        id: "",
        outpassStatus: OutpassStatus.notSent,
        reason: "",
        firstName: "",
        lastName: "",
        fromTime: "",
        toTime: "",
        phoneNo: "",
        transportType: "",
        leaveAddress: "");
  }

  OutpassState copyWith(
      {String reason,
      String firstName,
      String lastName,
      String fromTime,
      String toTime,
      String id,
      String phoneNo,
      String transportType,
      String leaveAddress,
      OutpassStatus outpassStatus}) {
    return OutpassState(
      reason: reason ?? this.reason,
      firstName: firstName?? this.firstName,
      lastName: lastName?? this.lastName,
      fromTime: fromTime?? this.fromTime,
      toTime: toTime?? this.toTime,
      phoneNo: phoneNo?? this.phoneNo,
      transportType: transportType?? this.transportType,
      leaveAddress: leaveAddress?? this.leaveAddress,
      outpassStatus: outpassStatus?? this.outpassStatus,
      id: id?? this.id,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        reason,
        firstName,
        lastName,
        fromTime,
        toTime,
        phoneNo,
        transportType,
        leaveAddress,
        outpassStatus
      ];
}
