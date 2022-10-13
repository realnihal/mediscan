import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/screens/pages/bookAppointment.dart';
import 'package:mediscan/screens/pages/infoPage.dart';
import 'package:mediscan/screens/pages/uploadDoc.dart';

class HomePagePatient extends StatefulWidget {
  const HomePagePatient({super.key});

  @override
  State<HomePagePatient> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  @override
  Widget build(BuildContext context) {
    PageController pagecontroller = PageController(initialPage: 1);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: pagecontroller,
            children: const [
              BookingPage(),
              InfoPage(),
              UploadDocPage(),
            ],
          ),
        ),
        Container(
          height: 2,
          color: ColorSpace().secondColor,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              medicalButton(pagecontroller),
              homeButton(pagecontroller),
              uploadButton(pagecontroller),
            ],
          ),
        )
      ],
    ));
  }

  GestureDetector medicalButton(PageController pagecontroller) {
    return GestureDetector(
      onTap: () {
        pagecontroller.animateToPage(0,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorSpace().secondColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.medical_services_outlined),
        ),
      ),
    );
  }

  GestureDetector uploadButton(PageController pagecontroller) {
    return GestureDetector(
      onTap: () {
        pagecontroller.animateToPage(2,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorSpace().secondColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.upload_outlined),
        ),
      ),
    );
  }

  GestureDetector homeButton(PageController pagecontroller) {
    return GestureDetector(
      onTap: () {
        pagecontroller.animateToPage(1,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorSpace().secondColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.home_outlined),
        ),
      ),
    );
  }
}
