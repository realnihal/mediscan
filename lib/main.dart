import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/start.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ColorSpace colorspace = ColorSpace();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorspace.thirdColor,
        scaffoldBackgroundColor: colorspace.firstColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.cyan,
        ),
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: const StartPage(),
    );
  }
}
