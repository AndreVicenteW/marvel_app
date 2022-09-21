abstract class LocalDatabaseService<T> {
  Future<List<T>> getAll();
  Future<void> insert(T object);
  Future<void> delete(T object);
}