import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({required this.uid, super.key});
  final String uid;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var collection = FirebaseFirestore.instance.collection('reports');
  String patientName = '';
  String key1 = '';
  String key2 = '';
  String key3 = '';
  String value1 = '';
  String value2 = '';
  String value3 = '';
  String score = '';
  String output = '';

  Future<void> getData() async {
    await collection.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['uid'] == widget.uid) {
          setState(() {
            patientName = doc['name'];
            key1 = doc['key1'];
            key2 = doc['key2'];
            key3 = doc['key3'];
            value1 = doc['value1'];
            value2 = doc['value2'];
            value3 = doc['value3'];
            score = doc['score'];
            output = doc['output'];
            print(output);
          });
        }
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorSpace colorSpace = ColorSpace();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Analysis"),
        centerTitle: true,
        backgroundColor: colorSpace.firstColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorSpace.secondColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'name: $patientName',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'status: processed',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Prediction: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      (output == "normal")
                          ? "Please schedule an appointment at your leisure!"
                          : "You need to see a doctor ASAP!",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Prediction score: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          (output == "normal")
                              ? "Consultation - $score"
                              : "Surgery - $score",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Attributes:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          value1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key2,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          value2,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key3,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          value3,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        "This data is generated my machine learning model, please book an appointment with a doctor ASAP for a final diagnosis",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
