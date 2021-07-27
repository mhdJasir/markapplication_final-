import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdClientAdd.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
        title: Text(
          "Clients",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? ListView.builder(
              itemCount: _con.viewclient != null ? _con.viewclient.length : 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 9, right: 9, top: 10),
                  child: Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        _con.viewclient[index]["lastname"] !=
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
                    builder: (context) => AdClientAdd(tok: widget.token)));
            print("flaoa");
          }),
    );
  }
}
