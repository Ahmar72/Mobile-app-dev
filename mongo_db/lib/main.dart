import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task App', debugShowCheckedModeBanner: false, home: TaskPage());
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _service = TaskService();
  final _controller = TextEditingController();
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _service.getTasks();
  }

  void _refreshTasks() {
    setState(() {
      _tasks = _service.getTasks();
    });
  }

  void _addTask() async {
    if (_controller.text.trim().isEmpty) return;
    await _service.createTask(Task(title: _controller.text));
    _controller.clear();
    _refreshTasks();
  }

  void _deleteTask(String id) async {
    await _service.deleteTask(id);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'New Task'),
                ),
              ),
              ElevatedButton(onPressed: _addTask, child: Text('Add'))
            ]),
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _tasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final tasks = snapshot.data!;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(tasks[i].title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(tasks[i].id!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
