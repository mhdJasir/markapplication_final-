import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:hrmarkgrp/admin/views/screens/AdDailysttsInnerPage.dart';
import 'package:hrmarkgrp/admin/views/screens/ImageView.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class AdDalyStatus extends StatefulWidget {
  @override
  _AdDalyStatusState createState() => _AdDalyStatusState();
}

class _AdDalyStatusState extends StateMVC<AdDalyStatus> {
  List<String> menubarItems = ["Sort by Project", "Sort by Date"];
  ScrollController _scrollController = ScrollController();
  bool lazyloading = false;
  List dailyStatus = [];
  bool loading = true;
  int nextpage = 1;
  @override
  void initState() {
    getDailyStatus();
    _scrollController.addListener(() {
      if (nextpage != null) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!lazyloading) {
            setState(() {
              lazyloading = true;
            });
            getDailyStatus();
          }
        }
      }
    });
    _con.dailystatus(widget.token);
    print("daily status data  :" + _con.dailystaus.toString());
    super.initState();
  }

  Size get size => MediaQuery.of(context).size;

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
      body: !loading
          ? Container(
              color: Color(0xFFF6F6F6),
              child: ListView(
                controller: _scrollController,
                children: _allProjectlist(),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  List<Widget> _allProjectlist() {
    List<Widget> list = [];
    list.add(Row(
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
                  value: menubarItems[0], child: Text(menubarItems));
            }).toList();
          },
        )
      ],
    ));
    for (var index = 0; index < dailyStatus.length; index++) {
      list.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AdDalyStatusInnerPage(dailystts: dailyStatus[index])));
        },
        child: Column(
          children: [
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
                    child: Text(dailyStatus[index]["project_name"].toString(),
                        style: b14W7),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      dailyStatus[index]["date"].toString(),
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
                            child: Image.network(
                              "http://markbuilders.in/admin/${dailyStatus[index]["emp_image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          dailyStatus[index]["emp_firstname"].toString(),
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
                        Text("Assigned To :", style: b14W7),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                                  ],
                                SizedBox(
                                  height: 5,
                                SizedBox(
                                  height: 5,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 3,
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
                                                      "assets/images/men.jpg",
                                                    ),
                                                ),
                                                  width: 3,
                                                Text(
                                                          ["unemp_name"]
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                          },
                                        ),
                                    ),
                                  ],
                                SizedBox(
                                  height: 5,
                                Text(
                                  _con.dailystaus[index]["description"]
                                  style: b14W7,
                                  maxLines: 1,
                                SizedBox(
                                  height: 5,
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
                    //                 fit: BoxFit.cover,
                    //             ),
                    //           SizedBox(
                    //           ),
                    //       }),
                  ],
              ),
          ],
      ));
    if (lazyloading) {
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    return list;

    if (menubaritems == menubaritems) {}

    var api = NetworkUtils.dailysta + "?page=$nextpage";
    if (res?.statusCode == 200) {
      if (jsObj["status"] == "1") {
        setState(() {
            dailyStatus = data;
            for (var i = 0; i < data.length; i++) {
            }
          if (jsObj["data"]["next_page_url"] != null) {
          } else {
          }
          lazyloading = false;
      }
      setState(() {
      });
    }
  }
}
