import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/modules/loadingDialog.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/admin/Repo/HomeRepo.dart' as repo;

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  List tskLevrqst = [];
  Map<String, dynamic> attndencelist;
  List employees = [];
  List getinvoicea = [];
  List purchseordr = [];
  List viewprojct = [];
  List viewclient = [];
  List viewleave = [];
  List viewMoneytrnsfer = [];
  List dailystaus = [];
  List getmaterialreqq = [];

  bool loading = true;
  var clientid;
  var empid;
  HomeController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void task(token) async {
    await repo.adtask(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          tskLevrqst = value["leave_requests"];
        });
      }
    });
  }

  void viewmoneytran(token) async {
    await repo.viewmoneytrnsfr(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          viewMoneytrnsfer = value["money_transfer"];
          loading = false;
        });
      }
    });
  }

  void purchaseordr(token) async {
    await repo.purchordr(token).then((value) {
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          setState(() {
            purchseordr = value["data"];
            loading = false;
          });
        }
      }
    });
  }

  Future<void> dailystatus() async {
    await repo.dailstss().then((value) {
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          setState(() {
            dailystaus = value["data"]["data"];
            loading = false;
          });
        }
      }
    });
  }

  Future adattndace(token) async {
    await repo.admattendance(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          attndencelist = Map.castFrom(value["data"]);
        });
      }
    });
  }

  void getclientid(tokk) async {
    await repo.clientget(tokk).then((value) {
      if (value["status"] == "1") {
        setState(() {
          clientid = value["data"];
        });
      }
    });
  }

  void getemployyiddd(tok) async {
    await repo.employid(tok).then((value) {
      if (value["status"] == "1") {
        setState(() {
          empid = value["data"];
        });
      }
    });
  }

  Future leavstatus(
      String token, String status, String id, BuildContext context) async {
    DialogBuilder(context).showLoadingDialog();
    await repo.updteleavstts(token, status, id).then((value) {
      DialogBuilder(context).hideOpenDialog();
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
      Fluttertoast.showToast(
        msg: value["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.black,
        fontSize: 16.0,
      );
    });
  }

  void viewemployees(tokn) async {
    await repo.vimploy(tokn).then((value) {
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          employees = value["data"];
        });
      }
    });
  }

  void getinvoice(tokn) async {
    await repo.getttinvo(tokn).then((value) {
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          getinvoicea = value["data"];
        });
      }
    });
  }

  void getmaterialreq(tokn) async {
    await repo.getmaterialr(tokn).then((value) {
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          getmaterialreqq = value["data"];
        });
      }
    });
  }

  void viwprojct(tokn) async {
    await repo.viewpr(tokn).then((value) {
      print(value["data"]);
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          viewprojct = value["data"];
        });
      }
    });
  }

  void viewclint(token) async {
    await repo.viewclin(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          viewclient = value["data"];
        });
      }
    });
  }

  void viewlev(tokn) async {
    await repo.viewleave(tokn).then((value) {
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          viewleave = value["data"];
        });
      }
    });
  }

  void addembloy(fname, lnam, passw, joidte, phon, slry, dep, mail, des,
      context, File image, extn, tokns, eid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
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

    await repo
        .addep(fname, lnam, passw, joidte, phon, slry, dep, mail, des, image,
            tokns, eid)
        .then((value) {
      Navigator.pop(context);
      if (value["status"] == "1") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        NotificationService().showNotification(
            "Employee", "$fname Added Successfully", "1", "", "");
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    });
  }

  void addclient(fname, lnam, email, combny, phon1, phon2, context, File image,
      extn, tokn, clintid) async {
    showDialog(
        context: context,
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

    await repo
        .clientadd(
            fname, lnam, email, combny, phon1, phon2, image, tokn, clintid)
        .then((value) {
      Navigator.pop(context);
      if (value["status"] == "1") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        NotificationService().showNotification(
            "Client", "$fname Added Successfully", "1", "", "");
        Navigator.pop(context);
        // viewclint(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    });
  }

  void addproject(pname, client, strtdte, enddate, totprocst, descrptn, context,
      File upfile, extn, token) async {
    final DateFormat formatdate = DateFormat('dd/MM/yyyy');
    showDialog(
        context: context,
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
    final String strt = formatdate.format(strtdte);
    final String end = formatdate.format(enddate);
    await repo
        .projectadd(
            pname, client, strt, end, totprocst, descrptn, upfile, extn, token)
        .then((value) {
      Navigator.pop(context);
      if (value["status"] == "1") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        NotificationService()
            .showNotification("Project", "Added Successfully", "1", "", "");
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    });
  }
}
