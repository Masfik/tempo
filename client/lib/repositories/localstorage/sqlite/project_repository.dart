import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/repositories/localstorage/repository.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteProjectRepository implements Repository<Project> {
  final Database _db;
  final AuthUser _user;

  final String _tableName       = 'PROJECT';
  final String _columnID        = 'project_id';
  final String _columnName      = 'project_name';
  final String _columnStartDate = 'start_date';
  final String _columnDueDate   = 'due_date';
  final String _columnUserEmail = 'user_email';

  SQLiteProjectRepository(Database database, AuthUser authUser) :
        this._db = database,
        this._user = authUser;

  @override
  Future<Project> getOne(id) async {
    List<Map> maps = await _db.query(
      _tableName,
      columns: [_columnID, _columnName, _columnStartDate, _columnDueDate],
      where: '$_columnID = ?',
      whereArgs: [id]
    );

    if (maps.length > 0) return Project.fromJson(maps.first);
    return null;
  }

  @override
  Future<List<Project>> getAll({id}) async {
    final List<Map<String, dynamic>> maps = await _db.query(_tableName);

    return List.generate(maps.length, (i) => Project(
      id: maps[i][_columnID],
      name: maps[i][_columnName],
      startDate: maps[i][_columnStartDate] != null ? DateTime.parse(maps[i][_columnStartDate]) : null,
      dueDate: maps[i][_columnDueDate] != null ? DateTime.parse(maps[i][_columnDueDate]) : null,
    ));
  }

  @override
  Future<Project> add(Project project) async {
    Map<String, dynamic> map = project.toDatabaseMap();
    map[_columnUserEmail] = _user.email;

    project.id = await _db.insert(_tableName, map);
    return project;
  }

  @override
  Future<void> update(Project project) async => await _db.update(
    _tableName,
    project.toDatabaseMap(),
    where: '$_columnID = ?',
    whereArgs: [project.id]
  );

  @override
  Future<void> delete(Project project) async => await _db.delete(
    _tableName,
    where: '$_columnID = ?',
    whereArgs: [project.id]
  );
}