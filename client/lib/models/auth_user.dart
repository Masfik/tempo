import 'package:flutter/foundation.dart';

class AuthUser {
  final String id;
  final String email;
  String token;

  AuthUser({
    @required this.id,
    @required this.email,
    @required Future<String> token
  }) {
    token.then((value) => this.token = value); // Performs the Future to obtain the token
  }
}