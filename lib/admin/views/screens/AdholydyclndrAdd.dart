import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:hrmarkgrp/admin/controller/CalnderController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class AdholydyclndrAdd extends StatefulWidget {
  @override
  _AdholydyclndrAddState createState() => _AdholydyclndrAddState();
}

class _AdholydyclndrAddState extends StateMVC<AdholydyclndrAdd> {
  CalendersControllr _con;

  _AdholydyclndrAddState() : super(CalendersControllr()) {
    _con = controller;
  }
  DateTime _currentDate;
  String finalDate = '';
  var yearrr;
  String fdate;
  final TextEditingController rmrkcont = TextEditingController();
  Validations validations = new Validations();
  final DateFormat month = DateFormat('MMMM');
  final DateFormat yearformt = DateFormat('y');
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  getCurrentDate() {
    final DateTime now = DateTime.now();
    fdate = formatter.format(now);
    setState(() {
      finalDate = month.format(now);
      yearrr = now.year;
    });
  }

  Widget calndrwidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
          //
          setState(() {
            fdate = _currentDate.toString();
          });
          //var datttt = formatter.format(DateTime.parse(fdate));
          setState(() {
            finalDate = month.format(DateTime.parse(fdate));
            yearrr = yearformt.format(DateTime.parse(fdate));
          });
        },
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        // markedDatesMap: _markedDateMap,
        height: 300.0,

        selectedDateTime: _currentDate,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  @override
  void initState() {
    getCurrentDate();
    super.initState();
  }

  submit() async {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
    } else {
      form.save();
      // _uploadImage(_image);
      _con.addviewholyclndr(rmrkcont.text, fdate, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
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
          "Add New Holiday",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _con.loginFormKey,
            child: Column(
              children: <Widget>[
                Theme(
                  data: theme,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: ExpansionTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            finalDate,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            yearrr.toString(),
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      children: <Widget>[calndrwidget()],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Container(
                    height: 70,
                    child: TextFormField(
                      validator: validations.validateLogin,
                      controller: rmrkcont,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyApp.border),
                            borderRadius: BorderRadius.circular(15)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyApp.border),
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyApp.border),
                            borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyApp.border),
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        hintText: "Remark",
                        hintStyle: g615W5,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        submit();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff6DC066),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.65,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
