import 'package:todo_with_clean_architecture/domain/repository/todo_repository.dart';

class ToggleTodo {
  final TodoRepository repository;

  ToggleTodo(this.repository);

  void call(int index) {
    repository.toggleTask(index);
  }
}
