import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediscan/constants/colors.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    ColorSpace colorSpace = ColorSpace();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Book Appointment',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Choose your Doctor, we will take care of the rest',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 5,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          // TODO: make a list of doctorCards

          const DoctorCardList()
        ],
      ),
    );
  }
}

class DoctorCardList extends StatefulWidget {
  const DoctorCardList({super.key});

  @override
  State<DoctorCardList> createState() => _DoctorCardListState();
}

class _DoctorCardListState extends State<DoctorCardList> {
  CollectionReference recipes =
      FirebaseFirestore.instance.collection('doctors');
  ColorSpace colorSpace = ColorSpace();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: recipes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return DoctorsCard(
                  colorSpace: colorSpace,
                  name: snapshot.data!.docs[index]['Name'],
                  url: snapshot.data!.docs[index]['url'],
                  field: snapshot.data!.docs[index]['Field'],
                  location: snapshot.data!.docs[index]['Location'],
                );
              },
            ),
          );
        });
  }
}

class DoctorsCard extends StatelessWidget {
  const DoctorsCard({
    Key? key,
    required this.colorSpace,
    required this.name,
    required this.url,
    required this.field,
    required this.location,
  }) : super(key: key);

  final ColorSpace colorSpace;
  final String name;
  final String url;
  final String field;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorSpace.thirdColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(url),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    field,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Text(location,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade200,
                      )),
                ],
              ),
            ),
            Expanded(child: Container()),
            const Text(
              'Select',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ]),
        ),
      ),
    );
  }
}
