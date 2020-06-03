import 'dart:convert';
import 'package:Tempo/services/api/api.dart';
import 'package:dio/dio.dart';

class UserDataService implements ApiService<Map<String, dynamic>> {
  String token;
  final _endpoint = 'http://tempo.bartstasik.com:8090/users';

  UserDataService({this.token});

  Future<Map<String, dynamic>> fetchData() async {
    if (token == null) throw 'A token is required to perform this request!';

    Response response = await Dio().get(
      _endpoint,
      //headers: <String, String>{}
    );

    if (response.statusCode != 200) return null;

    List<dynamic> body = json.decode(response.data);

    Map<String, dynamic> userBody = body.firstWhere((e) => e['email'] == token);

    return userBody;
  }
}
