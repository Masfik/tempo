import 'package:Tempo/models/project.dart';
import 'package:Tempo/services/storage/base_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProjectRepository implements BaseRepository<Project> {
  final Database _db;

  final String _tableName       = 'PROJECT';
  final String _columnID        = 'project_id';
  final String _columnName      = 'project_name';
  final String _columnStartDate = 'start_date';
  final String _columnDueDate   = 'due_date';
  final String _columnUserID    = 'user_email'; // TODO: check

  ProjectRepository(Database database) : this._db = database;

  @override
  Future<Project> getOne(id) async {
    List<Map> maps = await _db.query(
      _tableName,
      columns: [_columnID, _columnName, _columnStartDate, _columnDueDate, _columnUserID],
      where: '$_columnID = ?',
      whereArgs: [id]
    );

    if (maps.length > 0) return Project.fromJson(maps.first);
    return null;
  }

  @override
  Future<List<Project>> getAll() async {
    final List<Map<String, dynamic>> maps = await _db.query(_tableName);

    return List.generate(maps.length, (i) => Project(
      id: maps[i][_columnID],
      name: maps[i][_columnName],
      startDate: maps[i][_columnStartDate],
      dueDate: maps[i][_columnDueDate]
    ));
  }

  @override
  Future<Project> add(Project project) async {
    // TODO: user_email foreign key
    project.id = await _db.insert(_tableName, project.toDatabaseMap());
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