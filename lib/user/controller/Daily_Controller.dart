import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/user/Repository/Daily_Repo.dart' as repo;

class DailyController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;

  bool loading = true;
  List projectlist = [];
  List dilyexpnceview = [];
  List dilytaskview = [];
  var emppList;
  DailyController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void getproject(token) async {
    await repo.dropviewproj(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          projectlist = value["data"];
        });
      }
    });
  }

  void getstaff(token) async {
    await repo.dropviewemployees(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          emppList = value["data"];
          loading = false;
        });
      }
      setState(() {
        loading = false;
      });
    });
  }

  void getviewdailyexpance(token) async {
    await repo.staffdailyexpnceview(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          dilyexpnceview = value["data"];
          loading = false;
        });
      }
    });
  }

  void adddasts(String proj, List employ, String dissc, File img,
      BuildContext context) async {
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
        .adddailysts(
      proj,
      employ,
      dissc,
      img,
    )
        .then((value) {
      Navigator.pop(context);
      if (value != null) {
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
        Navigator.pop(context);
      }
    });
  }

  void dailyexpnceupdate(
      expid, status, paidamount, total, File img, token, context) async {
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
        .updatestaffdailyexpnce(expid, status, paidamount, total, img, token)
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
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      }
    });
  }

  void dailytaskviewww(token) async {
    await repo.staffdailytaskview(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          dilytaskview = value["data"];
          loading = false;
        });
      }
      setState(() {
        loading = false;
      });
    });
  }

  void adddailytask(proj, remark, context) async {
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
    await repo.adddailytask(proj, remark).then((value) {
      if (value["status"] == "1") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.pop(context);
        Navigator.pop(context);
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
}
