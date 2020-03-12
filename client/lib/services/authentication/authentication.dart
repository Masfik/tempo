abstract class AuthService<U> {
  Stream<U> get user;

  Future<U> signIn(String email, String password);

  Future<U> signUp(String email, String password);

  Future<void> logout();
}
