import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService<User> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService userDataService;

  FirebaseAuthService(this.userDataService);

  @override
  Stream<User> get user => _auth.onAuthStateChanged.map(_toUserModel);

  @override
  Future<User> signIn(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      )).user;

      User user = _toUserModel(firebaseUser);
      return user;
    } catch (e) { return null; }
  }

  @override
  Future<User> signUp(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      User user = _toUserModel(firebaseUser);
      return user;
    } catch (e) { return null; }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    return null;
  }

  User _toUserModel(FirebaseUser firebaseUser) {
    if (firebaseUser == null) return null;
    return User.fromAuthService(
      authUser: AuthUser(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        token: firebaseUser.getIdToken().then((value) => value.token)
      ),
      userDataService: userDataService // Service from which the user data will be loaded
    );
  }
}
