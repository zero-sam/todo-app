import 'package:flutter/material.dart';
import '../models/todo_item.dart';

class HomeScreen extends StatelessWidget {
  final List<TodoItem> todos;
  final Function(TodoItem) onTap;
  final VoidCallback onAdd;
  final VoidCallback onSettings;

  const HomeScreen({
    super.key,
    required this.todos,
    required this.onTap,
    required this.onAdd,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
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
          title: const Text('My Todos',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: onSettings,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text('Add Task'),
          backgroundColor: Colors.tealAccent,
        ),
        body: todos.isEmpty
            ? const Center(
                child: Text(
                  'No tasks yet! Tap + to add.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: todo.done ? Colors.teal[100] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(
                        todo.done
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: todo.done ? Colors.teal : Colors.grey,
                        size: 28,
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration:
                              todo.done ? TextDecoration.lineThrough : null,
                          color:
                              todo.done ? Colors.teal : Colors.black87,
                        ),
                      ),
                      onTap: () => onTap(todo),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
