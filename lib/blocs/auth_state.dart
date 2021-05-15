part of 'auth_bloc.dart';

enum AuthStatus {loggedIn, notLoggedIn, loading}
class AuthState extends Equatable {

  final String id;
  final String password;
  final AuthStatus status;
  const AuthState({@required this.id, @required this.password, @required this.status});
  @override

  List<Object> get props => [id, password, status];
  @override
  bool get stringify => super.stringify;

  factory AuthState.initial() {
    return AuthState(id: "", password: "", status: AuthStatus.notLoggedIn);
  }

  AuthState copyWith({String id, String password, AuthStatus status}) {
    return AuthState(
        id: id ?? this.id,
        password: password ?? this.password,
        status: status ?? this.status,
    );
  }
}


