import 'dart:convert';
import 'dart:io';

import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

Future viewdailyexpnce(token) async {
  final String url = NetworkUtils.addailyexpanseview;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var dalyexp = json.decode(res.body);
  return dalyexp;
}

Future updateadmindailyexpnce(
    expid, status, paidamount, total, File img, token) async {
  Uri apiUrl = Uri.parse(NetworkUtils.adminupdatedailyexpncee);

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString()
  };
  final mimeTypeData =
      lookupMimeType(img.path, headerBytes: [0xFF, 0xD8]).split('/');

  // Intilize the multipart request

  final imageUploadRequest = http.MultipartRequest('POST', apiUrl);
  // Attach the file in the request
  final file = await http.MultipartFile.fromPath('image', img.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  imageUploadRequest.files.add(file);
  imageUploadRequest.fields['expanse_id'] = expid.toString();
  imageUploadRequest.fields['status'] = status.toString();
  imageUploadRequest.fields['paid'] = paidamount.toString();
  imageUploadRequest.fields['total'] = total.toString();
  try {
    imageUploadRequest.headers.addAll(headers);
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  } catch (e) {
    return null;
  }
}

Future viewemploydailyask(token) async {
  final String url = NetworkUtils.adminviewemploytask;

  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var dalytask = json.decode(res.body);
  return dalytask;
}
