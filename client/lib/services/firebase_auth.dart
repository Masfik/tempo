import 'package:Tempo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChanged => _auth.onAuthStateChanged.map(_toUserModel);

  Future<User> signIn(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      )).user;

      User user = _toUserModel(firebaseUser);
      user.token = (await firebaseUser.getIdToken()).token;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User> signUp(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      User user = _toUserModel(firebaseUser);
      user.token = (await firebaseUser.getIdToken()).token;
      return user;
    } catch (e) {
      return null;
    }
  }

  User _toUserModel(FirebaseUser firebaseUser) => firebaseUser != null ? User.fromFirebase(firebaseUser) : null;
}
