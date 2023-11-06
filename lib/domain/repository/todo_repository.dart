abstract class TodoRepository {
  Future<void> init();
  List<String> getTasks();
  void addTask(String task);
  void deleteTask(int index);
  void toggleTask(int index);
  Future<void> fetchAndAddData();
}
