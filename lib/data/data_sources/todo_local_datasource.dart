import 'package:hive_flutter/hive_flutter.dart';

abstract class TodoLocalDatasource {
  Future<void> init();
  List<String> getTasks();
  void addTask(String task);
  void deleteTask(int index);
  void toggleTask(int index);
}

class TodoLocalDatasourceImpl implements TodoLocalDatasource {
  late Box _taskBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('Task');
    _taskBox = Hive.box('Task');
  }

  @override
  List<String> getTasks() {
    return _taskBox.values.toList().cast<String>();
  }

  @override
  void addTask(String task) {
    final tasks = _taskBox.values.toList().cast<String>();
    _taskBox.put(tasks.length, task);
  }

  @override
  void deleteTask(int index) {
    _taskBox.deleteAt(index);
  }

  @override
  void toggleTask(int index) {
    var task = _taskBox.get(index) as String?;
    if (task != null) {
      if (task.startsWith('[x]')) {
        _taskBox.put(index, task.substring(4));
      } else {
        _taskBox.put(index, '[x] $task');
      }
    } else {
      throw Exception('Task at index $index is null');
    }
  }
}
