import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../api/api_service.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final ApiService api;

  AuthRepository(
    this._firebaseAuth,
    this.api,
  );

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw 'Wrong credentials, please try again!';
        case 'user-not-found':
          throw 'Wrong credentials, please try again!';
        case 'user-disabled':
          throw 'User with this email has been disabled.';
        case 'operation-not-allowed':
          throw 'Too many requests. Try again later.';
        default:
          throw 'An undefined error happened.';
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final firebaseResponse =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseId = firebaseResponse.user?.uid;

      await api.createUser(email, username, firebaseId!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw 'Email is already in use.';
        case 'invalid-email':
          throw 'Invalid email';
        case 'weak-password':
          throw 'The password you have entered is too weak, it must be at least 6 characters.';
        default:
          throw 'An undefined Error occured.';
      }
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetLink(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
