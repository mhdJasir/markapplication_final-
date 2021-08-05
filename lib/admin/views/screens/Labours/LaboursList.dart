import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/Labours/AddLabour.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../main.dart';

class Labours extends StatefulWidget {
  String token;
  Labours(this.token);
  @override
  _LaboursState createState() => _LaboursState();
}

class _LaboursState extends StateMVC<Labours> {
  HomeController _con;

  _LaboursState() : super(HomeController()) {
    _con = controller;
  }
  var data;
  getData() async {
    await _con.laboursApi(widget.token);
    data = _con.labours;
    print("dta  :" + data.toString());
  }

  @override
  void initState() {
    getData();
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
          "Labours",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width - 40,
                  child: ListView.builder(
                    itemCount: data != null ? data.length : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: MyApp.bord,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, right: 15, left: 15),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          data[index]["emp_lastname"] != null
                                              ? data[index]["emp_firstname"]
                                                      .toString() +
                                                  " " +
                                                  data[index]["emp_lastname"]
                                                      .toString()
                                              : data[index]["emp_firstname"]
                                                  .toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Text(data[index]["id"].toString(),
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
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
                                    AddLabours(widget.token)));
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
                          "Add Labour",
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
              ],
            ),
    );
  }
}
