import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:hrmarkgrp/user/controller/MoneyOnHand_Controller.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/CashOnHandTrans.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CashOnHand extends StatefulWidget {
  final tok;
  CashOnHand({this.tok});
  @override
  _CashOnHandState createState() => _CashOnHandState();
}

class _CashOnHandState extends StateMVC<CashOnHand> {
  MoneyOnHndConroller _con;
  _CashOnHandState() : super(MoneyOnHndConroller()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.moneyOnhndview(widget.tok, context);
    super.initState();
  }

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
          "Cash On Hand",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: _con.isloading == true
          ? ListView.builder(
              itemCount: _con.viewmoneyOnhand != null
                  ? _con.viewmoneyOnhand.length
                  : 0,
              itemBuilder: (context, index) {
                var parsedDate = DateTime.parse(
                    _con.viewmoneyOnhand[index]["date"].toString());
                String date = new DateFormat("yyyy-MM-dd").format(parsedDate);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoneyOnHandInnr(
                                tok: widget.tok,
                                datas: _con.viewmoneyOnhand[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                    child: Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: MyApp.border)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, right: 15, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date,
                                  style: b14W7,
                                ),
                                Text(
                                  _con.viewmoneyOnhand[index]["amount"]
                                          .toString() +
                                      "/-",
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
                                _con.viewmoneyOnhand[index]["payment_type"]
                                    .toString(),
                                style: b14W7),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _con.viewmoneyOnhand[index]["remark"]
                                      .toString(),
                                  style: b14W7,
                                ),
                                Text(
                                  _con.viewmoneyOnhand[index]["balance"]
                                          .toString() +
                                      "/-",
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
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      // floatingActionButton:  FloatingActionButton(
      //     backgroundColor: Color(0xff496ab1),
      //     child: Icon(FontAwesomeIcons.plus,color: Colors.white,size: 20,),
      //     onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>AdMoneyTransferAddscreen(token:widget.token)));
      //       print("flaoa");
      //     }),
    );
  }
}
