import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';

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
        title: Text(
          "Daily Work Status",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
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
