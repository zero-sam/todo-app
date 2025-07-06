import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_screen.dart';
import 'screens/task_details_screen.dart';
import 'screens/settings_screen.dart';
import 'models/todo_item.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<TodoItem> _todos = [];
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      final List decoded = jsonDecode(todosString);
      setState(() {
        _todos = decoded.map((e) => TodoItem.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', jsonEncode(_todos.map((e) => e.toJson()).toList()));
  }

  void _addTodo(String title, DateTime? date) {
    setState(() {
      _todos.insert(0, TodoItem(title: title, date: date));
    });
    _saveTodos();
  }

  void _toggleTodo(TodoItem todo) {
    setState(() {
      todo.done = !todo.done;
    });
    _saveTodos();
  }

  void _editTodoTitle(TodoItem todo, String newTitle) {
    setState(() {
      todo.title = newTitle;
    });
    _saveTodos();
  }

  void _deleteTodo(TodoItem todo) {
    setState(() {
      _todos.remove(todo);
    });
    _saveTodos();
  }

  void _clearAllTodos() {
    setState(() {
      _todos.clear();
    });
    _saveTodos();
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(
        todos: _todos,
        onTap: (todo) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskDetailsScreen(
                todo: todo,
                onTitleChanged: (newTitle) => _editTodoTitle(todo, newTitle),
                onDelete: () {
                  _deleteTodo(todo);
                  Navigator.pop(context);
                },
                onToggleDone: (_) {
                  _toggleTodo(todo);
                  Navigator.pop(context);
                },
              ),
            ),
          ).then((_) => setState(() {}));
        },
        onAdd: () async {
          final controller = TextEditingController();
          DateTime? selectedDate;
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setStateDialog) {
                  return AlertDialog(
                    title: const Text('Add New Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller,
                          autofocus: true,
                          decoration: const InputDecoration(hintText: 'Enter your task...'),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(selectedDate == null
                                ? 'No date chosen'
                                : 'Date: \\${selectedDate!.toLocal().toString().split(' ')[0]}'),
                            const Spacer(),
                            TextButton(
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  setStateDialog(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              child: const Text('Pick Date'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.text.trim().isNotEmpty) {
                            _addTodo(controller.text.trim(), selectedDate);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        onSettings: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SettingsScreen(
                onClearAll: () {
                  _clearAllTodos();
                  Navigator.pop(context);
                },
                onLogout: () async {
                  await _logout();
                  setState(() {});
                  Navigator.pop(context);
                },
                userName: _user?.displayName ?? '',
              ),
            ),
          );
        },
      ),
    );
  }
}