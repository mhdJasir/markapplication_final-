import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Addailytask extends StatefulWidget {
  final token;
  Addailytask({this.token});
  @override
  _AddailytaskState createState() => _AddailytaskState();
}

class _AddailytaskState extends StateMVC<Addailytask> {
  DailyController _con;

  _AddailytaskState() : super(DailyController()) {
    _con = controller;
  }

  String project;
  TextEditingController remarkcontr = TextEditingController();
  _currentdate() {
    var now = new DateTime.now();
    print(now);
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;
  }

  Widget _projectss(List projct) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey[400]),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              'Projects',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(
              color: Colors.grey[900],
              fontSize: 15,
              fontWeight: FontWeight.w500),
          items: projct.map(
            (item) {
              return DropdownMenuItem<String>(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: new Text(
                    item["project_name"].toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: item["id"].toString(),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                project = val;
              },
            );
          },
          value: project,
        ),
      ),
    );
  }

  @override
  void initState() {
    _con.getproject(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add DailyTask",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 42,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      _currentdate(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: _projectss(_con.projectlist),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[400]),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: remarkcontr,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      hintText: "Today Work Details",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: GestureDetector(
                onTap: () {
                  _con.adddailytask(project, remarkcontr.text, context);
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  padding: EdgeInsets.all(11),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff4a67b3)),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
