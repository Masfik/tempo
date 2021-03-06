import 'package:Tempo/models/location.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/repositories/localstorage/repository.dart';
import 'package:Tempo/utils/sqlite_functions.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteTaskRepository implements Repository<Task> {
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

  SQLiteTaskRepository(Database database, Project project) :
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

    if (maps.length > 0) return Task.fromJson({
      ...maps.first,
      _columnIsDone: fromSqlBool(maps.first[_columnIsDone])
    });
    return null;
  }

  @override
  Future<List<Task>> getAll({id}) async {
    List<Map<String, dynamic>> maps;
    if (id == null) maps = await _db.query(_tableName);
    else maps = await _db.query(_tableName, where: '$_columnProjectID = ?', whereArgs: [id]);

    return List.generate(maps.length, (i) => Task(
      id: maps[i][_columnID],
      name: maps[i][_columnName],
      isDone: fromSqlBool(maps[i][_columnIsDone]),
      initialDuration: Duration(milliseconds: maps[i]['elapsed']),
      location: (maps[i][_columnLatitude] != null)
          ? Location(maps[i][_columnLatitude], maps[i][_columnLongitude])
          : null
    ));
  }

  @override
  Future<Task> add(Task task) async {
    task.id = await _db.insert(_tableName, {
      ..._toSqlDbMap(task),
      _columnProjectID: _project.id
    });
    return task;
  }

  @override
  Future<void> update(Task task) async => await _db.update(
    _tableName,
    _toSqlDbMap(task),
    where: '$_columnID = ?',
    whereArgs: [task.id]
  );

  @override
  Future<void> delete(Task task) async => await _db.delete(
    _tableName,
    where: '$_columnID = ?',
    whereArgs: [task.id]
  );

  Map<String, dynamic> _toSqlDbMap(Task task) => {
    ...task.toDatabaseMap(),
    _columnIsDone: toSqlBool(task.isDone)
  };
}