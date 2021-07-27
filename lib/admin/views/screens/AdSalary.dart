import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
class AdSalary extends StatefulWidget {
  @override
  _AdSalaryState createState() => _AdSalaryState();
}

class _AdSalaryState extends State<AdSalary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body:  ListView.builder(
        itemCount: 4,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>EmpDetails()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 9,right: 9,top: 10),
              child: Container(
                height: 75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [ //background color of box
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 0.8, // soften the shadow
                      spreadRadius:0.8, //extend the shadow
                      offset: Offset(
                        0.5, // Move to right 10  horizontally
                        0.5, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 15,right: 15,left: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(minRadius: 21,maxRadius: 23,
                              backgroundImage: AssetImage("assets/images/men.jpg"),
                              backgroundColor: Colors.black,),
                            SizedBox(width: 8,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:<Widget> [
                                Text("Prageen",style: w816),
                                Text("singer",style: g612W5,),
                              ],
                            ),
                          ],
                        ),
                        Text("13,200",style:b10W7),
                      ],
                    ),

                  ),
                ),
              ),
            ),
          );
        },

      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff496ab1),
          child: Icon(FontAwesomeIcons.plus,color: Colors.white,size: 20,),
          onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestPage()));
            print("flaoa");
          }),
    );
  }
}
