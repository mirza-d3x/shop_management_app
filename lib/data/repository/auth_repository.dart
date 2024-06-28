import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_management_app/data/models/user_model.dart';
import 'package:shop_management_app/main.dart';
import 'package:shop_management_app/utils/console_log.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._firebaseAuth, this._firestore);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signUp({
    required String email,
    required String password,
    required String shopName,
    required String place,
  }) async {
    try {
      consoleLog('Attempting to sign up user with email: $email',
          name: 'AuthRepository');
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        shopName: shopName,
        place: place,
      );

      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      consoleLog('User signed up successfully with UID: ${user.uid}',
          name: 'AuthRepository');
      kUserId = currentUser!.uid;
    } catch (e) {
      consoleLog('Sign up failed: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      consoleLog('Attempting to sign in user with email: $email',
          name: 'AuthRepository');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      kUserId = currentUser!.uid;
      consoleLog('User signed in successfully', name: 'AuthRepository');
    } catch (e) {
      consoleLog('Sign in failed: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      consoleLog('Attempting to sign out user', name: 'AuthRepository');
      await _firebaseAuth.signOut();
      consoleLog('User signed out successfully', name: 'AuthRepository');
    } catch (e) {
      consoleLog('Sign out failed: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw Exception(e.toString());
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
