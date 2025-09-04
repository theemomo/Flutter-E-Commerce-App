import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  User? getCurrentUser();
  Future<void> logout();
  // Future<void> authWithGoogle();
  Future<bool> authWithFacebook();
  Future<void> deleteUser();
  Future<void> updatePassword(String newPassword);
  Future<void> updateEmail(String newEmail);
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreServices = FirestoreServices.instance;
  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    // Implement login logic here
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> registerWithEmailAndPassword(String email, String password) async {
    // Implement registration logic here
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    }
    return false;
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await FacebookAuth.instance.logOut();
  }

  // @override
  // Future<void> authWithGoogle() async {
  //   // Implement Google authentication logic here
  //   final GoogleSignIn signIn = GoogleSignIn.instance;

  // }

  @override
  Future<bool> authWithFacebook() async {
    // Implement Facebook authentication logic here
    final loginResult = await FacebookAuth.instance.login();
    if (loginResult.status != LoginStatus.success) {
      return false;
    }
    final credential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
    await _firestoreServices.deleteData(
      path: ApiPaths.users(userId: _firebaseAuth.currentUser!.uid),
    );
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    await _firebaseAuth.currentUser!.verifyBeforeUpdateEmail(newEmail);
  }
}
