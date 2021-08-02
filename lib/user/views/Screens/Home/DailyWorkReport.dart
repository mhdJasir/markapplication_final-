import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/AddDailyWorkReport.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DailyWorkReport extends StatefulWidget {
  final tok;
  DailyWorkReport({this.tok});
  @override
  _DailyWorkReportState createState() => _DailyWorkReportState();
}

class _DailyWorkReportState extends StateMVC<DailyWorkReport> {
  DailyController _con;

  _DailyWorkReportState() : super(DailyController()) {
    _con = controller;
  }
  Size get size => MediaQuery.of(context).size;
  Color main = Color(0xFFF6F6F6);
  @override
  void initState() {
    _con.dailytaskviewww(widget.tok);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF545454),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Daily Work Report",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: ListView(children: [
        Container(
          height: size.height * 0.78,
          child: ListView.builder(
            itemCount: _con.dilytaskview != null ? _con.dilytaskview.length : 0,
            itemBuilder: (context, index) {
              var parsedDate = DateTime.parse(
                  _con.dilytaskview[index]["created_at"].toString());
              String date = new DateFormat("yyyy-MM-dd").format(parsedDate);
              return GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdMatrlReqInnr(_con.getmaterialreqq[index],widget.tok)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFFE9E9E9))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff496ab1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _con.dilytaskview[index]["project_name"].toString(),
                            style: b14W7,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _con.dilytaskview[index]["remark"].toString(),
                            style: b14W7,
                          ),
                          Container(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Colors.blue),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddWorkReport(token: widget.tok)));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff6DC066),
                  borderRadius: BorderRadius.circular(60),
                ),
                height: 50,
                width: size.width * 0.6,
                child: Text(
                  "Add Report",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
