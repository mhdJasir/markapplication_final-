import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:intl/intl.dart';

class MoneyOnHandInnr extends StatefulWidget {
  final tok, datas;
  MoneyOnHandInnr({this.tok, this.datas});
  @override
  _MoneyOnHandInnrState createState() => _MoneyOnHandInnrState();
}

class _MoneyOnHandInnrState extends State<MoneyOnHandInnr> {
  var expense = [];
  @override
  void initState() {
    setState(() {
      expense = widget.datas["expenses"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Money Onhand innr",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff496ab1),
        ),
        body: ListView.builder(
          itemCount: expense.length != 0 ? expense.length : 0,
          itemBuilder: (context, index) {
            var parsedDate = DateTime.parse(expense[index]["date"].toString());
            String date = new DateFormat("yyyy-MM-dd").format(parsedDate);
            return Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
              child: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(date, style: b14W7),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expense[index]["project_name"].toString(),
                            style: b14W7,
                          ),
                          Text(
                            expense[index]["amount"].toString() + "/-",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff496ab1)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        expense[index]["remark"].toString(),
                        style: b14W7,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        expense[index]["emp_id"].toString(),
                        style: b14W7,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
