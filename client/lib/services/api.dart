import 'dart:convert';
import 'package:http/http.dart';

class ApiService {
  final _endpoint = 'https://lalala.free.beeceptor.com';

  Future<Map<String, dynamic>> fetchUserData() async {
    Response response = await get(
      _endpoint,
      //headers: <String, String>{}
    );
    if (response.statusCode != 200) return null;

    return json.decode(response.body);
  }
}