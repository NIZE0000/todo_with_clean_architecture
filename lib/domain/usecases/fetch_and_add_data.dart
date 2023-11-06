import 'package:todo_with_clean_architecture/domain/repository/todo_repository.dart';

class FetchAndAddData {
  final TodoRepository repository;

  FetchAndAddData(this.repository);

  Future<void> call() async {
    try {
      await repository.fetchAndAddData();
    } catch (e) {
      throw Exception('Failed to fetch and add data: $e');
    }
  }
}
