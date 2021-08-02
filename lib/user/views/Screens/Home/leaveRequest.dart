import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LeaveRequest extends StatefulWidget {
  final String token;
  LeaveRequest(this.token);
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends StateMVC<LeaveRequest> {
  UserHomeController _con;

  final DateFormat formatter = DateFormat('yyyy-MMM-dd');
  _LeaveRequestState() : super(UserHomeController()) {
    _con = controller;
  }
  TextEditingController noteController = TextEditingController();

  DateTime start;
  DateTime end;

  int totaldays;
  var startDate, endDate;
  String currentdate;
  Color main = Color(0xFFF6F6F6);
  Color textfield = Colors.grey[200];
  static const IconData calendar_today =
      IconData(0xe122, fontFamily: 'MaterialIcons');

  List<String> leaveType = ["Medical", "casual", "Loss Of Pay"];
  String _currentValue;
  Size get size => MediaQuery.of(context).size;
  TextEditingController cal1 = TextEditingController();
  TextEditingController cal2 = TextEditingController();
  @override
  void initState() {
    cal1.text = "";
    cal2.text = "";
    _currentValue = "Medical";
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
          "Apply For Leave",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            buildText("Leave Type"),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[50]),
                  color: Colors.white),
              height: 60,
              margin: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: FormField(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    baseStyle: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    isEmpty: _currentValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: leaveType.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            buildText("From Date"),
            buildTextFormField("", cal1, () {
              datePickStart();
            }, true, calendar_today),
            buildText("To Date"),
            buildTextFormField("", cal2, () {
              datePickEnd();
            }, true, calendar_today),
            buildText("Number Of Days"),
            buildTextFormField("", null, () {}, false, null),
            buildText("Remaining Leaves"),
            buildTextFormField("", null, () {}, false, null),
            buildText("Leave Reason"),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width - 50,
              height: 122,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: MyApp.border)),
              child: TextField(
                controller: noteController,
                textAlign: TextAlign.justify,
                maxLines: 9,
                style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                submitclick();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff6DC066),
                  borderRadius: BorderRadius.circular(22),
                ),
                height: 50,
                width: size.width * 0.6,
                child: Text(
                  "Submit",
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
      ),
    );
  }

  Widget buildText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 10),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Color(0xFF545454),
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(
    String text,
    TextEditingController controller,
    Function ontap,
    bool readonly,
    IconData icon,
  ) {
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: 10),
      height: 40,
      width: size.width * 0.85,
      child: TextFormField(
        readOnly: readonly,
        controller: controller,
        onTap: ontap,
        style: TextStyle(color: Colors.grey),
        validator: (value) {
          if (value.isEmpty) {
            return "";
          }
          return null;
        },
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                icon,
                color: Colors.grey[400],
              ),
              onPressed: () {},
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: textfield,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: textfield,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: textfield)),
            hintText: text,
            contentPadding: EdgeInsets.only(left: 15),
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: textfield))),
        cursorColor: textfield,
      ),
    );
  }

  submitclick() {
    if (totaldays < 0) {
      Fluttertoast.showToast(
        msg: "Invalid Date Range",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.black,
        fontSize: 16.0,
      );
    } else if (startDate == null ||
        endDate == null ||
        noteController.text.isEmpty ||
        totaldays == null) {
      Fluttertoast.showToast(
        msg: "Fill the Data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      showDialog(
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure to\n Submit Request ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[700],
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          print("cancel clicked");
                        },
                        //color: Color(0xff4a67b3),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        )),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          _con.addleave(
                              context,
                              _currentValue,
                              startDate.toString(),
                              endDate.toString(),
                              noteController.text,
                              totaldays,
                              widget.token);
                          Navigator.of(context).pop();
                        },
                        //color: Color(0xff4a67b3),
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        context: context,
      );
    }
  }

  datePickStart() async {
    {
      DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));

      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MMM-dd').format(pickedDate);
        print("formatted date  :" + formattedDate);
        setState(() {
          start = pickedDate;
          cal1.text = formattedDate;
          startDate = cal1.text;

          print("picked start date :" + pickedDate.toString());
          print("start date  : " + startDate);
        });
        print("start  :" + start.toString());
      } else {
        print("Date is not selected");
      }
    }
  }

  datePickEnd() async {
    {
      DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));

      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MMM-dd').format(pickedDate);
        print("formatted date  :" + formattedDate);
        setState(() {
          end = pickedDate;
          cal2.text = formattedDate;
          endDate = cal2.text;

          print("picked End date :" + pickedDate.toString());
          print("end date  : " + endDate);
        });
        gettotaldays(start, end);
        print(" end  :" + end.toString());
      } else {
        print("Date is not selected");
      }
    }
  }

  int gettotaldays(DateTime s, DateTime e) {
    int days = (e.difference(s).inDays);
    setState(() {
      totaldays = days;
    });
    print("total days  :" + totaldays.toString());
    return days;
  }
}
