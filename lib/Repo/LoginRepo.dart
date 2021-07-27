import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';

Future signIn(phone, password, devid) async {
  final String url = NetworkUtils.login;
  final responseFollow = await http.post(Uri.parse(url), body: {
    "phone": phone.toString(),
    "password": password.toString(),
    "device_token": devid.toString()
  });
  var dataUser = json.decode(responseFollow.body);
  return dataUser;
}
