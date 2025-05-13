import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task_model.dart';

const String baseUrl = 'http://192.168.137.136:4444/api/tasks';

class TaskService {
  Future<List<Task>> getTasks() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Task.fromJson(e)).toList();
    }
    throw Exception('Failed to load tasks');
  }

  Future<Task> createTask(Task task) async {
    final res = await http.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toJson()));
    if (res.statusCode == 201) {
      return Task.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to create task');
  }

  Future<void> deleteTask(String id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 200) throw Exception('Failed to delete task');
  }
}
