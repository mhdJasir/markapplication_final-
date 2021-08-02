import 'package:flutter/material.dart';

class RequirementsDetails extends StatefulWidget {
  const RequirementsDetails({Key key}) : super(key: key);

  @override
  _RequirementsDetailsState createState() => _RequirementsDetailsState();
}

class _RequirementsDetailsState extends State<RequirementsDetails> {
  Color main = Color(0xFFF6F6F6);
  Size get size => MediaQuery.of(context).size;
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
          "Material Requirements",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: size.width - 40,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildText("Materials", Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      buildText("Qty", Colors.black),
                      buildText("Basic Amount", Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
              width: size.width - 40,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          right: 20, top: 10, bottom: 10, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildText("Materials", Colors.black),
                          buildText("5", Colors.black),
                          buildText("Materials", Colors.black),
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: size.width - 40,
                  decoration: BoxDecoration(color: Color(0xFFFF1C9321)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildText("Total", Colors.white),
                      buildText("800", Colors.white),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildText(text, color) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
