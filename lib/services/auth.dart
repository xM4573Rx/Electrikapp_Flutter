import 'package:firebase_auth/firebase_auth.dart';

class AuthFireBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('UID:');
      print(user.user.uid);
      return user.user.uid;
    } catch (e) {
      return null;
    }
  }

  Future<String> creteUser(String email, String password) async {
    try {
      AuthResult user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user.user.uid;
    } catch (e) {
      return null;
    }
  }

  Future<String> currentUser() async {
    try {
      FirebaseUser user = await firebaseAuth.currentUser();
      return user.uid;
    } catch (e) {
      print('Exception: ' + e.toString());
      return null;
    }

    //return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    firebaseAuth.signOut();
  }
}