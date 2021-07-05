import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/Data/task.dart';
import 'package:tasks/Data/goal.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();

  static Database? _database;

  TasksDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB("tasks.db");
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";

    await db.execute('''
    CREATE TABLE $tableTasks (
      ${TasksFields.id} $idType,
      ${TasksFields.name} TEXT,
      ${TasksFields.value} TEXT,
      ${TasksFields.goalId} NUMBER 
    )''');

    await db.execute('''
    CREATE TABLE $tableGoals (
      ${GoalsFields.id} $idType,
      ${GoalsFields.name} TEXT,
      
    )''');
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

  Future<List<Task>> readTaskWithGoalId(int goalId) async {
    final db = await (instance.database);

    final result = await db!.query(
      tableTasks,
      columns: TasksFields.values,
      where: "${TasksFields.goalId} = ?",
      whereArgs: [goalId],
    );

    if (result.isNotEmpty) {
      return result.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception("ID $goalId not found");
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await (instance.database);

    final result = await db!.query(tableTasks);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<List<Goal>> readAllGoals() async {
    final db = await (instance.database);

    final result = await db!.query(tableGoals);
    return result.map((json) => Goal.fromJson(json)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await (instance.database);

    return db!.update(tableTasks, task.toJson(),
        where: "${TasksFields.id} = ?", whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await (instance.database);
    return db!
        .delete(tableTasks, where: "${TasksFields.id} = ?", whereArgs: [id]);
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
