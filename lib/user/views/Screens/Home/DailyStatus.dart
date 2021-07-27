import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/screens/AdProjInnr.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/DailystatusAdd.dart';
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
  @override
  void initState() {
    print("aaaaaaaaaa");
    _con.staffdailystats(widget.token, context);
    // TODO: implement initState
    super.initState();
  }

  Size get size => MediaQuery.of(context).size;
  Color main = Color(0xFFF6F6F6);
  Color textfield = Colors.grey[200];
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
        backgroundColor: main,
      ),
      body: _con.loading == false
          ? Column(
              children: [
                Container(
                  height: 590,
                  child: ListView.builder(
                    itemCount: _con.staffdailystatus != null
                        ? _con.staffdailystatus.length
                        : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdProjInnr(ind: index)));
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            height: 100,
                            width: size.width - 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[200])),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, left: 16, right: 16),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            _con.staffdailystatus[index]
                                                    ["project_name"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            )),
                                        Text(
                                            _con.staffdailystatus[index]
                                                ["date"],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                      ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        _con.staffdailystatus[index]
                                                ["unemp_name"]
                                            .toString(),
                                        style: b14W7,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        _con.staffdailystatus[index]
                                                ["description"]
                                            .toString(),
                                        style: b14W7,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
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
                      borderRadius: BorderRadius.circular(22),
                    ),
                    height: 50,
                    width: size.width * 0.6,
                    child: Text(
                      "Add Status",
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
