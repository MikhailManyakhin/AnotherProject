import 'package:hive_flutter/hive_flutter.dart';
part 'person.g.dart';
@HiveType(typeId: 1)
class Person extends HiveObject{
  @HiveField(0)
  String name;
  Person({required this.name});
}