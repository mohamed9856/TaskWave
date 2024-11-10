import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:taskwave/models/task_model.dart';

final ongoingTasksProvider = StateNotifierProvider<OngoingTasksNotifier, List<Task>>((ref) {
  return OngoingTasksNotifier();
});

final deletedTasksProvider = StateNotifierProvider<DeletedTasksNotifier, List<Task>>((ref) {
  return DeletedTasksNotifier();
});

final completedTasksProvider = StateNotifierProvider<CompletedTasksNotifier, List<Task>>((ref) {
  return CompletedTasksNotifier();
});


class OngoingTasksNotifier extends StateNotifier<List<Task>> {
  OngoingTasksNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void editTask(String id, Task task) {
    state = state.map((t) => t.id == id ? task : t).toList();
  }

  void completeTask(Task task) {
    state = state.where((t) => t.id != task.id).toList();
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

class CompletedTasksNotifier extends StateNotifier<List<Task>> {
  CompletedTasksNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];

  }
  void editTask(String id, Task task) {
    state = state.map((t) => t.id == id ? task : t).toList();
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}