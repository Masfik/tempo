import 'dart:convert';
import 'package:Tempo/services/api/api.dart';
import 'package:http/http.dart';

class UserDataService implements ApiService<Map<String, dynamic>> {
  String token;
  final _endpoint = 'http://ec2-3-8-78-118.eu-west-2.compute.amazonaws.com:8090/users';

  UserDataService({this.token});

  Future<Map<String, dynamic>> fetchData() async {
    if (token == null) throw 'A token is required to perform this request!';

    Response response = await get(
      _endpoint,
      //headers: <String, String>{}
    );

    if (response.statusCode != 200) return null;

    List<dynamic> body = json.decode(response.body);

    Map<String, dynamic> userBody = body.firstWhere((e) => e['email'] == 'example_2@email.com');

    return userBody;
  }
}
