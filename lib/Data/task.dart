class Task {
  String name;
  String value;
  Task();
  Task.parameters(this.name, this.value);

  static List<Task> fetchTasks() {
    return [
      Task.parameters("Task 1", "This is so Important"),
      Task.parameters("Task2", "Still kinda important"),
      Task.parameters("Task 1", "This is so Important"),
      Task.parameters("Task2", "Still kinda important"),
      Task.parameters("Task 1", "This is so Important"),
      Task.parameters("Task2", "Still kinda important"),
      Task.parameters("Task 1", "This is so Important"),
      Task.parameters("Task2", "Still kinda important"),
      Task.parameters("Task 1", "This is so Important"),
      Task.parameters("Task2", "Still kinda important"),
    ];
  }
}
