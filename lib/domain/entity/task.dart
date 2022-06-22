import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';
@HiveType(typeId: 3)
class Task extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  TimeOfDay taskStartTime;
  @HiveField(2)
  TimeOfDay taskEndTime;
  @HiveField(3)
  String? description;
  @HiveField(4)
  bool? isDone = false;
  @HiveField(5)
  TaskTypes type;
  @HiveField(6)
  DateTime dateTime;

  Task(
      {this.isDone,
      required this.title,
      required this.taskStartTime,
      required this.taskEndTime,
      required this.dateTime,
      this.description,
      required this.type});

  int durationMinutes(){
    return (taskEndTime.hour - taskStartTime.hour) * 60 +
        (taskEndTime.minute - taskStartTime.minute);
  }
}

@HiveType(typeId: 4)
enum TaskTypes {
  @HiveField(0)
  design,
  @HiveField(1)
  meeting,
  @HiveField(2)
  coding,
  @HiveField(3)
  BDE,
  @HiveField(4)
  testing,
  @HiveField(5)
  quickCall
}
