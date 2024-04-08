class Task {
  final String title;
  bool isCompleted;

  Task(this.title, {this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
