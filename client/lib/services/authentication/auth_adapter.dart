import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/services/authentication/firebase_auth.dart';

class AuthServiceAdapter implements AuthService<AuthUser> {
  AuthService authService;

  // Sets Firebase as the authentication service (can be changed at a later stage)
  AuthServiceAdapter() : authService = FirebaseAuthService();

  @override
  Stream<AuthUser> get user => authService.user;

  @override
  Future<AuthUser> signIn(String email, String password) => authService.signIn(email, password);

  @override
  Future<AuthUser> signUp(String email, String password) => authService.signUp(email, password);

  @override
  Future<void> logout() => authService.logout();
}