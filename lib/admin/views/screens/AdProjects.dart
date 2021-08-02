import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdProjInnr.dart';
import 'package:hrmarkgrp/admin/views/screens/AdProjctAdd.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
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
          "Projects",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: _con.loading == false
          ? ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount:
                      _con.viewprojct != null ? _con.viewprojct.length : 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdProjInnr(ind: index)));
                      },
                      child: Container(
                        height: 130,
                        margin: const EdgeInsets.only(
                            top: 10.0, right: 20, left: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: MyApp.bord),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  _con.viewprojct[index]["project_name"]
                                      .toString(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      _con.viewprojct[index]["start_day"]
                                          .toString(),
                                      style: b14W7),
                                  Text(
                                      _con.viewprojct[index]["end_day"]
                                          .toString(),
                                      style: b14W7),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5,
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
                                  AdProjAdd(token: widget.tokn)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff6DC066),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "Add Projects",
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
            ])
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
