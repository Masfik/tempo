import 'package:flutter/foundation.dart';

class AuthUser {
  final String id;
  final String email;
  final Future<String> token;

  AuthUser({
    @required this.id,
    @required this.email,
    @required this.token
  });
}