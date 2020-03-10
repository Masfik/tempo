abstract class ApiService<T> {
  String token;
  Future<T> fetchData();
}