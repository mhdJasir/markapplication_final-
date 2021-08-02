import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdClientAdd.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class AdClient extends StatefulWidget {
  final token;
  AdClient({this.token});
  @override
  _AdClientState createState() => _AdClientState();
}

class _AdClientState extends StateMVC<AdClient> {
  HomeController _con;

  _AdClientState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.viewclint(widget.token);
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
          "Clients",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount:
                      _con.viewclient != null ? _con.viewclient.length : 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 9, right: 9, top: 10),
                      child: Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: MyApp.border)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, right: 15, left: 15),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          "http://markbuilders.in/admin/" +
                                              _con.viewclient[index]["image"]
                                                  .toString(),
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            _con.viewclient[index]
                                                        ["lastname"] !=
                                                    null
                                                ? _con.viewclient[index]
                                                            ["firstname"]
                                                        .toString() +
                                                    " " +
                                                    _con.viewclient[index]
                                                            ["lastname"]
                                                        .toString()
                                                : "${_con.viewclient[index]["firstname"]}",
                                            style: w816),
                                        Text(
                                            _con.viewclient[index]["company"]
                                                .toString(),
                                            style: g612W5),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(_con.viewclient[index]["id"].toString(),
                                    style: b10W7),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdClientAdd(tok: widget.token)));
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
                        "Add Client",
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
