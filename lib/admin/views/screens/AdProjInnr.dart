import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';

class AdProjInnr extends StatefulWidget {
  final ind;
  AdProjInnr({this.ind});
  @override
  _AdProjInnrState createState() => _AdProjInnrState();
}

class _AdProjInnrState extends State<AdProjInnr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.ind == 1 ? "Project Name" : "Grase Villa No.2",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            margin: const EdgeInsets.only(
                top: 10.0, right: 9.0, left: 9.0, bottom: 5),
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
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.ind == 1 ? "Project Name" : "Grase Villa No.2",
                      style: b14W7),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.ind == 1 ? "Client Name" : "Muhammed Prageen",
                    style: b14W7,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.ind == 1 ? "Start Date" : "10/01/2021",
                          style: b14W7),
                      Text(widget.ind == 1 ? "End Date" : "10/03/2021",
                          style: b14W7),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.ind == 1 ? "Project Cost" : "152,000/-",
                    style: b14W7,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.only(
                top: 10.0, right: 9.0, left: 9.0, bottom: 5),
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
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, right: 15, left: 15),
              child: Text(
                "Material Purchase",
                style: b14W7,
              ),
            ),
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.only(
                top: 10.0, right: 9.0, left: 9.0, bottom: 5),
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
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, right: 15, left: 15),
              child: Text(
                "Invoice",
                style: b14W7,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff496ab1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, bottom: 30, right: 2, left: 2),
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                index == 0
                                    ? "assets/images/im1.jpg"
                                    : index == 1
                                        ? "assets/images/y.jpg"
                                        : "assets/images/z.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      context: context,
                    );
                    print(index == 1 ? "iccccccccccc" : "zzzzzzzz");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9.0, bottom: 10),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Image.asset(
                          index == 0
                              ? "assets/images/im1.jpg"
                              : index == 1
                                  ? "assets/images/y.jpg"
                                  : "assets/images/z.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
