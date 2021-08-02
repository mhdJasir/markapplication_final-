import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdDailysttsInnerPage.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

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
    print("daily status data  :" + _con.dailystaus.toString());
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
          "Daily Status",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
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
                              top: 5.0, right: 20, left: 20, bottom: 5),
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: MyApp.border),
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
                          height: 200,
                          margin: const EdgeInsets.only(
                              top: 5.0, right: 20, left: 20, bottom: 5),
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: MyApp.border),
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
                                      width: 5,
                                    ),
                                    Text(
                                      _con.dailystaus[index]["emp_firstname"]
                                          .toString(),
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
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
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text("Assigned To", style: b14W7),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Flexible(
                                      child: Container(
                                        height: 40,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: _con.dailystaus.length,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              children: [
                                                SizedBox(
                                                  width: 3,
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
                                                  width: 3,
                                                ),
                                                Text(
                                                  _con.dailystaus[i]
                                                          ["unemp_name"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _con.dailystaus[index]["description"]
                                      .toString(),
                                  style: b14W7,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 40,
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
