import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:hrmarkgrp/admin/views/widgets/Adbottomtabs.dart';
import 'package:hrmarkgrp/user/views/Screens/LoginScreen/login.dart';
import 'package:hrmarkgrp/user/views/widgets/Bottomtabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      getToken().then((value) {
        if (!value) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()));
        }
      });
    });
    super.initState();
  }

  Future<bool> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("tokenid") ?? "";
    if (token.isNotEmpty) {
      String userType = prefs.getString("user_type") ?? "";
      if (userType.isNotEmpty) {
        NetworkUtils.token = token;
        if (userType == "employee") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => Bottomtabs(
                        token: token,
                      )),
              (Route<dynamic> route) => false);
        } else if (userType == "admin") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => AdBottomtabs(token: token)),
              (Route<dynamic> route) => false);
        }
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/images/apicon.png",
            height: 250.0,
          ),
        ),
      ),
    );
  }
}
