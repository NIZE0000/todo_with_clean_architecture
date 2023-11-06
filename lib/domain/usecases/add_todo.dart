import 'package:todo_with_clean_architecture/domain/repository/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  void call(String task) {
    repository.addTask(task);
  }
}
