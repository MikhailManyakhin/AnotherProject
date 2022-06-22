import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/domain/entity/time_of_day_adapter.dart';
import 'package:vedita_learning_project/ui/my_app.dart';

void main() async {
  Hive.registerAdapter(TaskTypesAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.initFlutter();
  runApp(const MyApp());
}
