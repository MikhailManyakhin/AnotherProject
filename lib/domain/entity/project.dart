import 'package:hive_flutter/hive_flutter.dart';
part 'project.g.dart';
@HiveType(typeId: 2)
class Project extends HiveObject{
  @HiveField(0)
  String projectTitle;
  @HiveField(1)
  bool? isDone = false;

  Project({required this.projectTitle, this.isDone});
}