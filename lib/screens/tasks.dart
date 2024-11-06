import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskwave/models/task_model.dart';
import 'package:taskwave/providers/tasks_provider.dart';
import 'package:taskwave/screens/view_task.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  bool showDeletedTasks = false;

  @override
  Widget build(BuildContext context) {
    final ongoingTasks = ref.watch(ongoingTasksProvider);
    final finishedTasks = ref.watch(deletedTasksProvider);
    final addTitleController = TextEditingController();

    void deleteTask(Task task) {
      setState(() {
        ref.read(deletedTasksProvider.notifier).addTask(task);
        ref.read(ongoingTasksProvider.notifier).removeTask(task.id);
      });
    }

    void toggleTaskCompletion(Task task) {
      setState(() {
        task.isFinished = !task.isFinished;
      });
    }

    void deleteAllTasks() {
      setState(() {
        ref.read(deletedTasksProvider.notifier).clearTasks();
      });
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.incomplete_circle),
              title: Text('Ongoing Tasks'),
              onTap: () {
                setState(() {
                  showDeletedTasks = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Deleted Tasks'),
              onTap: () {
                setState(() {
                  showDeletedTasks = true;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'TaskWave',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 5,
        backgroundColor: Colors.blue,
        actions: [
          if (showDeletedTasks)
            TextButton(
              onPressed: deleteAllTasks,
              child: Text(
                'Delete All',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add New Task"),
                content: TextField(
                  controller: addTitleController,
                  decoration: InputDecoration(
                    hintText: "Enter task details",
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        final newTask = Task(
                          id: DateTime.now().toString(),
                          title: addTitleController.text,
                        );
                        ongoingTasks.add(newTask);
                      });
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount:
            showDeletedTasks ? finishedTasks.length : ongoingTasks.length,
        itemBuilder: (context, index) {
          final task =
              showDeletedTasks ? finishedTasks[index] : ongoingTasks[index];
          if (showDeletedTasks) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isFinished,
                      onChanged: (bool? value) {
                        toggleTaskCompletion(task);
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewTask(task: task),
                            ),
                          );
                        },
                        child: Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  task.isFinished ? Colors.grey : Colors.white,
                              decoration: task.isFinished
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Dismissible(
            key: ValueKey(task.id),
            onDismissed: (direction) {
              deleteTask(task);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isFinished,
                      onChanged: (bool? value) {
                        toggleTaskCompletion(task);
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewTask(task: task),
                            ),
                          );
                        },
                        child: Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  task.isFinished ? Colors.grey : Colors.white,
                              decoration: task.isFinished
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
