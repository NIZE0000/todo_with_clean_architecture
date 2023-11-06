import 'package:todo_with_clean_architecture/domain/repository/todo_repository.dart';

class GetTodo {
  final TodoRepository repository;

  GetTodo(this.repository);

  List<String> call() {
    try {
      var tasks = repository.getTasks();
      return tasks;
    } catch (e) {
      throw Exception('Failed to get tasks: $e');
    }
  }
}
