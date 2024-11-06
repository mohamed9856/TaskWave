import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:taskwave/models/task_model.dart';

final ongoingTasksProvider = StateNotifierProvider<OngoingTasksNotifier, List<Task>>((ref) {
  return OngoingTasksNotifier();
});

final deletedTasksProvider = StateNotifierProvider<DeletedTasksNotifier, List<Task>>((ref) {
  return DeletedTasksNotifier();
});

class OngoingTasksNotifier extends StateNotifier<List<Task>> {
  OngoingTasksNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

class DeletedTasksNotifier extends StateNotifier<List<Task>> {
  DeletedTasksNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void clearTasks() {
    state.clear();
  }
}
