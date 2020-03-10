import 'dart:convert';
import 'package:Tempo/services/api/api.dart';
import 'package:http/http.dart';

class UserDataService implements ApiService<Map<String, dynamic>> {
  String token;
  final _endpoint = 'https://example.com/';

  UserDataService({this.token});

  Future<Map<String, dynamic>> fetchData() async {
    if (token == null) return null;

    Response response = await get(
      _endpoint,
      //headers: <String, String>{}
    );
    return {"first_name":"Masfik","surname":"Test","projects":[{"name":"General"},{"name":"Project Name"}]};

    if (response.statusCode != 200) return null;

    return json.decode(response.body);
  }

}