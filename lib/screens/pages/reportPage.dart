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

  void getData() {
    collection.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['uid'] == widget.uid) {
          print(doc);
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
        backgroundColor: colorSpace.firstColor,
      ),
      body: Container(
        child: Text(widget.uid),
      ),
    );
  }
}
