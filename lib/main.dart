import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_managment_system/blocs/auth_bloc.dart';
import 'package:hostel_managment_system/repositories/auth.dart';
import 'package:hostel_managment_system/screens/login.dart';
import 'file:///C:/Users/ishan/AndroidStudioProjects/hostel_managment_system/lib/screens/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
