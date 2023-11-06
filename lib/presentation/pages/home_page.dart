import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_clean_architecture/presentation/providers/todo_provider.dart';
import 'package:todo_with_clean_architecture/presentation/widgets/task_tile.dart';

class Home extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    print(todoProvider.tasks?.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              todoProvider.fetchAndAddData();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoProvider.tasks?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskTile(
            task: todoProvider.tasks![index],
            isCompleted: todoProvider.tasks![index].startsWith('[x]'),
            onDelete: () {
              todoProvider.deleteTask(index);
            },
            onToggle: () {
              todoProvider.toggleTask(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Enter task'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      todoProvider.addTask(_controller.text);
                      _controller.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
