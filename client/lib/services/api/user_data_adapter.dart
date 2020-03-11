import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/services/api/user_data.dart';

class UserDataServiceAdapter implements ApiService {
  ApiService service;
  String token;

  UserDataServiceAdapter() : service = UserDataService();

  @override
  Future fetchData() {
    // TODO: implement fetchData
    return null;
  }

}