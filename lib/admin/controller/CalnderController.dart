import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/admin/Repo/CalndrRepo.dart' as repo;

class CalendersControllr extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  bool loading = true;

  var viewholydys = [];
  var viewcalnderr = [];
  CalendersControllr() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void viwhlyday() async {
    await repo.viewholy().then((value) {
      if (value["status"] == "1") {
        setState(() {
          viewholydys = value["data"];
          loading = false;
        });
      }
    });
  }

  void viecalnder() async {
    await repo.viecalnder().then((value) {
      if (value["status"] == "1") {
        setState(() {
          viewcalnderr = value["data"];
          loading = false;
        });
      }
    });
  }

  void addcalnder(evnme, evdate, context) async {
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
    await repo.addcalnder(evnme, evdate).then((value) {
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
            .showNotification("Calender", "Added Successfully", "1", "", "");
        Navigator.pop(context);
        viecalnder();
        Navigator.pop(context);
      } else
        Navigator.pop(context);
    });
  }

  void addviewholyclndr(hnam, date, context) async {
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
    await repo.addholyviewcal(hnam, date).then((value) {
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
            .showNotification("Holiday", "Added Successfully", "1", "", "");
        Navigator.pop(context);
        viwhlyday();
        Navigator.pop(context);
      } else
        Navigator.pop(context);
    });
  }
}
