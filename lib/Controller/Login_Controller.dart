import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:hrmarkgrp/admin/views/widgets/Adbottomtabs.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/views/widgets/Bottomtabs.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hrmarkgrp/Repo/LoginRepo.dart' as repo;
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginControllr extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  var logindatas;
  LoginControllr() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void setTokenId(tokenid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenid', tokenid);
  }

  void setProfiledetails(List profiledetils, String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (profiledetils.length != 0) {
      var empfirstname = profiledetils[0]["emp_firstname"].toString();
      var emplastname = profiledetils[0]["emp_lastname"].toString();
      var empimg = profiledetils[0]["emp_image"].toString();
      var empdesignatn = profiledetils[0]["des_name"].toString();

      prefs.setString('empfirstname', empfirstname);
      prefs.setString('emplastname', emplastname);
      prefs.setString('empimag', empimg);
      prefs.setString('empdesignation', empdesignatn);
    }
    prefs.setString('user_type', userType);
  }

  void signIn(phone, password, context) async {
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
    String deviceId = await PlatformDeviceId.getDeviceId;
    print("device id  : " + deviceId.toString());
    repo.signIn(phone, password, deviceId).then((value) {
      setState(() {
        logindatas = value;
        NetworkUtils.token = logindatas["data"]["token"];
      });
      var profileData = List.castFrom(logindatas["data"]["user_profile"]);
      setTokenId(logindatas["data"]["token"]);
      setProfiledetails(
        profileData,
        logindatas["data"]["user_type"],
      );

      if (logindatas["status"] == "1" &&
          logindatas["data"]["user_type"] == "employee") {
        Fluttertoast.showToast(
          msg: logindatas["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Bottomtabs(
                      token: logindatas["data"]["token"],
                    )),
            (Route<dynamic> route) => false);
      } else if (logindatas["status"] == "1" &&
          logindatas["data"]["user_type"] == "admin") {
        Fluttertoast.showToast(
          msg: logindatas["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    AdBottomtabs(token: logindatas["data"]["token"])),
            (Route<dynamic> route) => false);
      } else if (logindatas["status"] == "0") {
        Fluttertoast.showToast(
          msg: logindatas["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: logindatas["message"],
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
}
