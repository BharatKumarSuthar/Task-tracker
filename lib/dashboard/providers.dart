import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/repositery/fetch_tasks.dart';
import 'package:task_tracker/utils/const.dart';
import 'task_model.dart';

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier() : super([]) {
    fetchTasks(); // fetch on app start
  }

  Future<void> fetchTasks() async {
    state = await getTasks();
  }

  void addTask(TaskModel task) {
    state = [...state, task];
  }

  void removeTask(String title) {
    state = state.where((t) => t.title != title).toList();
  }

  void markAsCompleted(String value, int index) {
    if (index < 0 || index >= state.length) return;
    final updated = state[index].copyWith(status: "Completed");
    final updatedList = [...state];
    updatedList[index] = updated;
    state = updatedList;
  }

  void updateTask(TaskModel model, int index) {
    if (index < 0 || index >= state.length) return;

    final newList = [...state];
    newList[index] = model;
    state = newList;
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<TaskModel>>((
  ref,
) {
  return TaskNotifier();
});

//user name provider
final nameProvider = FutureProvider((ref) async {
  final name = await SharedPreferences.getInstance();
  return name.getString(USER);
});

//
