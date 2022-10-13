import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mediscan/screens/patientHome.dart';
import 'package:mediscan/utils/auth_repository.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool status = false;
  ColorSpace colorspace = ColorSpace();
  final FirebaseRepository _repository = FirebaseRepository();

  void performLogin() async {
    UserCredential userCredential = await _repository.signIn();
    authenticateUser(userCredential);
  }

  void authenticateUser(UserCredential userCredential) {
    _repository.authenticateUser(userCredential).then((isNewUser) {
      if (isNewUser) {
        _repository.addDataToDb(userCredential).then((value) {});
      }
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const HomePagePatient())));
    });
  }

  Widget loginGoogle(BuildContext context, ColorSpace colorspace) {
    return GestureDetector(
      onTap: () {
        performLogin();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
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
          color: status ? colorspace.fourthColor : colorspace.thirdColor,
        ),
        child: Center(
          // TODO: replace with google logo
          child: Text(
            "Sign in with google",
            style: TextStyle(
                color: colorspace.firstColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorSpace colorspace = ColorSpace();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          doctorCheck(),
          const SizedBox(height: 60),
          image(colorspace, context),
          const SizedBox(height: 100),
          loginGoogle(context, colorspace),
        ],
      ),
    );
  }

  Column doctorCheck() {
    return Column(
      children: [
        const Text(
          "Are you a doctor?",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        FlutterSwitch(
          width: 60.0,
          height: 30.0,
          valueFontSize: 25.0,
          toggleSize: 20.0,
          value: status,
          borderRadius: 45.0,
          padding: 6.0,
          showOnOff: false,
          onToggle: (val) {
            setState(() {
              status = val;
            });
          },
        ),
      ],
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
}
