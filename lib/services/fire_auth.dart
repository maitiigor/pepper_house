import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pepper_house/models/user_model.dart';

import '../enum/auth_result_status.dart';
import '../exemption-handlers/auth_exemption_handler.dart';

class FireAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResultStatus> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    _auth = FirebaseAuth.instance;
    User? user;
    late AuthResultStatus _status;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
      user = userCredential.user;
      await user!.updatePhotoURL(name);
      await user.reload();
      user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      /* if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } */
    } catch (e) {
      print(e);
    }
    return _status;
  }

  Future<AuthResultStatus> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    User? user;
    late AuthResultStatus _status;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      /* if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    } */
    }

    return _status;
  }

  Future<UserModel> getUser() async {
    var authUser = _auth.currentUser!;

    return UserModel(
        uid: authUser.uid,
        email: authUser.email.toString(),
        displayName: authUser.displayName,
        photoURL: authUser.photoURL);
  }

  Future<String> updateUser({required name, required phoneNumber}) async {
    String message = "success";
    var currentUser = _auth.currentUser!;
    /*  await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
    ); */
    //print(phoneNumber);
    try {
      await currentUser.updateDisplayName(name);
      if (currentUser.displayName != name) {
        message = "failed";
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }

    // await currentUser.updatePhoneNumber(phoneNumber);
    return message;
  }

  Future<String> updatePassword({required password}) async {
    var currentUser = _auth.currentUser!;
    String message = "success";
    try {
      await currentUser.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      message = "failed";
    }

    return message;
  }
}
