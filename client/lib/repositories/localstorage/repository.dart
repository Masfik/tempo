import 'package:Tempo/models/database_model.dart';

abstract class Repository<T extends DatabaseModel> {
  Future<T> getOne(id);

  Future<List<T>> getAll({id});

  Future<T> add(T record);

  Future<void> update(T record);

  Future<void> delete(T record);
}