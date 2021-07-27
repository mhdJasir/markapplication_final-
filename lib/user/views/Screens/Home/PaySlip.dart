import 'package:flutter/material.dart';

class PaySlip extends StatefulWidget {
  @override
  _PaySlipState createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {
  String dropdownValue = '2021';
  _dropdownyear() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: 30,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Color(0xff98bcf8), borderRadius: BorderRadius.circular(10)),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff98bcf8),
          ),
          child: DropdownButton<String>(
            iconEnabledColor: Colors.white,
            value: dropdownValue,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>[
              '2020',
              '2021',
              '2022',
              '2023',
              '2024',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jly',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  var a = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      appBar: AppBar(
          centerTitle: true,
          title: Text("Payslip"),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color(0xff4a67b3)),
          ),
          elevation: 0),
      body: Container(
        color: Colors.grey[400],
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xff4a67b3),
              height: 150,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _dropdownyear(),
                      Expanded(
                          child: Center(
                        child: Container(
                          height: 41,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: months.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 5),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          a = true;
                                        });
                                      },
                                      child: Text(months[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15))),
                                );
                              }),
                        ),
                      ))

                      // _horizontalmonth(),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "\u20b91,350",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 26),
                          children: <TextSpan>[
                        TextSpan(
                            text: " in Total",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))
                      ]))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 120, left: 20, right: 20, bottom: 85),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 25, left: 25, top: 30, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 17),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Salary:",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "\u20b9 1,000",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.blue),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Leave Didaction:",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ \u20b9150",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.greenAccent[200]),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Advance Salary:",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ \u20b922,200",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.greenAccent[200]),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(11),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xff4a67b3)),
                    child: Center(
                      child: Text(
                        "Download Payslip",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
