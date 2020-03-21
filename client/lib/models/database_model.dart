mixin DatabaseModel {
  Map<String, dynamic> toDatabaseMap();
}

mixin Identity on DatabaseModel {
  dynamic get id;
}