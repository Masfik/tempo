import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService<AuthUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<AuthUser> get user => _auth.onAuthStateChanged.map(_toAuthUserModel);

  @override
  Future<AuthUser> signIn(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      )).user;

      return _toAuthUserModel(firebaseUser);
    } catch (e) { return null; }
  }

  @override
  Future<AuthUser> signUp(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      return _toAuthUserModel(firebaseUser);
    } catch (e) { print(e); return null; }
  }

  @override
  Future<void> logout() => _auth.signOut();

  AuthUser _toAuthUserModel(FirebaseUser firebaseUser) {
    if (firebaseUser == null) return null;
    return AuthUser(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      token: firebaseUser.getIdToken().then((value) => value.token)
    );
  }
}
