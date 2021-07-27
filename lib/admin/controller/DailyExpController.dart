import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/admin/Repo/DailyExpRepo.dart' as repo;

class DailyExpController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  bool loading = true;
  var dailyexp = [];
  var empdailytaskview = [];
  DailyExpController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void viewdailyexp(token) async {
    print("DAILY EXP");

    await repo.viewdailyexpnce(token).then((value) {
      print(value);
      if (value["status"] == "1") {
        setState(() {
          dailyexp = value["data"];
          loading = false;
        });
        print(dailyexp);
      }
    });
  }

  void updatedailyexp(
      expid, status, paidamount, total, File img, token, context) async {
    print("DAILY EXP");
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
        .updateadmindailyexpnce(expid, status, paidamount, total, img, token)
        .then((value) {
      print("ANAS MOOOZ");
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

  void vieempdalytask(token) async {
    print("DAILY PPPPPPPPPPPPPPOOOOOOOOOOOOOOOO");

    await repo.viewemploydailyask(token).then((value) {
      print(value);
      if (value["status"] == "1") {
        setState(() {
          empdailytaskview = value["data"];
          loading = false;
        });
        print(empdailytaskview);
      }
    });
  }
}
