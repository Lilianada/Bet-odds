import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:odd_sprat/src/core/error/firebase_error_handler.dart';
import 'package:odd_sprat/src/features/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await authInstance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await userCredential.user?.updateDisplayName(name);
      return UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific signup errors here if needed
      throw Exception(e.message);
    }
  }

  Future<UserModel> logInWithEmail(
      {required String email, required String password});
  Future<UserModel> signInWithGoogle();
  Future<bool> signOut();
}

class FakeAuthDatasource implements AuthDatasource {
  @override
  Future<UserModel> logInWithEmail(
      {required String email, required String password}) async {
    final user = UserModel(id: getRandomString, email: email, name: 'name');
    await Future.delayed(const Duration(seconds: 2));
    return user;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final user = UserModel(id: getRandomString, email: 'email', name: 'name');
    await Future.delayed(const Duration(seconds: 2));
    return user;
  }

  @override
  Future<bool> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<UserModel> signUpWithEmail(
      {required String email,
      required String password,
      required String name}) async {
    final user = UserModel(id: getRandomString, email: email, name: name);
    await Future.delayed(const Duration(seconds: 2));
    return user;
  }

  String get getRandomString {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        100, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  @override
  // TODO: implement authInstance
  FirebaseAuth get authInstance => throw UnimplementedError();
}

class FirebaseAuthDatasource implements AuthDatasource {
  @override
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  Future<UserModel> logInWithEmail(
      {required String email, required String password}) async {
    UserModel? userModel;
    try {
      final userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          name: userCred.user!.displayName ?? '');
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e) {
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    UserModel? userModel;
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCred = await authInstance.signInWithCredential(credential);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: googleUser!.email,
          name: googleUser.displayName ?? '');
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e) {
      //To prevent caching of failed credentials
      await GoogleSignIn().signOut();
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<UserModel> signUpWithEmail(
      {required String email,
      required String password,
      required String name}) async {
    UserModel? userModel;
    try {
      final userCred = await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      userCred.user!.updateDisplayName(name);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          name: userCred.user!.displayName ?? name);
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e) {
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<bool> signOut() async {
    bool result = false;
    try {
      await authInstance.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }
}
