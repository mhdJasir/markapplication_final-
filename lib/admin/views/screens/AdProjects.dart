import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdProjInnr.dart';
import 'package:hrmarkgrp/admin/views/screens/AdProjctAdd.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdProjects extends StatefulWidget {
  final tokn;
  AdProjects({this.tokn});
  @override
  _AdProjectsState createState() => _AdProjectsState();
}

class _AdProjectsState extends StateMVC<AdProjects> {
  HomeController _con;
  _AdProjectsState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.viwprojct(widget.tokn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Projects",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: _con.loading == false
          ? ListView.builder(
              itemCount: _con.viewprojct != null ? _con.viewprojct.length : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdProjInnr(ind: index)));
                  },
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.only(
                        top: 10.0, right: 9.0, left: 9.0, bottom: 5),
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
                          Text(
                              _con.viewprojct[index]["project_name"].toString(),
                              style: b14W7),
                          SizedBox(
                            height: 10,
                          ),
                          _con.viewprojct[index]["lastname"] != null
                              ? Text(
                                  _con.viewprojct[index]["firstname"]
                                          .toString() +
                                      " " +
                                      _con.viewprojct[index]["lastname"]
                                          .toString(),
                                  style: b14W7,
                                )
                              : Text(
                                  _con.viewprojct[index]["firstname"],
                                  style: b14W7,
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _con.viewprojct[index]["rate"].toString(),
                                style: b14W7,
                              ),
                              //Text(index == 1 ? "Advance" : "", style: b14W7),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  _con.viewprojct[index]["start_day"]
                                      .toString(),
                                  style: b14W7),
                              Text(_con.viewprojct[index]["end_day"].toString(),
                                  style: b14W7),
                            ],
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
                    builder: (context) => AdProjAdd(token: widget.tokn)));
          }),
    );
  }
}
