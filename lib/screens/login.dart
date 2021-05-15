import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_managment_system/blocs/auth_bloc.dart';
import 'package:hostel_managment_system/repositories/auth.dart';
import 'package:hostel_managment_system/screens/main_page.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SignIn(),
      child: BlocProvider(
        create: (context) => AuthBloc(signIn: context.read<SignIn>()),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.loggedIn) {
                return HomeScreen(oid: id.text);
              } else if (state.status == AuthStatus.loading) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  body: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "MyCampusDays",
                              style: GoogleFonts.lobster(
                                  textStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 24,
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2 ,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: AssetImage("assets/studentsNew.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Login",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Column(
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Container(
                                        width: 300,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "ID",
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                          controller: id,
                                          validator: (value) {
                                            if (value.length < 9)
                                              return "ID cannot be less than 9 letters";
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Container(
                                        width: 300,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            fillColor: Colors.white,
                                            labelText: "Password",
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                          controller: password,
                                          validator: (value) {
                                            if (value.length < 5) {
                                              return "Password has to be at least 5 characters";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!formKey.currentState.validate()) return;
                              context.read<AuthBloc>().add(AuthLoginEvent(
                                  id: id.text, password: password.text));
                            },
                            child: Text(
                              "Submit",
                              style: GoogleFonts.raleway(),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
