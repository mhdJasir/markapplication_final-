// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:hrmarkgrp/user/views/Screens/ABC.dart';
//
//
// class TestScreen extends StatefulWidget {
//   @override
//   _TestScreenState createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   _timer() async {
//     return Timer(
//         Duration(seconds: 2),(){
//       Navigator.pop(context);
//       Navigator.push(context, MaterialPageRoute(
//           builder: (context) => PageTwo()
//       ));
//     }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                     hintText: "Email"
//                 ),
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                     hintText: "Password"
//                 ),
//               ),
//               SizedBox(height: 100,),
//               MaterialButton(
//                 color: Colors.blue,
//                 onPressed: (){
//                   showDialog(context: context,barrierDismissible: true,
//                       child: Dialog(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircularProgressIndicator(),
//                               SizedBox(width: 15,),
//                               Text("Loading...")
//                             ],),
//                         ),
//                       )
//                   );
//                   _timer();
//                 },
//                 child: Text("Login"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }