import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/Bloc/taskNotifier.dart';
import '../Models/task.dart';
import '../Models/goal.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();

  static Database? _database;

  TasksDatabase._init();

  Status taskStatus = Status.notFetched;
  Status goalStatus = Status.notFetched;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB("tasks.db");
    return _database;
  }

  /// Create Company Tasks V2
  void _createTableTasksV2(Batch batch) {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    batch.execute('DROP TABLE IF EXISTS $tableTasks');
    batch.execute('''
    CREATE TABLE $tableTasks (
      ${TasksFields.id} $idType,
      ${TasksFields.name} TEXT,
      ${TasksFields.value} TEXT,
      ${TasksFields.goalId} NUMBER,
      ${TasksFields.status} NUMBER
    )''');
  }

  /// Create Employee Goals V2
  void _createTableGoalsV2(Batch batch) {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    batch.execute('DROP TABLE IF EXISTS $tableGoals');
    batch.execute('''
    CREATE TABLE $tableGoals (
      ${GoalsFields.id} $idType,
      ${GoalsFields.name} TEXT,
      ${GoalsFields.finishedDate} TEXT,
      ${GoalsFields.status} NUMBER, 
      ${GoalsFields.numOfTasks} NUMBER
    )''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    //print("database path : $dbPath");
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future _createDB(Database db, int version) async {
    // final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";

    // await db.execute('''
    // CREATE TABLE $tableTasks (
    //   ${TasksFields.id} $idType,
    //   ${TasksFields.name} TEXT,
    //   ${TasksFields.value} TEXT,
    //   ${TasksFields.goalId} NUMBER,
    //   ${TasksFields.status} NUMBER
    // )''');

    // await db.execute('''
    // CREATE TABLE $tableGoals (
    //   ${GoalsFields.id} $idType,
    //   ${GoalsFields.name} TEXT,
    //   ${GoalsFields.finishedDate} TEXT,
    //   ${GoalsFields.status} NUMBER,
    //   ${GoalsFields.numOfTasks} NUMBER
    // )''');
    var batch = db.batch();
    _createTableTasksV2(batch);
    _createTableGoalsV2(batch);
    await batch.commit();

    await db.insert(
        tableTasks,
        Task(
          name: "To Finish a Task",
          value: "Swipe right on the task",
          completed: false,
          goalId: -1,
        ).toJson());

    await db.insert(
        tableTasks,
        Task(
          name: "To Add a Task Or a Goal",
          value: "Tap on the adding button on the buttom right",
          completed: false,
          goalId: -1,
        ).toJson());
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    if (oldVersion == 1) {
      _createTableTasksV2(batch);
      _createTableGoalsV2(batch);
    }
    await batch.commit();
  }

  Future<Task> createTask(Task task) async {
    final db = await (instance.database);
    final id = await db!.insert(tableTasks, task.toJson());
    return task.copy(id: id);
  }

  Future<Goal> createGoal(Goal goal) async {
    final db = await (instance.database);
    final id = await db!.insert(tableGoals, goal.toJson());
    return goal.copy(id: id);
  }

  Future<Task> readTask(int id) async {
    final db = await (instance.database);

    final map = await db!.query(
      tableTasks,
      columns: TasksFields.values,
      where: "${TasksFields.id} = ?",
      whereArgs: [id],
    );

    if (map.isNotEmpty) {
      return Task.fromJson(map.first);
    } else {
      throw Exception("Task ID $id not found");
    }
  }

  Future<Goal> readGoal(int id) async {
    final db = await (instance.database);

    final map = await db!.query(
      tableGoals,
      columns: GoalsFields.values,
      where: "${GoalsFields.id} = ?",
      whereArgs: [id],
    );

    if (map.isNotEmpty) {
      return Goal.fromJson(map.first);
    } else {
      throw Exception("Goal ID $id not found");
    }
  }

  Future<List<Task>> readTasksWithGoalId(int goalId) async {
    final db = await (instance.database);
    List<Task> resultList = [];

    final result = await db!.query(
      tableTasks,
      columns: TasksFields.values,
      where: "${TasksFields.goalId} = ?",
      whereArgs: [goalId],
    );

    if (result.isNotEmpty) {
      return result.map((json) => Task.fromJson(json)).toList();
    } else {
      return resultList;
    }
  }

  Future<List<Task>> readTasksWithoutGoals() async {
    final db = await (instance.database);
    final result = await db!.query(tableTasks,
        columns: TasksFields.values, where: "${TasksFields.goalId} = -1");

    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<List<Goal>> readGoals(bool isFinished) async {
    final db = await (instance.database);

    final result = await db!.query(tableGoals,
        columns: GoalsFields.values,
        where: "${GoalsFields.status} = ${isFinished == true ? 1 : 0}");
    return result.map((json) => Goal.fromJson(json)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await (instance.database);

    return db!.update(tableTasks, task.toJson(),
        where: "${TasksFields.id} = ?", whereArgs: [task.id]);
  }

  Future<int> updateGoal(Goal goal) async {
    final db = await (instance.database);

    return db!.update(tableGoals, goal.toJson(),
        where: "${GoalsFields.id} = ?", whereArgs: [goal.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await (instance.database);
    return db!
        .delete(tableTasks, where: "${TasksFields.id} = ?", whereArgs: [id]);
  }

  Future<int> deleteTaskWithGoalId(int goalId) async {
    final db = await (instance.database);
    return db!.delete(tableTasks,
        where: "${TasksFields.goalId} = ?", whereArgs: [goalId]);
  }

  Future<int> deleteGoal(int id) async {
    final db = await (instance.database);
    int numOfDelGoals = await db!
        .delete(tableGoals, where: "${GoalsFields.id} = ?", whereArgs: [id]);
    int numOfDelTasks = await db.delete(tableTasks,
        where: "${TasksFields.goalId} = ?", whereArgs: [id]);
    return numOfDelGoals + numOfDelTasks;
  }

  Future close() async {
    final db = await (instance.database);
    db!.close();
  }
}
