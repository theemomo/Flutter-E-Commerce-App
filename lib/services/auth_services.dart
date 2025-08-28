import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  User? getCurrentUser();
  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  
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
  }
}
