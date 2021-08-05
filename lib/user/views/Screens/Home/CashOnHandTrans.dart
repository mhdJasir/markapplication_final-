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

  Size get size => MediaQuery.of(context).size;
  Color main = Color(0xFFF6F6F6);
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
            "Cash Transactions",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: main,
        ),
        body: ListView.builder(
          itemCount: expense.length != 0 ? expense.length : 0,
          itemBuilder: (context, index) {
            var parsedDate = DateTime.parse(expense[index]["date"].toString());
            String date = new DateFormat("yyyy-MM-dd").format(parsedDate);
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  expense[index]["project_name"].toString(),
                                  style: b14W7,
                                ),
                                Text(date, style: b14W7),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  expense[index]["amount"].toString() + "/-",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff496ab1)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width - 40,
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
