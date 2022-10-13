import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';

class UploadDocPage extends StatefulWidget {
  const UploadDocPage({super.key});

  @override
  State<UploadDocPage> createState() => _UploadDocPageState();
}

class _UploadDocPageState extends State<UploadDocPage> {
  late File file;
  String uploadUrl = "";
  String downloadUrl = "";
  bool isUploaded = false;

  Future<void> uploadFile(File file) async {
    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: 'ExampleKey',
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          });
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> getFileFromDirectory() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      print("operation aborted");
    }
  }

  // Future<void> getLinks(String fileType) async {
  //   try {
  //     Map body = {"fileType": fileType};
  //     String url = 'http://10.0.2.2:1000/generatePresignedUrl';
  //     var response = await http.post(
  //       Uri.parse(url),
  //       body: body,
  //     );

  //     var result = jsonDecode(response.body);

  //     if (result['success'] != null) {
  //       // success = result['success'];
  //       // message = result['message'];

  //       if (response.statusCode == 201) {
  //         uploadUrl = result["uploadUrl"];
  //         downloadUrl = result["downloadUrl"];
  //       }
  //     }
  //   } catch (e) {
  //     throw ('Error getting url');
  //   }
  // }

  // Future<void> uploadFile(String url, File file) async {
  //   try {
  //     Uint8List bytes = await file.readAsBytes();
  //     var response = await http.put(Uri.parse(url), body: bytes);
  //     if (response.statusCode == 200) {
  //       isUploaded = true;
  //     }
  //   } catch (e) {
  //     throw ('Error uploading photo');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ColorSpace colorSpace = ColorSpace();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            await getFileFromDirectory();
            await uploadFile(file);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: colorSpace.thirdColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Center(
              child: Text(
                "Upload File",
                style: TextStyle(
                  color: colorSpace.fourthColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
