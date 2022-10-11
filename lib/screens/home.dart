import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_s3/simple_s3.dart';
import 'package:dio/dio.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File file;
  bool flag = false;
  final SimpleS3 _simpleS3 = SimpleS3();

  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }

    print('upload started');
    var url = 'aws-s3';
    String res2 = await _simpleS3.uploadFile(
        file,
        "mediscan-7676",
        "ap-southeast-2:e0f5174c-5abb-4c18-98d9-32db24da5182",
        AWSRegions.apSouthEast2,
        s3FolderPath: "files/");
    print("res-2 $res2");
    setState(() {
      file = file;
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            flag == false
                ? const Text(
                    "No file found",
                    style: TextStyle(color: Colors.white),
                  )
                : const Text(
                    "file uploaded",
                    style: TextStyle(color: Colors.white),
                  ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: const Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
