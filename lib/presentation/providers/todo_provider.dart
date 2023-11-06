import 'package:flutter/material.dart';
import 'package:todo_with_clean_architecture/data/data_sources/todo_local_datasource.dart';
import 'package:todo_with_clean_architecture/data/data_sources/todo_remote_datasource.dart';
import 'package:todo_with_clean_architecture/data/repository/todo_repository_impl.dart';
import 'package:todo_with_clean_architecture/domain/usecases/add_todo.dart';
import 'package:todo_with_clean_architecture/domain/usecases/delete_todo.dart';
import 'package:todo_with_clean_architecture/domain/usecases/fetch_and_add_data.dart';
import 'package:todo_with_clean_architecture/domain/usecases/get_todo.dart';
import 'package:todo_with_clean_architecture/domain/usecases/toggle_todo.dart';

class TodoProvider extends ChangeNotifier {
  late TodoRepositoryImpl _todoRepository;

  List<String>? tasks = [];

  TodoProvider({this.tasks}) {
    final TodoLocalDatasource localDatasource = TodoLocalDatasourceImpl();
    final TodoRemoteDatasource remoteDatasource = TodoRemoteDatasourceImpl();

    _todoRepository = TodoRepositoryImpl(
      localDatasource: localDatasource,
      remoteDatasource: remoteDatasource,
    );
    _init();
  }

  Future<void> _init() async {
    await _todoRepository.init();
    tasks = GetTodo(_todoRepository).call();
    notifyListeners();
  }

  void addTask(String task) {
    AddTodo addTodo = AddTodo(_todoRepository);
    addTodo.call(task);
    tasks = GetTodo(_todoRepository).call();
    notifyListeners();
  }

  void deleteTask(int index) {
    DeleteTodo deleteTodo = DeleteTodo(_todoRepository);
    deleteTodo.call(index);
    tasks = GetTodo(_todoRepository).call();
    notifyListeners();
  }

  void toggleTask(int index) {
    ToggleTodo toggleTodo = ToggleTodo(_todoRepository);
    toggleTodo.call(index);
    tasks = GetTodo(_todoRepository).call();
    notifyListeners();
  }

  Future<void> fetchAndAddData() async {
    try {
      FetchAndAddData fetchAndAddData = FetchAndAddData(_todoRepository);
      await fetchAndAddData.call();
      tasks = GetTodo(_todoRepository).call();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
