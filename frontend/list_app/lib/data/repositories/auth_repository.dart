
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

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
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw 'There is already a registration made with this email.';
        case 'invalid-email':
          throw 'The email you have entered is not valid.';
        case 'weak-password':
          throw 'The password you have entered is too weak, it must be at least 6 characters.';

        default:
          throw 'An undefined Error happened.';
      }
    }
  }
  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetLink(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}