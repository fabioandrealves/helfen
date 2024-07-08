abstract class DAO<T> {
  Future<bool> create(T value);
  Future<T?> findOne(int value);
  Future<List<T>> findAll();
  Future<bool> update(T value);
  Future<bool> delete(int value);
}
