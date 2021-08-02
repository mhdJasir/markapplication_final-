import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/modules/loadingDialog.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/admin/Repo/MatrialReqRepo.dart' as repo;

class MaterialControllr extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  List projectlist = [];
  List emppList = [];
  List vndorlist = [];
  List itemList = [];

  MaterialControllr() {
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
        });
      }
    });
  }

  void getvendor(token) async {
    await repo.dropvendor(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          vndorlist = value["vendors"];
        });
      }
    });
  }

  void getitms(token) async {
    await repo.dropitemss(token).then((value) {
      if (value.isNotEmpty) {
        if (value["status"] == "1") {
          setState(() {
            itemList = value["data"];
          });
        }
      }
    });
  }

  void addmatreq(
      String project,
      String heading,
      String desc,
      String stff,
      String vndor,
      List itemarray,
      String token,
      String orderValue,
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
        .addmatreq(
            project, heading, desc, stff, vndor, itemarray, orderValue, token)
        .then((value) {
      Navigator.pop(context);
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
        NotificationService().showNotification(
            "Material Request", "Added Successfully", "", "", "");
      }
      Navigator.pop(context);
    });
  }

  void moneytranferAddd(empidd, paytype, amount, renrk, String token,
      BuildContext context) async {
    DialogBuilder(context).showLoadingDialog();
    await repo
        .addmoneytransfer(empidd, paytype, amount, renrk, token)
        .then((value) {
      if (value["status"] == "1") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        DialogBuilder(context).hideOpenDialog();
      }
      NotificationService().showNotification("Money Transfer",
          "Recorded SuccessFully", "1", "Money Transfer", "Money Transfer Add");
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  void updatematreqquset(vendor, status, id, token, context) async {
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

    await repo.updatematreq(vendor, status, id, token).then((value) {
      Navigator.pop(context);
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
            "Material Request", "Updated SuccessFully", "1", "", "");
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
      }
    });
  }

  void updtepurchseorder(puid, mode, token, context) async {
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

    await repo.updatepurchseorder(puid, mode, token).then((value) {
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
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
      }
    });
  }
}
