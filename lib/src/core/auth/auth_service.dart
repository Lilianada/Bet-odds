import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Returns the currently signed-in user, or null if no user is signed in.
  User? get currentUser => _auth.currentUser;

  /// Signs in with the given [email] and [password].
  ///
  /// Throws a [SignInException] if an error occurs.
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      throw SignInException(e.toString());
    }
  }

  /// Registers a new user with the given [email] and [password].
  ///
  /// Throws a [SignUpException] if an error occurs.
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      throw SignUpException(e.toString());
    }
  }

  /// Signs in with Google.
  ///
  /// Throws a [SignInException] if an error occurs.
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      print(e.toString());
      throw SignInException(e.toString());
    }
  }

  /// Signs out the current user.
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      throw SignOutException(e.toString());
    }
  }
}

class SignInException implements Exception {
  final String message;
  SignInException(this.message);
}

class SignUpException implements Exception {
  final String message;
  SignUpException(this.message);
}

class SignOutException implements Exception {
  final String message;
  SignOutException(this.message);
}
