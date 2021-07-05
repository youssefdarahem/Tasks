import 'package:tasks/Data/task.dart';

final String tableGoals = "goals";

class GoalsFields {
  static final List<String> values = [id, name];

  static final String id = "_id";
  static final String name = "_name";
}

class Goal {
  final int? id;
  final String name;
  final List<Task>? tasks;


  

  

  Goal({this.id, required this.name, this.tasks});

  Goal copy({int? id, String? name, List<Task>? tasks}) => Goal(
        id: id ?? this.id,
        name: name ?? this.name,
        tasks: tasks ?? this.tasks,
      );

  static Goal fromJson(Map<String, Object?> json) => Goal(
        id: json[TasksFields.id] as int?,
        name: json[TasksFields.name] as String,
      );

  Map<String, Object?> toJson() => {
        GoalsFields.id: id,
        GoalsFields.name: name,
      };
}
