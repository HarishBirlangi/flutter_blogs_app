import 'package:firebase_auth/firebase_auth.dart';

class AuthImplementation {
  Future<void> userRegistrationUsingFirebase(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("User registration successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> userLoginUsingFirebase(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("User login successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  String? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<void> signOutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
