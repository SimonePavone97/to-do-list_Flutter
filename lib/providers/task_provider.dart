import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _loadTasks();
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksString = prefs.getStringList('tasks') ?? [];
    _tasks = tasksString.map((taskString) {
      final Map<String, dynamic> taskMap = json.decode(taskString);
      return Task(taskMap['title'], isCompleted: taskMap['isCompleted']);
    }).toList();
    notifyListeners();
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksString =
    _tasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', tasksString);
  }

  void addTask(Task task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].toggleCompleted();
    _saveTasks();
    notifyListeners();
  }
}
