import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static late Authentication _authentication;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///use factory design pattern
  factory Authentication() {
    _authentication = Authentication._internal();
    return _authentication;
  }
  Authentication._internal();

  /// Attempts to sign in a user with the given email address and password.

  Future<String?> login(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user?.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      log("AUTHENTICATION FAILED>>>>>>>>>>>>>> ",
          name: "AUTHENTICATION_SERVICE");
      return null;
    }
  }

  /// Triggers the Firebase Authentication backend to send a password-reset
  /// email to the given email address, which must correspond to an existing
  /// user of your app.

  Future<void> sendPasswordResetEmail(String email) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  /// Method to create a new user account with the given email address and password.
  /// it creates new use in authentication table.

  Future<String?> register(String email, String password) async {
    final UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user?.email;
  }

  Future<void> logout() async {
    return await _auth.signOut();
  }

  /// Returns the current [User] if they are currently signed-in, or `null` if
  /// not.
  Future<User?> getLoggedUser() async {
    final User? user = _auth.currentUser;
    if (user == null) return null;
    return user;
  }


}
