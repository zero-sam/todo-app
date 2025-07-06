import 'package:flutter/material.dart';
import '../models/todo_item.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TodoItem todo;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onToggleDone;

  const TaskDetailsScreen({
    super.key,
    required this.todo,
    required this.onTitleChanged,
    required this.onDelete,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: todo.title);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Task Details'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                onChanged: onTitleChanged,
              ),
              const SizedBox(height: 24),
              CheckboxListTile(
                value: todo.done,
                onChanged: onToggleDone,
                title: const Text('Completed', style: TextStyle(fontSize: 18)),
                activeColor: Colors.teal,
                tileColor: Colors.white.withOpacity(0.8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}