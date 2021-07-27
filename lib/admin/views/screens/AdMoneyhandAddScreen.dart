import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/MatrialReqController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
      padding: const EdgeInsets.only(right: 9, left: 9),
      child: Container(
        height: 42,
        padding: EdgeInsets.only(
          right: 9,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey[400])),
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
      height: 42,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.grey[400])),
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
        title: Text(
          "Add Money Transfer",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
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
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: _paymenttype()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
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
                      borderSide: BorderSide(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
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
              padding: const EdgeInsets.only(right: 9, left: 9),
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
                      borderSide: BorderSide(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: GestureDetector(
                onTap: () {
                  _con.moneytranferAddd(employe, pymnttype, amountContrr.text,
                      remarkController.text, widget.token, context);

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdBottomtabs())) ;
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  padding: EdgeInsets.all(11),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff4a67b3)),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
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
