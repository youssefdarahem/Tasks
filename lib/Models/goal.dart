final String tableGoals = "goals";

class GoalsFields {
  static final List<String> values = [
    id,
    name,
    status,
    finishedDate,
    numOfTasks
  ];

  static final String id = "_id";
  static final String name = "_name";
  static final String status = "_status";
  static final String finishedDate = "_fDate";
  static final String numOfTasks = "_numOfTasks";
}

class Goal {
  final int? id;
  final String name;
  final String? finishedDate;
  final bool? completed;
  final int? numOfFinishedTasks;

  //List<Task>? tasks = [];

  Goal(
      {this.id,
      required this.name,
      this.completed,
      this.finishedDate,
      this.numOfFinishedTasks});

  Goal copy(
          {int? id,
          String? name,
          String? finishedDate,
          bool? completed,
          int? numOfTasks}) =>
      Goal(
        id: id ?? this.id,
        name: name ?? this.name,
        completed: completed ?? this.completed,
        finishedDate: finishedDate ?? this.finishedDate,
        numOfFinishedTasks: numOfTasks ?? this.numOfFinishedTasks,
        //tasks: tasks ?? this.tasks,
      );

  static Goal fromJson(Map<String, Object?> json) => Goal(
        id: json[GoalsFields.id] as int?,
        name: json[GoalsFields.name] as String,
        finishedDate: json[GoalsFields.finishedDate] as String?,
        completed: json[GoalsFields.status] == 1 ? true : false,
        numOfFinishedTasks: json[GoalsFields.numOfTasks] as int?,
      );

  Map<String, Object?> toJson() => {
        GoalsFields.id: id,
        GoalsFields.name: name,
        GoalsFields.finishedDate: finishedDate,
        GoalsFields.status: completed == true ? 1 : 0,
        GoalsFields.numOfTasks: numOfFinishedTasks,
      };

  // void addTask(Task task) {
  //   if (this.tasks == null) {
  //     this.tasks = [task];
  //   } else {
  //     this.tasks!.add(task);
  //   }
  // }
}
