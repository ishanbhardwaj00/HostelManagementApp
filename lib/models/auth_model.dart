import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  String id;
  String password;
  AuthModel({this.password, this.id});

  @override
  List<Object> get props => [id, password];
}