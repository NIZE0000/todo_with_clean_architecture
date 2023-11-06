import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:todo_with_clean_architecture/data/models/todo_model.dart';

abstract class TodoRemoteDatasource {
  Future<TodoModel> fetchTodoData();
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  @override
  Future<TodoModel> fetchTodoData() async {
    int number = Random().nextInt(100);
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/$number'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return TodoModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
