import 'package:hive/hive.dart';

part 'task_add.g.dart';

@HiveType(typeId: 0)
class TaskAdd extends HiveObject {
  @HiveField(0)
  DateTime? deadline;
  @HiveField(1)
  DateTime? time;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? title;
  @HiveField(4)
  bool? isDeadline;
  @HiveField(5)
  int? index;
}
