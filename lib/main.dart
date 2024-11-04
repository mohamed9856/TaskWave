import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TaskWave(),
    ),
  );
}

class TaskWave extends StatelessWidget {
  const TaskWave({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
