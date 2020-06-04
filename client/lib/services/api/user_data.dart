import 'dart:convert';
import 'package:dio/dio.dart';

// TODO: this class needs to be remade from scratch
class UserDataService {
  // HTTP Client
  final _dio = Dio();

  String token;
  final _endpoint = 'http://tempo.bartstasik.com:8090/users';

  UserDataService({this.token});

  Future<Map<String, dynamic>> fetchData() async {
    if (token == null) throw 'A token is required to perform this request!';

    Response response = await _dio.get(
      _endpoint,
      //headers: <String, String>{}
    );

    if (response.statusCode != 200) return null;

    List<dynamic> body = json.decode(response.data);

    Map<String, dynamic> userBody = body.firstWhere((e) => e['email'] == token);

    return userBody;
  }

  Future<Response> sendRegisterData(String userEmail, String firstName, String surname) => _dio.post(
    _endpoint,
    options: Options(
      contentType: 'application/json'
    ),
    data: {
      "userEmail": userEmail,
      "firstName": firstName,
      "surname": surname
    }
  );
}
