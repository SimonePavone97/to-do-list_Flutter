import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasks[index];
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                taskProvider.toggleTaskCompletion(index);
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                taskProvider.deleteTask(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTaskTitle = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String enteredTitle = '';

              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Task Title'),
                  onChanged: (value) {
                    enteredTitle = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, enteredTitle);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
          if (newTaskTitle != null && newTaskTitle.isNotEmpty) {
            taskProvider.addTask(Task(newTaskTitle));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
