import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/user/Repository/UserHomeRepository.dart' as repo;

class UserHomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  var userviewholylist = [];
  bool loading = true;
  var stffviewtask = [];
  var empdetails = [];
  var staffdailystatus = [];
  var allleave = [];
  int totaltask;
  bool submitrqst = false;

  UserHomeController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void usrviewholy(token) async {
    await repo.usrviewholydy(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          userviewholylist = value["data"];
          loading = false;
        });
      }
    });
  }

  void staffdailystats(token, context) async {
    await repo.staffdailystatus(token).then((value) {
      setState(() {
        loading = false;
      });
      if (value.isNotEmpty) {
        // Navigator.pop(context);
        if (value["status"] == "1") {
          setState(() {
            staffdailystatus = value["data"];
          });
        }
      }
    });
  }

  void stffaddattenedence(
      String token, DateTime dte, int att, BuildContext cont) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final formatedDate = formatter.format(dte);
    showDialog(
        context: cont,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: EdgeInsets.all(0),
              content: StatefulBuilder(builder: (BuildContext context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Loading...",
                          style: b18W5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }));
        });
    await repo.stffaddattndece(token, formatedDate, att).then((value) {
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          Fluttertoast.showToast(
            msg: value["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 35,
            backgroundColor: Colors.black,
            fontSize: 16.0,
          );
        }
      }
      Navigator.pop(cont);
    });
  }

  void stafftask(token) async {
    await repo.viewtask(token).then((value) {
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          setState(() {
            stffviewtask = value["leave_requests"];
            empdetails = value["employee_dtailes"];
            totaltask = stffviewtask.length + empdetails.length;
          });
        }
      }
    });
  }

  void viewallstffleave(token) async {
    await repo.viewleave(token).then((value) {
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          setState(() {
            allleave = value["data"];
          });
        }
      }
    });
  }

  void addleave(BuildContext cont, String leavtype, String from, String to,
      String reson, int totaldys, String token) {
    showDialog(
        context: cont,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: EdgeInsets.all(0),
              content: StatefulBuilder(builder: (BuildContext context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Loading...",
                          style: b18W5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }));
        });

    repo.stffaddleave(leavtype, from, to, reson, totaldys, token).then((value) {
      Navigator.pop(cont);
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          NotificationService().showNotification("Leave request",
              "Submitted successfully", "1", "leave_req", "Apply leave");
          setState(() {
            submitrqst = true;
          });
          showDialog(
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              child: Container(
                width: 350,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 56,
                      ),
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Submit Request\n Success",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[700],
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xff4a67b3)),
                        )),
                  ],
                ),
              ),
            ),
            context: cont,
          );
        } else {
          Navigator.pop(cont);
        }
      }
    });
  }
}
