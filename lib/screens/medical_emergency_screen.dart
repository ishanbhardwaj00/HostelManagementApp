import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_managment_system/blocs/medical_bloc.dart';
import 'package:hostel_managment_system/blocs/room_bloc.dart';
import 'package:hostel_managment_system/repositories/medical_emergency.dart';

class MedicalEmergencyScreen extends StatefulWidget {
  final RoomBloc roomBloc;

  const MedicalEmergencyScreen({Key key, this.roomBloc}) : super(key: key);

  @override
  _MedicalEmergencyScreenState createState() => _MedicalEmergencyScreenState();
}

class _MedicalEmergencyScreenState extends State<MedicalEmergencyScreen> {
  final TextEditingController medicalController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Medical Emergency",
                  style: GoogleFonts.raleway(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Feeling unwell? Need medical assistance right at your fingertips? Fill out the details and we'll get back to you ASAP!",
                  style: GoogleFonts.raleway(color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffFEFEFA), boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(0, 2),
                  ),
                ]),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/patient.jpg"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RepositoryProvider(
                      create: (context) => MedicalEmergency(),
                      child: BlocProvider(
                        create: (context) => MedicalBloc(
                          emergency: context.read<MedicalEmergency>(),
                        ),
                        child: BlocBuilder<MedicalBloc, MedicalState>(
                          builder: (context, state) {
                            if (state.medicalStatus == MedicalStatus.sending) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state.medicalStatus ==
                                MedicalStatus.sent) {
                              return Center(
                                child: Text("SENT"),
                              );
                            } else if (widget.roomBloc.state == null) {
                              return Center(
                                child: Text("null"),
                              );
                            }
                            return Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Medical Emergency",
                                    style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "Field cannot be left empty";
                                      return null;
                                    },
                                    controller: medicalController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      hintText: "State your emergency here...",
                                      hintStyle: GoogleFonts.raleway(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Contact No",
                                    style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: contactController,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "Field cannot be left empty";
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      hintText: "Mobile Number...",
                                      hintStyle: GoogleFonts.raleway(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (formKey.currentState.validate()) {
                                            context.read<MedicalBloc>()
                                              ..add(
                                                MedicalSendDataEvent(
                                                    emergency:
                                                        medicalController.text,
                                                    contactNo:
                                                        contactController.text,
                                                    rno: widget
                                                        .roomBloc.state.oid,
                                                    roomNo: widget
                                                        .roomBloc.state.rno),
                                              );
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(8),
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.orange,
                                          ),
                                          child: Center(
                                              child: Text("SUBMIT",
                                                  style:
                                                      GoogleFonts.raleway())),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
