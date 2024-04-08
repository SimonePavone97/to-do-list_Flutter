// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/task_list.dart';
import 'providers/task_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Task List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TaskList(),
      ),
    );
  }
}
