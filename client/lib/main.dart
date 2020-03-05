import 'package:Tempo/models/project.dart';
import 'package:Tempo/ui/tempo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(
  ChangeNotifierProvider<User>(
    create: (context) => User(firstName: 'Rick ', surname: 'Sanchez', email: 'rick@sanchez.com'),
    child: Tempo(),
  )
);
