import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final DateTime createdAt;
  bool isFinished;

  Task({
    String? id,
    required this.title,
    this.isFinished = false,
  }) : id = id ?? Uuid().v4(),
        createdAt = DateTime.now();
}
