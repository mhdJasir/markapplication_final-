import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:hrmarkgrp/admin/views/screens/AdConstructionReportInner.dart';
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
          "Daily Construction Report",
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
                  top: 5.0, right: 20, left: 20, bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: MyApp.bord),
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
                  top: 5.0, right: 20.0, left: 20.0, bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: MyApp.bord),
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
                          width: size.width * 0.55,
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:
                                List.castFrom(dailyStatus[index]["unemployee"])
                                    .length,
                            itemBuilder: (context, i) {
                              var length = List.castFrom(
                                      dailyStatus[index]["unemployee"])
                                  .length;
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    dailyStatus[index]["unemployee"][i]
                                        .toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  length - 1 > i
                                      ? Text(
                                          ", ",
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      : Container(),
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
                      dailyStatus[index]["description"].toString(),
                      style: b14W7,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ImageView(
                              src:
                                  "http://markbuilders.in/admin/${dailyStatus[index]["image"]}");
                        }));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            "http://markbuilders.in/admin/${dailyStatus[index]["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    }
    if (lazyloading) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ));
    }
    return list;
  }

  void menubarAction(String menubaritems) {
    if (menubaritems == menubaritems) {}
  }

  Future getDailyStatus() async {
    var api = NetworkUtils.dailysta + "?page=$nextpage";
    var res = await NetworkUtils.httpget(api);
    print("status code   :" + res.statusCode.toString());
    if (res?.statusCode == 200) {
      var jsObj = jsonDecode(res.body);
      if (jsObj["status"] == "1") {
        var data = List.castFrom(jsObj["data"]["data"]);
        setState(() {
          if (nextpage == 1) {
            dailyStatus = data;
            print("daily status :" + jsObj["data"].toString());
          } else {
            for (var i = 0; i < data.length; i++) {
              dailyStatus.add(data[i]);
            }
          }
          if (jsObj["data"]["next_page_url"] != null) {
            nextpage = jsObj["data"]["last_page"];
          } else {
            nextpage = null;
          }
          loading = false;
          lazyloading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
