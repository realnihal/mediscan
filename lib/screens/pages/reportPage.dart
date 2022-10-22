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

  Future<void> getData() async {
    await collection.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['uid'] == widget.uid) {
          patientName = doc['name'];
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
    var data = {
      'hemostasis': 86,
      'edema': 97,
      'pain': 97,
    };
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
                    const Text(
                      "You need to see a doctor ASAP",
                      style: TextStyle(
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
                      children: const [
                        Text(
                          "Prediction score: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Surgery - 95.4%",
                          style: TextStyle(
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
                        const Text(
                          "Hemostasis",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${data['hemostasis']}%",
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
                        const Text(
                          "Edema",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${data['edema']}%",
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
                        const Text(
                          "Pain",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${data['pain']}%",
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
