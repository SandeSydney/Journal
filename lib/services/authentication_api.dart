abstract class AuthenticationApi {
  // inteface methods of the abstract class
  getFirebaseAuth();
  Future<String> currentUserUid();
  Future<void> signOut();
  Future<String> signInWithEmailAndPassword({String email, String password});
  Future<String> createUserWithEmailAndPassword(
      {String email, String password});
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}
