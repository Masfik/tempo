import 'dart:convert';
import 'package:Tempo/services/api/api.dart';
import 'package:http/http.dart';

class UserDataService implements ApiService<Map<String, dynamic>> {
  String token;
  final _endpoint = 'https://example.com/';

  UserDataService({this.token});

  Future<Map<String, dynamic>> fetchData() async {
    if (token == null) throw 'A token is required to perform this request!';

    Response response = await get(
      _endpoint,
      //headers: <String, String>{}
    );

    await Future.delayed(Duration(seconds: 2));

    return {"first_name":"Masfik","surname":"Test","projects":[{"name":"General"},{"name":"Project Name"}]};
    if (response.statusCode != 200) return null;

    return json.decode(response.body);
  }

}