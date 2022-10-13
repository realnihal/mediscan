import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/screens/patientHome.dart';
import 'package:mediscan/screens/signin.dart';
import 'package:mediscan/utils/auth_repository.dart';

import 'amplifyconfiguration.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add these lines, to include Auth and Storage plugins.
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([storage, auth]);
    try {
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('Tried to configure Amplify and following error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseRepository repository = FirebaseRepository();
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
      body: FutureBuilder(
        future: repository.getCurrentUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return const HomePagePatient();
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
