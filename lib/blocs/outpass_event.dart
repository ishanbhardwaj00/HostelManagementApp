part of 'outpass_bloc.dart';

abstract class OutpassEvent extends Equatable {
  const OutpassEvent();
}

class OutpassSendDataEvent extends OutpassEvent {
  final String firstName;
  final String lastName;
  final String reason;
  final String toTime;
  final String fromTime;
  final String leaveAddress;
  final String phoneNo;
  final String transportType;
  final String id;

  OutpassSendDataEvent(
      {this.firstName,
      this.lastName,
      this.reason,
      this.toTime,
      this.fromTime,
      this.leaveAddress,
      this.phoneNo,
      this.id,
      this.transportType});

  @override
  // TODO: implement props
  List<Object> get props => [firstName, lastName, reason, toTime, fromTime, leaveAddress,phoneNo, transportType,id];

}
