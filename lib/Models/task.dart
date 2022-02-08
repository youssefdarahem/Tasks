final String tableTasks = "tasks";

class TasksFields {
  static final List<String> values = [id, name, value, goalId, status];

  static final String id = "_id";
  static final String name = "_name";
  static final String value = "_value";
  static final String goalId = "_goalId";
  static final String status = "_status";
}

class Task {
  final int? id;
  final String name;
  final String value;
  final int? goalId;
  final bool? completed;

  Task(
      {this.id,
      required this.name,
      required this.value,
      this.goalId,
      this.completed});

  Task copy(
          {int? id,
          String? name,
          String? value,
          int? goalId,
          bool? completed}) =>
      Task(
          id: id ?? this.id,
          name: name ?? this.name,
          value: value ?? this.value,
          goalId: goalId ?? this.goalId,
          completed: completed ?? this.completed);

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json[TasksFields.id] as int?,
        name: json[TasksFields.name] as String,
        value: json[TasksFields.value] as String,
        goalId: json[TasksFields.goalId] as int?,
        completed: json[TasksFields.status] == 1 ? true : false,
      );

  Map<String, Object?> toJson() => {
        TasksFields.id: id,
        TasksFields.name: name,
        TasksFields.value: value,
        TasksFields.goalId: goalId,
        TasksFields.status: completed==true? 1 : 0,
      };
}
