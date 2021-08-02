import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/DailyConstructionReport/DailystatusAdd.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/DailyConstructionReport/EditReport.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DailyStatus extends StatefulWidget {
  final token;
  DailyStatus({this.token});
  @override
  _DailyStatusState createState() => _DailyStatusState();
}

class _DailyStatusState extends StateMVC<DailyStatus> {
  UserHomeController _con;
  _DailyStatusState() : super(UserHomeController()) {
    _con = controller;
  }
  List<String> menubarItems = ["Sort by Project", "Sort by Date"];
  Color main = Color(0xFFF6F6F6);
  @override
  void initState() {
    _con.staffdailystats(widget.token, context);
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
          "Daily Construction report",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: _con.loading == false
          ? Container(
              color: Color(0xFFF6F6F6),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.81,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: _con.staffdailystatus != null
                          ? _con.staffdailystatus.length
                          : 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(
                                  top: 5.0, right: 9.0, left: 9.0, bottom: 5),
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: MyApp.border)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                        _con.staffdailystatus[index]
                                                ["project_name"]
                                            .toString(),
                                        style: b14W7),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text(
                                      _con.staffdailystatus[index]["date"]
                                          .toString(),
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print("daaaaata  :" +
                                //     _con.staffdailystatus.toString());
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ConstructionReportEdit();
                                }));
                              },
                              child: Container(
                                height: 200,
                                margin: const EdgeInsets.only(
                                    top: 5.0, right: 9.0, left: 9.0, bottom: 5),
                                width: MediaQuery.of(context).size.width - 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: MyApp.border)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: Image.network(
                                                _con.staffdailystatus[index]
                                                        ["emp_image"]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            _con.staffdailystatus[index]
                                                    ["emp_firstname"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black45),
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
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: _con
                                                    .staffdailystatus.length,
                                                itemBuilder: (context, i) {
                                                  return Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: Image.network(
                                                            _con.staffdailystatus[
                                                                i]["image"],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        _con.staffdailystatus[i]
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
                                        _con.staffdailystatus[index]
                                                ["description"]
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
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DailyStatusAdd(token: widget.token)));
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}