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
        CommonWidgets().alertDialogue(
            context, "Error", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        CommonWidgets().alertDialogue(
            context, "Error", "The account already exists for that email.");
      }
    } catch (e) {
      CommonWidgets().alertDialogue(context, "Error", "Something went wrong");
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
      } else if (e.code == 'wrong-password') {
        CommonWidgets().alertDialogue(context, "Error", "Wrong password");
      } else {
        CommonWidgets()
            .alertDialogue(context, "Error", "Check the credentials");
      }
    } catch (e) {
      CommonWidgets().alertDialogue(context, "Error", "Check the credentials");
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
