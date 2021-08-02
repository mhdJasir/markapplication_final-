import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/MatrialReqController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class AdMoneyTransferAddscreen extends StatefulWidget {
  final token;
  AdMoneyTransferAddscreen({this.token});
  @override
  _AdMoneyTransferAddscreenState createState() =>
      _AdMoneyTransferAddscreenState();
}

class _AdMoneyTransferAddscreenState
    extends StateMVC<AdMoneyTransferAddscreen> {
  MaterialControllr _con;

  _AdMoneyTransferAddscreenState() : super(MaterialControllr()) {
    _con = controller;
  }

  final TextEditingController remarkController = TextEditingController();

  final TextEditingController amountContrr = TextEditingController();
  var employe, pymnttype, empid;
  Widget _selectemploy(List employlist) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        height: 50,
        padding: EdgeInsets.only(
          right: 9,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: MyApp.border)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Text('Select Employee',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
                fontSize: 15),
            items: employlist.map(
              (itm) {
                return DropdownMenuItem<String>(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    child: new Text(
                      itm["empl_firstname"].toString(),
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  value: itm["id"].toString(),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  print(val);
                  employe = val;
                  print("STAFFFFFFF " + employe);
                },
              );
            },
            value: employe,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _con.getstaff(widget.token);
    print("AAAAAAAAA");
    super.initState();
  }

  Widget _paymenttype() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyApp.border)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              pymnttype == null ? 'Payment Type' : pymnttype,
              style: TextStyle(
                  color:
                      pymnttype == null ? Colors.grey[600] : Colors.grey[900],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.grey[600]),
          items: [
            'Cash',
            'Bank',
            'Cheque',
            'Rtgs/Neft',
          ].map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                pymnttype = val;
              },
            );
          },
        ),
      ),
    );
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
          "Add Money Transfer",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _selectemploy(_con.emppList),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: _paymenttype()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                controller: amountContrr,
                style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
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
                  hintText: "Amount",
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                controller: remarkController,
                style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
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
                  hintText: "Remark",
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _con.moneytranferAddd(employe, pymnttype, amountContrr.text,
                        remarkController.text, widget.token, context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6DC066),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.6,
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
    );
  }
}
