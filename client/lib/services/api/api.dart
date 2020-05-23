abstract class ApiService<T> {
  String get token;

  set token(String token);

  Future<T> fetchData();
}
