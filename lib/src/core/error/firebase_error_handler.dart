void parseFirebaseException(String code) {
  if (code == 'invalid-email') {
    throw AuthException('Invalid email address');
  } else if (code == 'user-not-found') {
    throw AuthException(
        'User not found, no user correspond to this email address');
  } else if (code == 'wrong-password') {
    throw AuthException('Invalid password');
  } else if (code == 'account-exists-with-different-credential') {
    throw AuthException('Account exist with different email');
  } else if (code == 'invalid-credential') {
    throw AuthException('Invalid credential');
  } else if (code == 'wrong-password') {
    throw AuthException('Wrong password');
  } else if (code == 'email-already-in-use') {
    throw AuthException('Email already exist, try another email');
  } else if (code == 'weak-password') {
    throw AuthException('Provide a stronger password');
  } else if (code == 'requires-recent-login') {
    throw AuthException('please re-login to update password');
  } else {
    throw Exception(code);
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}
