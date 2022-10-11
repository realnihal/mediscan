import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

/// accepts two parameters,the endpoint and the file
/// returns Response from server
Future<Response> sendFile(String url, File file) async {
  Dio dio = Dio();
  var len = await file.length();
  var response = await dio.put(url,
      data: file.openRead(),
      options: Options(headers: {
        Headers.contentLengthHeader: len,
      } // set content-length
          ));
  return response;
}
