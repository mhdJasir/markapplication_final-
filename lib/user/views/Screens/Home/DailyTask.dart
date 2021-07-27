import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/AddDailyTask.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DailyTask extends StatefulWidget {
  final tok;
  DailyTask({this.tok});
  @override
  _DailyTaskState createState() => _DailyTaskState();
}

class _DailyTaskState extends StateMVC<DailyTask> {
  DailyController _con;

  _DailyTaskState() : super(DailyController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.dailytaskviewww(widget.tok);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Activities",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: ListView.builder(
        itemCount: _con.dilytaskview != null ? _con.dilytaskview.length : 0,
        itemBuilder: (context, index) {
          var parsedDate =
              DateTime.parse(_con.dilytaskview[index]["created_at"].toString());
          String date = new DateFormat("yyyy-MM-dd").format(parsedDate);
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdMatrlReqInnr(_con.getmaterialreqq[index],widget.tok)));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 0.8, // soften the shadow
                      spreadRadius: 0.8, //extend the shadow
                      offset: Offset(
                        0.5, // Move to right 10  horizontally
                        0.5, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, right: 15, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _con.dilytaskview[index]["project_name"].toString(),
                            style: b14W7,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff496ab1)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _con.dilytaskview[index]["remark"].toString(),
                        style: b14W7,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff496ab1),
          child: Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Addailytask(token: widget.tok)));
          }),
    );
  }
}
