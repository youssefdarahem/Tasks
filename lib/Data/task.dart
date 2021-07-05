final String tableTasks = "tasks";

class TasksFields {
  static final List<String> values = [id, name, value, goalId];

  static final String id = "_id";
  static final String name = "_name";
  static final String value = "_value";
  static final String goalId = "_goalId";
}

class Task {
  final int? id;
  final String name;
  final String value;
  final int? goalId;

  Task({this.id, required this.name, required this.value, this.goalId});

  Task copy({int? id, String? name, String? value, int? goalId}) => Task(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      goalId: goalId ?? this.goalId);

  static Task fromJson(Map<String, Object?> json) => Task(
      id: json[TasksFields.id] as int?,
      name: json[TasksFields.name] as String,
      value: json[TasksFields.value] as String,
      goalId: json[TasksFields.goalId] as int?);

  Map<String, Object?> toJson() => {
        TasksFields.id: id,
        TasksFields.name: name,
        TasksFields.value: value,
        TasksFields.goalId: goalId,
      };
 
}
