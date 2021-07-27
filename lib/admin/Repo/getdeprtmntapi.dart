import 'dart:convert';
import 'dart:io';

import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future getDep() async {
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('tokenid');
  String url = NetworkUtils.getdeprtmnt;
  final response = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var convertDataToJson = json.decode(response.body.toString());
  return convertDataToJson;
}

Future getDesigntn(id) async {
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('tokenid');

  // Map<dynamic, String> headers = {HttpHeaders.authorizationHeader:"Bearer "+Tokens.toString(),};
  String url = NetworkUtils.getdesignation;

  final respons = await http.post(Uri.parse(url), body: {
    "dep_id": id.toString()
  }, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  // respons.headers.addAll(headers);
  var convertDataToJson = json.decode(respons.body.toString());
  return convertDataToJson;
}
