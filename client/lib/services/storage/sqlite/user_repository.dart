import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/storage/base_repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository implements BaseRepository<User> {
  final Database _db;

  final String _tableName       = 'APP_USER';
  final String _columnEmail     = 'email';
  final String _columnFirstName = 'first_name';
  final String _columnSurname   = 'surname';

  UserRepository(Database database) : this._db = database;

  @override
  Future<User> getOne(email) async {
    List<Map> maps = await _db.query(
      _tableName,
      columns: [_columnEmail, _columnFirstName, _columnSurname],
      where: '$_columnEmail = ?',
      whereArgs: [email]
    );

    if (maps.length > 0) return User.fromJson(maps.first);
    return null;
  }

  @override
  Future<List<User>> getAll() async {
    final List<Map<String, dynamic>> maps = await _db.query(_tableName);

    return List.generate(maps.length, (i) => User(
      email: maps[i][_columnEmail],
      firstName: maps[i][_columnFirstName],
      surname: maps[i][_columnSurname]
    ));
  }

  @override
  Future<User> add(User user) async {
    await _db.insert(_tableName, user.toDatabaseMap());
    return user;
  }

  @override
  Future<void> update(User user) async => await _db.update(
    _tableName,
    user.toDatabaseMap(),
    where: '$_columnEmail = ?',
    whereArgs: [user.email]
  );

  @override
  Future<void> delete(User user) async => await _db.delete(
    _tableName,
    where: '$_columnEmail = ?',
    whereArgs: [user.email]
  );
}