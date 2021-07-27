import 'dart:convert';
import 'dart:io';

import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;

Future viewmoneyonhand(token) async {
  print("Money On Hand  $token");
  final String url = NetworkUtils.stffviewmoneyonhand;
  print(url);
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var viewmoney = json.decode(res.body);
  print("viewmoney " + viewmoney.toString());
  return viewmoney;
}
