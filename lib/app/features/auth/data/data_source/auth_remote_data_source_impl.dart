part of 'auth_remote_data_source.dart';

class _AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;

  _AuthRemoteDataSourceImpl({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<User?> login() async {
    try {
      final userCredential = await signInWithGoogle();

      if (userCredential != null) {
        return userCredential.user;
      }
      return null;
    } catch (e) {
      return Future.error(e);
    }
  }

  //Google SignIn Docs
  Future<UserCredential?> signInWithGoogle() async {
    await InternetAddress.lookup('google.com');
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
