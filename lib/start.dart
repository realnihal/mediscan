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

  void _configureAmplify() async {
    AmplifyAuthCognito auth = AmplifyAuthCognito();
    AmplifyStorageS3 storage = AmplifyStorageS3();

    Amplify.addPlugins([auth, storage]);

    //Initialize AmplifyFlutter
    try {
      await Amplify.configure(amplifyconfig);

      print("Amplify was configured.");
    } on AmplifyAlreadyConfiguredException {
      print(
          "Amplify was already configured. Looks like app restarted on android.");
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
