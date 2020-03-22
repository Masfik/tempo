import 'package:Tempo/models/location.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/services/storage/base_repository.dart';
import 'package:Tempo/utils/sqlite_functions.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepository implements BaseRepository<Task> {
  final Database _db;
  final Project _project;

  final String _tableName       = 'TASK';
  final String _columnID        = 'task_id';
  final String _columnName      = 'task_name';
  final String _columnIsDone    = 'is_done';
  final String _columnElapsed   = 'elapsed';
  final String _columnProjectID = 'project_fid';
  final String _columnLongitude = 'longitude';
  final String _columnLatitude  = 'latitude';

  TaskRepository(Database database, Project project) :
        this._db = database,
        this._project = project;

  @override
  Future<Task> getOne(id) async {
    List<Map> maps = await _db.query(
      _tableName,
      columns: [_columnID, _columnName, _columnIsDone, _columnElapsed],
      where: '$_columnID = ?',
      whereArgs: [id]
    );

    if (maps.length > 0) return Task.fromJson(maps.first);
    return null;
  }

  @override
  Future<List<Task>> getAll() async {
    final List<Map<String, dynamic>> maps = await _db.query(_tableName);

    return List.generate(maps.length, (i) {
      Task task = Task(
        id: maps[i][_columnID],
        name: maps[i][_columnName],
        isDone: fromSqlBool(maps[i][_columnIsDone]),
        initialDuration: Duration(milliseconds: maps[i]['elapsed']),
        location: Location(maps[i][_columnLatitude], maps[i][_columnLongitude])
      );

      return task;
    });
  }

  @override
  Future<Task> add(Task task) async {
    Map<String, dynamic> map = task.toDatabaseMap();
    map[_columnProjectID] = _project.id;

    task.id = await _db.insert(_tableName, map);
    return task;
  }

  @override
  Future<void> update(Task task) async => await _db.update(
    _tableName,
    {
      ...task.toDatabaseMap(),
      'is_done': toSqlBool(task.isDone)
    },
    where: '$_columnID = ?',
    whereArgs: [task.id]
  );

  @override
  Future<void> delete(Task task) async => await _db.delete(
    _tableName,
    where: '$_columnID = ?',
    whereArgs: [task.id]
  );
}