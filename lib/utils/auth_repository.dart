import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediscan/utils/auth_methods.dart';

class FirebaseRepository {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<UserCredential> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(UserCredential userCredential) =>
      _firebaseMethods.authenticateUser(userCredential);

  Future<void> addDataToDb(UserCredential userCredential) =>
      _firebaseMethods.addDataToDb(userCredential);

  Future<void> addReportToDb(User user, String fileName) =>
      _firebaseMethods.addReportToDb(user, fileName);

  Future<bool> signOut() => _firebaseMethods.signOut();
}
