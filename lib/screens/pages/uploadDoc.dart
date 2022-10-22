import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/screens/pages/reportPage.dart';
import 'package:mediscan/utils/auth_repository.dart';
import 'package:uuid/uuid.dart';

class UploadDocPage extends StatefulWidget {
  const UploadDocPage({super.key});

  @override
  State<UploadDocPage> createState() => _UploadDocPageState();
}

class _UploadDocPageState extends State<UploadDocPage> {
  late File file;
  bool isUploaded = false;
  String fileName = '';
  Uuid uuid = const Uuid();
  final FirebaseRepository _repository = FirebaseRepository();

  void sendNotification(String uid) async {
    final url = Uri.http('3.104.104.196', '/analyse');
    print("Sent Information");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(
        {'uid': uid},
      ),
    );
    print(response.body);
  }

  Future<void> uploadFile(File file, String name) async {
    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: name,
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          });
      print('Successfully uploaded file: ${result.key}');
      setState(() {
        isUploaded = true;
      });
      await _repository.addReportToDb(
          await _repository.getCurrentUser(), fileName);
      sendNotification(name);
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> getFileFromDirectory() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    fileName = '${uuid.v1()}.pdf';
    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      print("operation aborted");
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorSpace colorSpace = ColorSpace();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              await getFileFromDirectory();
              await uploadFile(file, fileName);
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
                  "Upload Report",
                  style: TextStyle(
                    color: colorSpace.fourthColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 2,
            color: Colors.black,
          ),
          const SizedBox(
            height: 30,
          ),
          const ReportCardList()
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard({
    Key? key,
    required this.colorSpace,
    required this.status,
    required this.id,
  }) : super(key: key);

  final ColorSpace colorSpace;
  final String status;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorSpace.secondColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "ID: ${id.substring(0, 8)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(status,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade200,
                      )),
                ],
              ),
            ),
            Expanded(child: Container()),
            (status != "pending")
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ReportPage(
                                    uid: id,
                                  ))));
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Select',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  )
                : CircularProgressIndicator(
                    color: colorSpace.thirdColor,
                  )
          ]),
        ),
      ),
    );
  }
}

class ReportCardList extends StatefulWidget {
  const ReportCardList({super.key});

  @override
  State<ReportCardList> createState() => _ReportCardListState();
}

class _ReportCardListState extends State<ReportCardList> {
  CollectionReference recipes =
      FirebaseFirestore.instance.collection('reports');
  ColorSpace colorSpace = ColorSpace();
  final FirebaseRepository _repository = FirebaseRepository();
  User? currentUser;

  void loadData() async {
    await _repository.getCurrentUser().then((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: recipes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (currentUser!.uid == snapshot.data!.docs[index]['owner']) {
                  return ReportCard(
                    colorSpace: colorSpace,
                    status: snapshot.data!.docs[index]['status'],
                    id: snapshot.data!.docs[index]['uid'],
                  );
                }
                return Container();
              },
            ),
          );
        });
  }
}
