import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:flutter/src/widgets/framework.dart'as p;
// import 'package:mvc_pattern/mvc_pattern.dart'as p;
import 'package:hrmarkgrp/user/Repository/MoneyOnHand_Repo.dart' as repo;

class MoneyOnHndConroller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;

  var viewmoneyOnhand = [];
  bool isloading = false;
  MoneyOnHndConroller() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void moneyOnhndview(token, context) async {
    await repo.viewmoneyonhand(token).then((value) {
      setState(() {
        isloading = true;
      });
      // Navigator.pop(context);
      if (value["status"] == "1") {
        setState(() {
          viewmoneyOnhand = value["data"];
        });
      }
    });
  }
}
