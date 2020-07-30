import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_api.dart';

class AuthenticationService implements AuthenticationApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth getFirebaseAuth() {
    return _firebaseAuth;
  }

  // retrieve currently logged-in user id
  Future<String> currentUserUid() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  // log out the current user
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // logging in user with email and password combination
  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // create user by the email and password combination
  Future<String> createUserWithEmailAndPassword(
      {String email, String password}) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // get the current user, send verification email
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  // get the current user, then confirm if the email has been verified
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
