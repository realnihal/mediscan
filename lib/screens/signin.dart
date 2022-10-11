import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/screens/home.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorSpace colorspace = ColorSpace();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image(colorspace, context),
          const SizedBox(height: 100),
          choicePatient(context, colorspace),
          const SizedBox(height: 50),
          choiceDoctor(context, colorspace),
        ],
      ),
    );
  }

  Container image(ColorSpace colorspace, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(2, 2)),
          BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(-2, -2))
        ],
        borderRadius: BorderRadius.circular(45),
        color: colorspace.firstColor,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(image: AssetImage('assets/images/medical.png')),
      ),
    );
  }

  Widget choicePatient(BuildContext context, ColorSpace colorspace) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const HomePage())));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(4, 4)),
            BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(-4, -4))
          ],
          borderRadius: BorderRadius.circular(45),
          color: colorspace.thirdColor,
        ),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: colorspace.fourthColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget choiceDoctor(BuildContext context, ColorSpace colorspace) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const HomePage())));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(4, 4)),
            BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(-4, -4))
          ],
          borderRadius: BorderRadius.circular(45),
          color: colorspace.fourthColor,
        ),
        child: Center(
          child: Text(
            "I am a Doctor",
            style: TextStyle(
              color: colorspace.thirdColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
