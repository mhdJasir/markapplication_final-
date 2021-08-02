import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';

import '../../../main.dart';

class AdDalyStatusInnerPage extends StatefulWidget {
  final dailystts;
  AdDalyStatusInnerPage({this.dailystts});

  @override
  _AdDalyStatusInnerPageState createState() => _AdDalyStatusInnerPageState();
}

class _AdDalyStatusInnerPageState extends State<AdDalyStatusInnerPage> {
  List<String> imgtolist;
  @override
  void initState() {
    convrttolist(widget.dailystts);
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
          "Daily Construction Report",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            margin: const EdgeInsets.only(
                top: 5.0, right: 9.0, left: 9.0, bottom: 5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyApp.border)),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.dailystts["project_name"].toString(),
                      style: b14W7),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.dailystts["emp_firstname"].toString(),
                    style: b14W7,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.dailystts["description"].toString(),
                      style: b14W7),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: imgtolist != null ? imgtolist.length : 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9, top: 5),
                    child: ClipRRect(
                      child: Image.network(
                        "http://markbuilders.in/admin/" +
                            imgtolist[index].toString(),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void convrttolist(dailystts) {
    var images = dailystts["image"].toString();
    imgtolist = images.split(',');
  }
}
