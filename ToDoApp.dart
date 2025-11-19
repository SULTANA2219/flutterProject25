#todoApp

  //Simple todo App in Flutter - single file example (main.dart)
  //No database: stores todos in memory. you can hide SQLite later

  import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends
  StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
      false,
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Coders.indigo),
      home: const TodoHomePage(),
      );
  }
}

class TodoHomePage extends 
  StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _todos = [];

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _todos.add({
        'title': text,
        'done': false,
      });
    });

    _controller.clear();
  }

  void _toggleDone(int index) {
    setState(() {
      todos[index]['done'];
    });
  }

  void _removeTodo(int index) {
    setStae(() {
      _todas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Add a task",
                      border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text("Add"),
                  )
                ],
              ),
            const SizedBox(height: 20),
            Expanded(
              child: _todos.isEmpty
              ? const Center(
                child: Text(
                  "No tasks yet",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              :ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context. index) {
                  final todo = todos[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: todo['done'],
                        onChanged: (_) => _toggleDone(index),
                        ),
                      title: Text(
                        todo['title'],
                        style: TextStyle(
                          decoration: todo['done'] ? TextDecoration.lineThrough : TextDecoration.none,
                          color: todo['done'] ? Colors.grey : Colors.black,
                          ),
                        ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red), 
                        onPressed: () => _removeTodo(index),
                        ),
                      ),
                    );
                },
                ),
              )
            ],
          ),
        ),
      );
  }
}
