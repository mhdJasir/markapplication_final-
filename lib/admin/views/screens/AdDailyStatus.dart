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
  List<String> menubarItems = ["Sort by Project", "Sort by Date"];

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
          "Daily Status",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: _con.loading == false
          ? Container(
              color: Color(0xFFF6F6F6),
              child: ListView.builder(
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              icon: Icon(
                                Icons.sort_outlined,
                                color: Colors.grey,
                              ),
                              onSelected: menubarAction,
                              itemBuilder: (BuildContext context) {
                                return menubarItems.map((String menubarItems) {
                                  return PopupMenuItem(
                                      value: menubarItems[0],
                                      child: Text(menubarItems));
                                }).toList();
                              },
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.only(
                              top: 5.0, right: 9.0, left: 9.0, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    _con.dailystaus[index]["project_name"]
                                        .toString(),
                                    style: b14W7),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  _con.dailystaus[index]["date"].toString(),
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 240,
                          margin: const EdgeInsets.only(
                              top: 5.0, right: 9.0, left: 9.0, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          "assets/images/men.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _con.dailystaus[index]["emp_firstname"]
                                          .toString(),
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "Job Category",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Assigned To", style: b14W7),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 215,
                                      height: 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: _con.dailystaus.length,
                                        itemBuilder: (context, i) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: Image.asset(
                                                    "assets/images/men.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                _con.dailystaus[i]["unemp_name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _con.dailystaus[index]["description"]
                                      .toString(),
                                  style: b14W7,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 3,
                                      itemBuilder: (context, i) {
                                        return Row(children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                "assets/images/men.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ]);
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void menubarAction(String menubaritems) {
    if (menubaritems == menubaritems) {}
  }
}
