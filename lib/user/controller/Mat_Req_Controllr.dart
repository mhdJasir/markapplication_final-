import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:hrmarkgrp/user/Repository/Mat_Req_Repo.dart' as repo;
import 'package:mvc_pattern/mvc_pattern.dart';

class StaffMaterialReq extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  List projectlist = [];
  List itemList = [];
  var viewmaterialreqq = [];
  bool loading = true;
  StaffMaterialReq() {
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

  void getitms(token) async {
    await repo.dropitemss(token).then((value) {
      if (value["status"] == "1") {
        setState(() {
          itemList = value["data"];
        });
      }
    });
  }

  void stffaddmatreq(String project, String heading, String desc, List itemlist,
      String orderValue, String token, BuildContext context) async {
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
        .addstffmatreq(project, heading, desc, itemlist, orderValue, token)
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
          NotificationService().showNotification(
              "Material Request ",
              "Request Added Successfully",
              "1",
              "Material Request",
              "Material Request Add");
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
      }
    });
  }

  void stffgetmatreq(tokn) async {
    await repo.viewstffmatreq(tokn).then((value) {
      if (value["status"] == "1") {
        setState(() {
          loading = false;
          viewmaterialreqq = value["data"];
        });
      }
    });
  }
}
