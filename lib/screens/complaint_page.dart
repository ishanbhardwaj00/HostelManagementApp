import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_managment_system/blocs/complaint_bloc.dart';
import 'package:hostel_managment_system/blocs/room_bloc.dart';
import 'package:hostel_managment_system/repositories/complaint.dart';

class ComplaintScreen extends StatefulWidget {
  final RoomBloc roomBloc;

  const ComplaintScreen({Key key, this.roomBloc}) : super(key: key);
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Complaints",
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
                  "Got electricity problems? Need pest control? Damp walls? Furniture problems? We've got you covered!",
                  style: GoogleFonts.raleway(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0XFFFEFEFA), boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.grey,
                    blurRadius: 6.0,
                  )
                ]),
                child: Column(
                  children: [
                    Container(
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/girl_complain.png"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RepositoryProvider(
                      create: (context) => Complaint(),
                      child: BlocProvider(
                        create: (context) =>
                            ComplaintBloc(complaint: context.read<Complaint>()),
                        child: BlocBuilder<ComplaintBloc, ComplaintState>(
                          builder: (context, state) {
                            if (state.complaintStatus ==
                                ComplaintStatus.sending) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if(widget.roomBloc.state==null) {
                              return Center(child: Text("null"),);
                            }
                            if (state.complaintStatus == ComplaintStatus.sent) {
                              return Center(
                                child: Text("SENT"),
                              );
                            }
                            return Form(
                              key: formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Problem",
                                      style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Field cannot be left blank";
                                        }
                                        return null;
                                      },
                                      controller: problemController,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Describe your problem here...",
                                        hintStyle: GoogleFonts.raleway(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Contact Number",
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: (val) {
                                        if(val.isEmpty) {
                                          return "Field cannot be left blank";
                                        }
                                        return null;
                                      },
                                      controller: contactController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: "Phone Number",
                                        hintStyle: GoogleFonts.raleway(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (formKey.currentState
                                                .validate()) {
                                              context.read<ComplaintBloc>()
                                                ..add(
                                                  ComplaintSendEvent(
                                                    problem:
                                                        problemController.text ,
                                                    contactNumber:
                                                        contactController.text ,
                                                    rno: widget.roomBloc
                                                        .state
                                                        .oid,
                                                    roomNo: widget.roomBloc
                                                        .state
                                                        .rno,
                                                  ),
                                                );
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8),
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              "SUBMIT",
                                              style: GoogleFonts.raleway(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
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
  }
}
