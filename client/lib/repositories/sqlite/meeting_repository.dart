import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/repositories/base_repository.dart';
import 'package:sqflite/sqflite.dart';

class MeetingRepository implements BaseRepository<Meeting> {
  Database _db;

  MeetingRepository(Database database) : this._db = database;

  @override
  Future<Meeting> getOne(id) {
    // TODO: implement getOne
    return null;
  }

  @override
  Future<List<Meeting>> getAll() {
    // TODO: implement getAll
    return null;
  }

  @override
  Future<Meeting> add(Meeting record) {
    // TODO: implement add
    return null;
  }

  @override
  Future<void> update(Meeting record) {
    // TODO: implement update
    return null;
  }

  @override
  Future<void> delete(Meeting record) {
    // TODO: implement delete
    return null;
  }
}