part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String id;
  final String password;
  AuthLoginEvent({this.password, this.id});
  @override
  List<Object> get props => [id, password];
}
