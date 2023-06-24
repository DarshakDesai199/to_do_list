import 'package:hive/hive.dart';
import 'package:to_do_list/service/model/task_add.dart';

class Boxes {
  static Box<TaskAdd> addTask() => Hive.box<TaskAdd>('taskAdd');
}
