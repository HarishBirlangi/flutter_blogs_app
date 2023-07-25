import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/common_files/common_widgets.dart';

class AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> userRegistrationUsingFirebase(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
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

  Future<void> userLoginUsingFirebase(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CommonWidgets().alertDialogue(context, "Error", "Wrong email");
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        CommonWidgets().alertDialogue(context, "Error", "Wrong password");
        print("Wrong password");
      } else {
        CommonWidgets()
            .alertDialogue(context, "Error", "Check the credentials");
        print("Check the credentials 1");
      }
    } catch (e) {
      CommonWidgets().alertDialogue(context, "Error", "Check the credentials");
      print("Check the credentials 2");
    }
  }

  String? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<void> signOutUser() async {
    _firebaseAuth.signOut();
  }
}
