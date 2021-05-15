import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hostel_managment_system/repositories/auth.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required SignIn signIn}) :
        _signIn= signIn,
        super(AuthState.initial());

  final SignIn _signIn;
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AuthLoginEvent) {
      yield* mapAuthLoginEventToState(event);
    }

  }
  Stream<AuthState> mapAuthLoginEventToState(AuthLoginEvent event) async* {
      print(event.id+" "+ event.password);
      yield state.copyWith(status: AuthStatus.loading);
      var response= await _signIn.postData(event.id, event.password);
      if(response.statusCode==200) {
        print("logged in");
        yield state.copyWith(id: event.id,status: AuthStatus.loggedIn);
      }
  }
}
