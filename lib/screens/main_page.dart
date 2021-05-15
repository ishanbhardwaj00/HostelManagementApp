import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hostel_managment_system/blocs/auth_bloc.dart';
import 'package:hostel_managment_system/blocs/feedback_bloc.dart';
import 'package:hostel_managment_system/blocs/room_bloc.dart';
import 'package:hostel_managment_system/repositories/auth.dart';
import 'package:hostel_managment_system/repositories/feedback.dart';
import 'package:hostel_managment_system/repositories/get_room.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_managment_system/repositories/feedback.dart';

import 'complaint_page.dart';
import 'medical_emergency_screen.dart';
import 'outpass_screen.dart';

class HomeScreen extends StatefulWidget {
  final String oid;

  HomeScreen({this.oid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController messageController = TextEditingController();
  final textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DisplayRoom(),
      child: BlocProvider<RoomBloc>(
        create: (context) => RoomBloc(displayRoom: context.read<DisplayRoom>())
          ..add(RoomDisplayEvent(oid: this.widget.oid)),
        child: BlocBuilder<RoomBloc, RoomState>(
          builder: (context, state) {
            if (state.loadedStatus == RoomStatus.error) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Text("An error occurred please try again later."),
                ),
              );
            } else if (state.loadedStatus == RoomStatus.loading) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  "MyCampusDays",
                  style: GoogleFonts.lobster(
                      textStyle: TextStyle(color: Colors.orange),
                      fontWeight: FontWeight.w300),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Hello, ${state.firstName}!",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Have complaints? Need an outpass? We've got you covered!",
                        style: GoogleFonts.raleway(
                          textStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.grey,
                        child: Stack(
                          children: [
                            ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ComplaintScreen(
                                          roomBloc: context.read<RoomBloc>(),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      height: 230,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFEFEFA),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                              color: Colors.grey,
                                            )
                                          ],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          )),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            // color: Colors.orangeAccent,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/complaint.jpg"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "COMPLAINT",
                                            style: GoogleFonts.raleway(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return OutpassScreen(
                                            roomBloc: context.read<RoomBloc>(),
                                          );
                                        },
                                      ),
                                    ),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFfefefa),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                              color: Colors.grey,
                                            )
                                          ],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          )),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            // color: Colors.orangeAccent,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/outpass.jpg"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "OUTPASS",
                                            style: GoogleFonts.raleway(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            MedicalEmergencyScreen(roomBloc: context.read<RoomBloc>(),),
                                      ),
                                    ),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEFEFA),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 3,
                                            color: Colors.grey,
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            // color: Colors.orangeAccent,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/med.jpg"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "MEDICAL EMERGENCY",
                                            style: GoogleFonts.raleway(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RepositoryProvider(
                        create: (context) => FeedBack(),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (BuildContext context) => FeedbackBloc(
                                feedback: context.read<FeedBack>(),
                              ),
                            ),
                          ],
                          child: BlocBuilder<FeedbackBloc, FeedbackState>(
                            builder: (context, state) {
                              if (state.status == FeedbackStatus.sending) {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (state.status == FeedbackStatus.sent) {
                                return Container(
                                  //height: 500,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFEFEFA),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          offset: Offset(6, 0),
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                        image:
                                            AssetImage("assets/feedback.jpg"),
                                      ),
                                      Text(
                                        "Found a bug? Have a suggestion? Request a feature? Or just want to get in touch with the developer?",
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Send us your feedback",
                                        style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Form(
                                        key: textKey,
                                        child: TextFormField(
                                          controller: messageController,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return "Message field cannot be left blank";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            labelText: "Message",
                                            labelStyle: GoogleFonts.raleway(),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (textKey.currentState
                                                  .validate()) {
                                                context.read<FeedbackBloc>()
                                                  ..add(
                                                    FeedbackSendEvent(
                                                        rno: context
                                                            .read<RoomBloc>()
                                                            .state
                                                            .oid,
                                                        message:
                                                            messageController
                                                                .text),
                                                  );
                                                messageController.clear();
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 1),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "SUBMIT",
                                                  style: GoogleFonts.raleway(
                                                      color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                //height: 500,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFEFEFA),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3.0,
                                        offset: Offset(6, 0),
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: AssetImage("assets/feedback.jpg"),
                                    ),
                                    Text(
                                      "Found a bug? Have a suggestion? Request a feature? Or just want to get in touch with the developer?",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Send us your feedback",
                                      style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Form(
                                      key: textKey,
                                      child: TextFormField(
                                        controller: messageController,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Message field cannot be left blank";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          labelText: "Message",
                                          labelStyle: GoogleFonts.raleway(),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (textKey.currentState
                                                .validate()) {
                                              context.read<FeedbackBloc>()
                                                ..add(
                                                  FeedbackSendEvent(
                                                      rno: context
                                                          .read<RoomBloc>()
                                                          .state
                                                          .oid,
                                                      message: messageController
                                                          .text),
                                                );
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: Colors.orange,
                                                  width: 1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "SUBMIT",
                                                style: GoogleFonts.raleway(
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
