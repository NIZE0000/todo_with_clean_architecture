import 'package:todo_with_clean_architecture/data/data_sources/todo_local_datasource.dart';
import 'package:todo_with_clean_architecture/data/data_sources/todo_remote_datasource.dart';
import 'package:todo_with_clean_architecture/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  late TodoLocalDatasource _localDatasource;
  late TodoRemoteDatasource _remoteDatasource;

  TodoRepositoryImpl({
    required TodoLocalDatasource localDatasource,
    required TodoRemoteDatasource remoteDatasource,
  }) {
    _localDatasource = localDatasource;
    _remoteDatasource = remoteDatasource;
  }

  @override
  Future<void> init() async {
    await _localDatasource.init();
  }

  @override
  List<String> getTasks() {
    return _localDatasource.getTasks();
  }

  @override
  void addTask(String task) {
    _localDatasource.addTask(task);
  }

  @override
  void deleteTask(int index) {
    _localDatasource.deleteTask(index);
  }

  @override
  void toggleTask(int index) {
    _localDatasource.toggleTask(index);
  }

  @override
  Future<void> fetchAndAddData() async {
    try {
      final todo = await _remoteDatasource.fetchTodoData();
      addTask(todo.title as String);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
