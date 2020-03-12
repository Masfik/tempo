import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/services/api/user_data.dart';

class UserDataServiceAdapter implements ApiService {
  ApiService service;
  String _token;

  UserDataServiceAdapter({String token}) : _token = token, service = UserDataService(token: token);

  get token => _token;

  set token(String token) => _token = service.token = token;

  @override
  Future fetchData() => service.fetchData();
}
