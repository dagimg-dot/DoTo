import 'dart:convert';

import 'package:doto/dao/task_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskDAOImpl implements TaskDAO {
  @override
  Future<int> insertTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String taskJson = json.encode(task.toJSON());
    await prefs.setString(task.id.toString(), taskJson);
    return task.id;
  }

  @override
  Future<Task> getTask(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? taskJson = prefs.getString(id.toString());
    if (taskJson == null) {
      throw Exception('Task not found');
    }
    final Map<String, dynamic> taskMap = json.decode(taskJson);
    return Task.fromJSON(taskMap);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> taskMap = prefs.getKeys().fold({}, (map, key) {
      final String? taskJson = prefs.getString(key);
      if (taskJson != null) {
        map[key] = taskJson;
      }
      return map;
    });
    taskMap.forEach((key, value) {
      final Map<String, dynamic> taskJson = json.decode(value);
      tasks.add(Task.fromJSON(taskJson));
    });

    return Future.value(tasks);
  }

  @override
  Future<int> deleteTask(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(id.toString());
    return id;
  }

  @override
  Future<bool> updateStatus(int id, int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? taskJson = prefs.getString(id.toString());
    if (taskJson == null) {
      throw Exception('Task not found');
    }
    final Map<String, dynamic> taskMap = json.decode(taskJson);
    taskMap['status'] = status;
    final String updatedTaskJson = json.encode(taskMap);
    await prefs.setString(id.toString(), updatedTaskJson);
    return true;
  }
}
