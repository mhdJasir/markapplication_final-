// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AdNotificattionpage extends StatefulWidget {
  @override
  _AdNotificattionpageState createState() => _AdNotificattionpageState();
}

class _AdNotificattionpageState extends State<AdNotificattionpage> {
  SlidableController _slidableController1 = SlidableController();
  SlidableController _slidableController2 = SlidableController();
  List tdylist = [];
  List<String> ystrdylist = [
    "Your vacation leave has been rejected",
    "There'll be a meeting at 4 p.m.so be prepared",
    "Your vacation leave has been rejected",
    "There'll be a meeting at 1 p.m.so be prepared",
    "Your vacation leave has been rejected",
    "Your vacation leave has been rejected",
    "There'll be a meeting at 1 p.m.so be prepared"
  ];

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    //   _firebaseMessaging.configure(
    //     onMessage: (message) async {
    //       setState(() {
    //         tdylist.insert(0, message["notification"]["title"]);
    //       });
    //     },
    //     onResume: (message) async {
    //       setState(() {
    //         tdylist.insert(0, message["data"]["title"]);
    //       });
    //     },
    //   );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          tdylist.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 9, top: 10),
                  child: Text(
                    "Today",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  ),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          tdylist.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: tdylist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 10),
                        child: Slidable(
                          key: Key(tdylist[index]),
                          controller: _slidableController1,
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.10,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  right: 10, left: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(3),
                                    topRight: Radius.circular(3),
                                    topLeft: Radius.circular(3),
                                    bottomRight: Radius.circular(3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 1.5, // soften the shadow
                                    spreadRadius: 0.3, //extend the shadow
                                    offset: Offset(
                                      0.3, // Move to right 10  horizontally
                                      0.3, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tdylist[index].toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "11.24",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                                color: Colors.red,
                                icon: Icons.close,
                                onTap: () {
                                  _showSnackBar(context, "Item Delete");
                                  print("dlt");
                                  setState(() {
                                    tdylist.removeAt(index);
                                  });
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          ystrdylist.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 9, top: 10),
                  child: Text(
                    "Yesterday",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          ystrdylist.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: ystrdylist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 10,
                          ),
                          child: Slidable(
                            controller: _slidableController2,
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.10,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    right: 10, left: 20, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(3),
                                      topRight: Radius.circular(3),
                                      topLeft: Radius.circular(3),
                                      bottomRight: Radius.circular(3)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[400],
                                      blurRadius: 1.5, // soften the shadow
                                      spreadRadius: 0.3, //extend the shadow
                                      offset: Offset(
                                        0.3, // Move to right 10  horizontally
                                        0.3, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ystrdylist[index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "10.34",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )),
                            secondaryActions: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(55),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[400],
                                      blurRadius: 1.5, // soften the shadow
                                      spreadRadius: 0.3, //extend the shadow
                                      offset: Offset(
                                        0.3, // Move to right 10  horizontally
                                        0.3, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: IconSlideAction(
                                  color: Colors.red,
                                  icon: Icons.close,
                                  onTap: () {
                                    _showSnackBar(context, "Item Delete");
                                    print("dlt");
                                    setState(() {
                                      ystrdylist.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }))
              : Container()
        ],
      ),
    );
  }
}
