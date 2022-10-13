import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediscan/models/person.dart';
import 'package:mediscan/utils/utilities.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String url = "";

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Person user = Person();

  Future<User> getCurrentUser() async {
    User currentUser;
    // ignore: await_only_futures
    currentUser = await _auth.currentUser!;
    return currentUser;
  }

  Future getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('persons').doc(id).get();
      return Person.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication =
        await signInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken);
    return await _auth.signInWithCredential(credential);
  }

  Future<bool> authenticateUser(UserCredential userCredential) async {
    QuerySnapshot result = await firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    //if user is registered then length of list > 0 or else less than 0
    return docs.isEmpty ? true : false;
  }

  Future<void> addDataToDb(UserCredential userCredential) async {
    String username = Utils.getUsername(userCredential.user?.email ?? "");
    firestore.collection('persons').doc(userCredential.user?.uid).set(
      {
        'uid': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
        'profilePhoto': userCredential.user?.photoURL,
        'username': username
      },
    );
  }

  Future<bool> signOut() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
