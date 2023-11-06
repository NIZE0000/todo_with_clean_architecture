import 'package:todo_with_clean_architecture/domain/repository/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  void call(int index) {
    repository.deleteTask(index);
  }
}
