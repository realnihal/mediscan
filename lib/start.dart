import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/screens/signin.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorSpace colorspace = ColorSpace();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorspace.firstColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.medical_services_rounded),
            SizedBox(
              width: 5,
            ),
            Text("Mediscan"),
          ],
        ),
        elevation: 1,
      ),
      backgroundColor: colorspace.firstColor,
      body: const ChoicePage(),
    );
  }
}
