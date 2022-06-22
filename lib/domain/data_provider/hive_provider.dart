import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vedita_learning_project/domain/entity/person.dart';
import 'package:vedita_learning_project/domain/entity/project.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/domain/entity/time_of_day_adapter.dart';

class HiveProvider {
  HiveProvider._() {
    // _registerNonBoxAdapters();
  }
  static final HiveProvider instance = HiveProvider._();


  Future<Box<Project>> openProjectBox() async {
    return await _openBox(ProjectAdapter(), 'project');
  }

  Future<Box<Person>> openPersonBox() async {
    return await _openBox(PersonAdapter(), 'person');
  }

  Future<Box<Task>> openTaskBox(int projectTitle) async {
    return await _openBox(TaskAdapter(), 'taskBox_$projectTitle');
  }

  FutureOr<Box<T>> _openBox<T>(TypeAdapter<T> typeAdapter, String name) async {
    if (!Hive.isAdapterRegistered(typeAdapter.typeId)) {
      Hive.registerAdapter<T>(typeAdapter);
    }
    return Hive.isBoxOpen(name)
        ? Hive.box<T>(name)
        : await Hive.openBox<T>(name);
  }


  closeBox(Box box) {
    box.compact();
    box.close();
  }
}
