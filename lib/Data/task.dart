



final String tableTasks = "tasks";

class TasksFields {
  static final List<String> values = [id, name, value];

  static final String id = "_id";
  static final String name = "_name";
  static final String value = "_value";
}

class Task {
  final int id;
  final String name;
  final String value;

  Task({this.id, this.name, this.value});

  Task copy({int id, String name, String value}) => Task(
      id: id ?? this.id, name: name ?? this.name, value: value ?? this.value);

  static Task fromJson(Map<String, Object> json) =>  Task(
      id: json[TasksFields.id] as int,
      name: json[TasksFields.name] as String,
      value: json[TasksFields.value] as String);

  Map<String, Object> toJson() => {
        TasksFields.id: id,
        TasksFields.name: name,
        TasksFields.value: value,
      };
  // static List<Task> fetchTasks() {
  //   return [
  //     Task.parameters("Task 1", "This is so Important"),
  //     Task.parameters("Task2", "Still kinda important"),
  //     Task.parameters("Task 1", "This is so Important"),
  //     Task.parameters("Task2", "Still kinda important"),
  //     Task.parameters("Task 1", "This is so Important"),
  //     Task.parameters("Task2", "Still kinda important"),
  //     Task.parameters("Task 1", "This is so Important"),
  //     Task.parameters("Task2", "Still kinda important"),
  //     Task.parameters("Task 1", "This is so Important"),
  //     Task.parameters("Task2", "Still kinda important"),
  //   ];
  // }
}
