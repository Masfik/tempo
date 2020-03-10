import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/services/api/user_data.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/services/authentication/firebase_auth.dart';

class UserAuthAdapter implements AuthService<User> {
  ApiService userDataApiService;
  AuthService authService;

  UserAuthAdapter() {
    userDataApiService = UserDataService();
    // Sets Firebase as the authentication service and utilises UserDataService as the user data supplier
    authService = FirebaseAuthService(userDataApiService);
  }

  @override
  Stream<User> get user => authService.user;

  @override
  Future<User> signIn(String email, String password) => authService.signIn(email, password);

  @override
  Future<User> signUp(String email, String password) => authService.signUp(email, password);

  @override
  Future<void> logout() => authService.logout();
}