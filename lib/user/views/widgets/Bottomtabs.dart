import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/views/Screens/Attendence/Attendence.dart';
import 'package:hrmarkgrp/user/views/Screens/DailyExpnse/DailyExpance.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/Home.dart';
import 'package:hrmarkgrp/user/views/Screens/MatralRqst/MatRqst.dart';

class Bottomtabs extends StatefulWidget {
  Bottomtabs({this.token});
  final String token;
  @override
  _BottomtabsState createState() => _BottomtabsState();
}

class _BottomtabsState extends State<Bottomtabs> {
  int _currentindex = 0;

  Widget _children(_currentindex) {
    switch (_currentindex) {
      case 0:
        return new Home(
          token: widget.token.toString(),
        );
        break;
      case 1:
        return new Attendence(
          tokn: widget.token,
        );
        break;
      case 2:
        return DailyExpnce(token: widget.token);
        break;
      case 3:
        return MatrlRqst(tok: widget.token);
        break;
      default:
        return new Home(
          token: widget.token.toString(),
        );
    }
  }

  void onTappedBar(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 10, left: 14),
        title: Image.asset(
          "assets/images/applogo.png",
          height: 50,
          alignment: Alignment.topLeft,
        ),
        titlePadding: EdgeInsets.all(10),
        content: new Text("Are you sure you want to exit?", style: f15),
        actions: <Widget>[
          MaterialButton(
              height: 28,
              color: Colors.white,
              child: new Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
          SizedBox(
            width: 15,
          ),
          MaterialButton(
              height: 28,
              color: Colors.white,
              child: new Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _children(_currentindex),
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTappedBar,
            currentIndex: _currentindex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon:
                    Image.asset("assets/icons/hme.png", width: 50, height: 40),
              ),
              BottomNavigationBarItem(
                label: "Attendence",
                icon: Image.asset(
                  "assets/icons/attndnce.png",
                  width: 50,
                  height: 40,
                ),
              ),
              BottomNavigationBarItem(
                label: "DailyExpnce",
                icon: Image.asset("assets/icons/dlyexp.png",
                    width: 50, height: 40),
              ),
              BottomNavigationBarItem(
                label: "MaterialRequire",
                icon: Image.asset("assets/icons/matreq.png",
                    width: 50, height: 40),
              ),
            ]),
      ),
    );
  }
}
