import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';
import 'package:mediscan/start.dart';
import 'package:mediscan/utils/auth_repository.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final FirebaseRepository _repository = FirebaseRepository();
  User? currentUser;

  void loadData() async {
    await _repository.getCurrentUser().then((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorSpace colorspace = ColorSpace();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // header
          infoCard(colorspace),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: colorspace.secondColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  (currentUser == null)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colorspace.thirdColor,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              // profile picture
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      currentUser!.photoURL!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                currentUser!.displayName!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool isLoggedOut =
                                      await _repository.signOut();
                                  if (isLoggedOut) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StartPage()),
                                        (route) => false);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: colorspace.thirdColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Sign Out'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container infoCard(ColorSpace colorspace) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorspace.secondColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Mediscan",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Your Health, Our Priority",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "We are here to help you",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Swipe Right to get started by uploading files",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
