import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdDailysttsInnerPage.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdDalyStatus extends StatefulWidget {
  final token;
  AdDalyStatus({this.token});
  @override
  _AdDalyStatusState createState() => _AdDalyStatusState();
}

class _AdDalyStatusState extends StateMVC<AdDalyStatus> {
  HomeController _con;
  _AdDalyStatusState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.dailystatus(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Work Status",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: _con.loading == false
          ? ListView.builder(
              itemCount: _con.dailystaus != null ? _con.dailystaus.length : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdDalyStatusInnerPage(
                                dailystts: _con.dailystaus[index])));
                  },
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.only(
                        top: 5.0, right: 9.0, left: 9.0, bottom: 5),
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
                          top: 3, bottom: 3, right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              _con.dailystaus[index]["project_name"].toString(),
                              style: b14W7),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _con.dailystaus[index]["emp_firstname"].toString(),
                            style: b14W7,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              List.castFrom(
                                      _con.dailystaus[index]["unemployee"])
                                  .join(','),
                              style: b14W7),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _con.dailystaus[index]["description"].toString(),
                            style: b14W7,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _con.dailystaus[index]["date"].toString(),
                            style: b14W7,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
