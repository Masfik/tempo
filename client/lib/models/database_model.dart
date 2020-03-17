abstract class DatabaseModel {
  get id;

  Map<String, dynamic> toDatabaseMap();

  DatabaseModel fromDatabaseMap();
}