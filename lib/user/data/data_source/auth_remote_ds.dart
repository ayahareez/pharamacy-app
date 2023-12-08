import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_model.dart';

abstract class AuthinticationRemoteDs {
  Future<void> signIn(AuthModel userModel);
  Future<void> signUp(AuthModel userModel);
  Future<void> signInAsGuest();
  Future<void> signOut();
  bool checkIfAuth();
  String getUserId();
  bool checkUserSignInStatus();
}

class AuthinticationRemoteDsImpl extends AuthinticationRemoteDs {
  @override
  Future<void> signIn(AuthModel userModel) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userModel.email, password: userModel.password);
  }

  @override
  Future<void> signOut() async {
    print('signout');
    await FirebaseAuth.instance.signOut();
    print('after signout');
  }

  @override
  Future<void> signUp(AuthModel userModel) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password,
    );
  }

  @override
  bool checkIfAuth() => FirebaseAuth.instance.currentUser != null;

  @override
  String getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return throw Exception('the user did\'t sign in');
  }

  @override
  Future<void> signInAsGuest() async {
    try {
      print('guest');
      // Sign in as a guest without authentication
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      // Handle any errors that occur during guest sign-in
      print('Error signing in as a guest: $e');
      throw Exception('Failed to sign in as a guest');
    }
  }

  bool checkUserSignInStatus() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      print("User is signed in!");
      print("User UID: ${user.uid}");
      print("Is Anonymous.........: ${user.isAnonymous}");
      return user.isAnonymous;
    } else {
      print("User is signed out.");
      return false;
    }
  }
}