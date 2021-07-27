import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Controller/Login_Controller.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  LoginControllr _con;

  _LoginScreenState() : super(LoginControllr()) {
    _con = controller;
  }
  TextEditingController _passwrodcontroller = TextEditingController();
  TextEditingController _phoncontrller = TextEditingController();
  Validations validations = new Validations();
  bool autovalidate = false;

  Widget _password() {
    return Padding(
      padding: const EdgeInsets.only(right: 9, left: 9),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.text,
        validator: validations.validatePassword,
        controller: _passwrodcontroller,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  submit() async {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true;
    } else {
      form.save();
      _con.signIn(_phoncontrller.text, _passwrodcontroller.text, context);
    }
  }

  Widget _loginbtn() {
    return GestureDetector(
      onTap: () {
        submit();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 9, left: 9),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          decoration: BoxDecoration(
              color: Color(0xff4a67b3),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(1.0, 1.0),
                    spreadRadius: 1.3,
                    blurRadius: 2.5,
                    color: Colors.grey[300])
              ]),
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobilefield() {
    return Padding(
      padding: const EdgeInsets.only(right: 9, left: 9),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: validations.validateMobile,
        controller: _phoncontrller,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/lgbg.png",
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _mobilefield(),
                      SizedBox(
                        height: 20,
                      ),
                      _password(),
                      SizedBox(
                        height: 40,
                      ),
                      _loginbtn(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
