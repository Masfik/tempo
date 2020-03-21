abstract class Storage<T> {
  T get database;

  String get name;

  Future<Storage> init();

  Future<void> deleteStorage();

  Future<void> close();
}