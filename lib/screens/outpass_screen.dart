import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_managment_system/blocs/outpass_bloc.dart';
import 'package:hostel_managment_system/blocs/room_bloc.dart';
import 'package:hostel_managment_system/repositories/outpass.dart';

// ignore: must_be_immutable
class OutpassScreen extends StatefulWidget {
  final RoomBloc roomBloc;
  OutpassScreen({this.roomBloc});
  @override
  _OutpassScreenState createState() => _OutpassScreenState();
}

class _OutpassScreenState extends State<OutpassScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime fromDateTime;
  DateTime toDateTime;
  TextEditingController reason= new TextEditingController();
  TextEditingController leaveAddress= new TextEditingController();
  TextEditingController phoneNo= new TextEditingController();
  TextEditingController transportType= new TextEditingController();
  String toDate;
  String fromDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "MyCampusDays",
                style: GoogleFonts.lobster(color: Colors.orange),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Outpass",
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      letterSpacing: 1.2),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Going home? Going to the city? Or just need an outpass to chillout with friends? Fill in your details and get an outpass hasslefree.",
                  style: GoogleFonts.raleway(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xffFEFEFA), boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 3.0,
                    offset: Offset(3, 7),
                  ),
                ]),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/outpass.jpg")),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RepositoryProvider(
                      create: (context) => Outpass(),
                      child: BlocProvider(
                        create: (context) =>
                            OutpassBloc(outpass: context.read<Outpass>()),
                        child: BlocBuilder<OutpassBloc, OutpassState>(
                          builder: (context, state) {
                            if (state.outpassStatus == OutpassStatus.sending) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if(widget.roomBloc.state==null) {
                              return Center(child: Text("null"),);
                            }
                            if (state.outpassStatus == OutpassStatus.sent) {
                              return Center(
                                child: Text("SENT"),
                              );
                            }
                            return Form(
                              key: formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Reason of leave",
                                        style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      validator: (val) {
                                        if (val.length <= 10) {
                                          return "Reason should atleast be 10 characters";
                                        }
                                        return null;
                                      },
                                      controller: reason,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        hintText: "State your reason here...",
                                        hintStyle: GoogleFonts.raleway(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "From ",
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      //color: Colors.pink,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              fromDate == null
                                                  ? "Pick a date"
                                                  : fromDate,
                                              style: GoogleFonts.raleway(
                                                  color: Colors.black54,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              fromDateTime = await pickDate();
                                              fromDate =
                                                  "${fromDateTime.day}-${fromDateTime.month}-${fromDateTime.year}";
                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.orange),
                                                ),
                                                height: 30,
                                                width: 70,
                                                child: Text(
                                                  "SELECT",
                                                  style: GoogleFonts.raleway(
                                                      color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "To ",
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      //color: Colors.pink,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              toDate == null
                                                  ? "Pick a date"
                                                  : toDate,
                                              style: GoogleFonts.raleway(
                                                  color: Colors.black54,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              toDateTime = await pickDate();
                                              setState(() {
                                                toDate =
                                                    "${toDateTime.day}-${toDateTime.month}-${toDateTime.year}";
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.orange),
                                                ),
                                                height: 30,
                                                width: 70,
                                                child: Text(
                                                  "SELECT",
                                                  style: GoogleFonts.raleway(
                                                      color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Leave Address",
                                      style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      validator: (val) {
                                        if (val.length <= 10) {
                                          return "Address should atleast be 10 characters";
                                        }
                                        return null;
                                      },
                                      controller: leaveAddress,
                                      decoration: InputDecoration(
                                        hintText: "Address",
                                        hintStyle: GoogleFonts.raleway(
                                            color: Colors.black54),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Parent's Mobile Number",
                                      style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      validator: (val) {
                                        if (val.length < 10) {
                                          return "Number should atleast be 10 characters";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: phoneNo,
                                      decoration: InputDecoration(
                                        hintText: "Mobile Number",
                                        hintStyle: GoogleFonts.raleway(
                                            color: Colors.black54),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Mode of transport",
                                      style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      validator: (val) {
                                        if (val.length < 3) {
                                          return "Mode should atleast be 3 characters";
                                        }
                                        return null;
                                      },
                                      controller: transportType,
                                      decoration: InputDecoration(
                                        hintText: "Transport type",
                                        hintStyle: GoogleFonts.raleway(
                                            color: Colors.black54),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (formKey.currentState
                                                .validate()) {
                                              context.read<OutpassBloc>()
                                                ..add(
                                                  OutpassSendDataEvent(
                                                      firstName: widget.roomBloc
                                                          .state
                                                          .firstName,
                                                      lastName: widget.roomBloc
                                                          .state
                                                          .lastName,
                                                      reason: reason.text ?? " ",
                                                      toTime: toDate,
                                                      fromTime: fromDate,
                                                      id: widget.roomBloc.state.oid,
                                                      leaveAddress:
                                                          leaveAddress.text ?? " ",
                                                      phoneNo: phoneNo.text ?? " ",
                                                      transportType:
                                                          transportType.text ?? " "),
                                                );
                                            }
                                            return null;
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8),
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            child: Text(
                                              "SUBMIT",
                                              style: GoogleFonts.raleway(
                                                color: Colors.orange,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ]),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 2));
    return date;
  }
}
