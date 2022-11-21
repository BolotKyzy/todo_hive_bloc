import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive_bloc/models/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('taskBox');
    await _tasks.clear();

    await _tasks.add(Task('bak', '1task1', false));
    await _tasks.add(Task('testUser', 'read', false));
    await _tasks.add(Task('bak', 'task2', true));
  }

  List<Task> getTasks(final String username) {
    final tasks =
        _tasks.values.where((element) => element.username == username);
    return tasks.toList();
  }

  void addTask(final String task, final String username) {
    _tasks.add(Task(username, task, false));
  }

  Future<void> removeTask(final String task, final String username) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.username == username);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String username,
      {final bool? completed}) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.username == username);

    final index = taskToEdit.key as int;
    await _tasks.put(
        index, Task(username, task, completed ?? taskToEdit.completed));
  }
}
